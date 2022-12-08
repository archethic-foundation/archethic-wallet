/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/infrastructure/datasources/hive_vault.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/intro/intro_configure_security.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroBackupConfirm extends ConsumerStatefulWidget {
  const IntroBackupConfirm({required this.name, required this.seed, super.key});
  final String? name;
  final String? seed;

  @override
  ConsumerState<IntroBackupConfirm> createState() => _IntroBackupConfirmState();
}

class _IntroBackupConfirmState extends ConsumerState<IntroBackupConfirm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> wordListSelected = List<String>.empty(growable: true);
  List<String> wordListToSelect = List<String>.empty(growable: true);
  List<String> originalWordsList = List<String>.empty(growable: true);

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;
  bool keychainAccessRequested = false;
  bool newWalletRequested = false;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) async {
      await createKeychain();
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      final localizations = AppLocalization.of(context)!;
      final theme = ref.watch(ThemeProviders.selectedTheme);
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        UIUtil.showSnackbar(
          '${localizations.sendError} (${event.response!})',
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop(false);
        return;
      }

      if (event.response != 'ok' ||
          !TransactionConfirmation.isEnoughConfirmations(
            event.nbConfirmations!,
            event.maxConfirmations!,
          )) {
        UIUtil.showSnackbar(
          localizations.notEnoughConfirmations,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
        );
        Navigator.of(context).pop();
        return;
      }

      switch (event.transactionType!) {
        case TransactionSendEventType.keychain:
          UIUtil.showSnackbar(
            event.nbConfirmations == 1
                ? localizations.keychainCreationTransactionConfirmed1
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString())
                : localizations.keychainCreationTransactionConfirmed
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString()),
            context,
            ref,
            theme.text!,
            theme.snackBarShadow!,
            duration: const Duration(milliseconds: 5000),
          );

          if (keychainAccessRequested) break;

          setState(() {
            keychainAccessRequested = true;
          });
          await KeychainUtil().createKeyChainAccess(
            ref.read(SettingsProviders.settings).network,
            widget.seed,
            widget.name,
            event.params!['keychainAddress']! as String,
            event.params!['originPrivateKey']! as String,
            event.params!['keychain']! as Keychain,
          );
          break;
        case TransactionSendEventType.keychainAccess:
          UIUtil.showSnackbar(
            event.nbConfirmations == 1
                ? localizations.keychainAccessCreationTransactionConfirmed1
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString())
                : localizations.keychainAccessCreationTransactionConfirmed
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString()),
            context,
            ref,
            theme.text!,
            theme.snackBarShadow!,
            duration: const Duration(milliseconds: 5000),
          );

          if (newWalletRequested) break;

          setState(() {
            newWalletRequested = true;
          });
          var error = false;
          try {
            await ref
                .read(SessionProviders.session.notifier)
                .createNewAppWallet(
                  seed: widget.seed!,
                  keychainAddress: event.params!['keychainAddress']! as String,
                  keychain: event.params!['keychain']! as Keychain,
                  name: widget.name,
                );
          } catch (e) {
            error = true;
            UIUtil.showSnackbar(
              '${localizations.sendError} ($e)',
              context,
              ref,
              theme.text!,
              theme.snackBarShadow!,
            );
          }
          if (error == false) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/home',
              (Route<dynamic> route) => false,
            );
          } else {
            Navigator.of(context).pop();
          }
          break;
        case TransactionSendEventType.transfer:
          break;
        case TransactionSendEventType.token:
          break;
      }
    });
  }

  void _destroyBus() {
    _authSub?.cancel();
    _sendTxSub?.cancel();
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    // TODO(reddwarf03): LanguageSeed seems to be local to "import wallet" and "create wallet" screens. Maybe it should not be stored in preferences ? (3)
    final languageSeed = ref.read(
      SettingsProviders.settings.select((settings) => settings.languageSeed),
    );
    wordListToSelect = AppMnemomics.seedToMnemonic(
      widget.seed!,
      languageCode: languageSeed,
    );
    wordListToSelect.sort(
      (a, b) => a.compareTo(b),
    );
    originalWordsList = AppMnemomics.seedToMnemonic(
      widget.seed!,
      languageCode: languageSeed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.read(SettingsProviders.settings);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background3Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[theme.backgroundDark!, theme.background!],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 15),
                      height: 50,
                      width: 50,
                      child: BackButton(
                        key: const Key('back'),
                        color: theme.text,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ArchethicScrollbar(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            start: 20,
                            end: 20,
                          ),
                          alignment: AlignmentDirectional.centerStart,
                          child: AutoSizeText(
                            localizations.confirmSecretPhrase,
                            style: theme.textStyleSize24W700EquinoxPrimary,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            start: 20,
                            end: 20,
                            top: 15,
                          ),
                          child: AutoSizeText(
                            localizations.confirmSecretPhraseExplanation,
                            style: theme.textStyleSize14W600Primary,
                            textAlign: TextAlign.justify,
                            maxLines: 6,
                            stepGranularity: 0.5,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            start: 20,
                            end: 20,
                            top: 15,
                          ),
                          child: Wrap(
                            spacing: 10,
                            children: wordListSelected
                                .asMap()
                                .entries
                                .map((MapEntry entry) {
                              return SizedBox(
                                height: 35,
                                child: Chip(
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.grey.shade800,
                                    child: Text(
                                      (entry.key + 1).toString(),
                                      style: theme.textStyleSize12W100Primary60,
                                    ),
                                  ),
                                  label: Text(
                                    entry.value,
                                    style: theme.textStyleSize12W400Primary,
                                  ),
                                  onDeleted: () {
                                    setState(() {
                                      wordListToSelect.add(entry.value);
                                      wordListSelected.removeAt(entry.key);
                                    });
                                  },
                                  deleteIconColor: Colors.white,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Divider(
                          height: 15,
                          color: theme.text60,
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            start: 20,
                            end: 20,
                            top: 15,
                          ),
                          child: Wrap(
                            spacing: 10,
                            children: wordListToSelect
                                .asMap()
                                .entries
                                .map((MapEntry entry) {
                              return SizedBox(
                                height: 35,
                                child: GestureDetector(
                                  onTap: () {
                                    wordListSelected.add(entry.value);
                                    wordListToSelect.removeAt(entry.key);
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(
                                      entry.value,
                                      style: theme.textStyleSize12W400Primary,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (settings.network.network ==
                    AvailableNetworks.archethicTestNet)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          if (wordListSelected.length != 24)
                            AppButtonTiny(
                              AppButtonTinyType.primaryOutline,
                              localizations.confirm,
                              Dimens.buttonTopDimens,
                              key: const Key('confirm'),
                              onPressed: () {},
                            )
                          else
                            AppButtonTiny(
                              AppButtonTinyType.primary,
                              localizations.confirm,
                              Dimens.buttonTopDimens,
                              key: const Key('confirm'),
                              onPressed: () async {
                                var orderOk = true;

                                for (var i = 0;
                                    i < originalWordsList.length;
                                    i++) {
                                  if (originalWordsList[i] !=
                                      wordListSelected[i]) {
                                    orderOk = false;
                                  }
                                }
                                if (orderOk == false) {
                                  setState(() {
                                    UIUtil.showSnackbar(
                                      localizations.confirmSecretPhraseKo,
                                      context,
                                      ref,
                                      theme.text!,
                                      theme.snackBarShadow!,
                                    );
                                  });
                                } else {
                                  await _launchSecurityConfiguration(
                                    widget.name!,
                                    widget.seed!,
                                  );
                                }
                              },
                            ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          AppButtonTiny(
                            AppButtonTinyType.primary,
                            localizations.pass,
                            Dimens.buttonBottomDimens,
                            key: const Key('pass'),
                            onPressed: () {
                              AppDialogs.showConfirmDialog(
                                context,
                                ref,
                                localizations.passBackupConfirmationDisclaimer,
                                localizations.passBackupConfirmationMessage,
                                localizations.yes,
                                () async {
                                  await _launchSecurityConfiguration(
                                    widget.name!,
                                    widget.seed!,
                                  );
                                },
                                titleStyle:
                                    theme.textStyleSize14W600EquinoxPrimaryRed,
                                additionalContent:
                                    localizations.archethicDoesntKeepCopy,
                                additionalContentStyle:
                                    theme.textStyleSize12W300PrimaryRed,
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  )
                else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          if (wordListSelected.length != 24)
                            AppButtonTiny(
                              AppButtonTinyType.primaryOutline,
                              localizations.confirm,
                              Dimens.buttonBottomDimens,
                              key: const Key('confirm'),
                              onPressed: () {},
                            )
                          else
                            AppButtonTiny(
                              AppButtonTinyType.primary,
                              localizations.confirm,
                              Dimens.buttonBottomDimens,
                              key: const Key('confirm'),
                              onPressed: () async {
                                var orderOk = true;

                                for (var i = 0;
                                    i < originalWordsList.length;
                                    i++) {
                                  if (originalWordsList[i] !=
                                      wordListSelected[i]) {
                                    orderOk = false;
                                  }
                                }
                                if (orderOk == false) {
                                  setState(() {
                                    UIUtil.showSnackbar(
                                      localizations.confirmSecretPhraseKo,
                                      context,
                                      ref,
                                      theme.text!,
                                      theme.snackBarShadow!,
                                    );
                                  });
                                } else {
                                  await _launchSecurityConfiguration(
                                    widget.name!,
                                    widget.seed!,
                                  );
                                }
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _launchSecurityConfiguration(String name, String seed) async {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final biometricsAvalaible = await sl.get<BiometricUtil>().hasBiometrics();
    final accessModes = <PickerItem>[
      PickerItem(
        const AuthenticationMethod(AuthMethod.pin).getDisplayName(context),
        const AuthenticationMethod(AuthMethod.pin).getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.pin),
        theme.pickerItemIconEnabled,
        AuthMethod.pin,
        true,
      ),
      PickerItem(
        const AuthenticationMethod(AuthMethod.password).getDisplayName(context),
        const AuthenticationMethod(AuthMethod.password).getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.password),
        theme.pickerItemIconEnabled,
        AuthMethod.password,
        true,
      )
    ];
    if (biometricsAvalaible) {
      accessModes.add(
        PickerItem(
          const AuthenticationMethod(AuthMethod.biometrics)
              .getDisplayName(context),
          const AuthenticationMethod(AuthMethod.biometrics)
              .getDescription(context),
          AuthenticationMethod.getIcon(AuthMethod.biometrics),
          theme.pickerItemIconEnabled,
          AuthMethod.biometrics,
          true,
        ),
      );
    }
    accessModes
      ..add(
        PickerItem(
          const AuthenticationMethod(AuthMethod.biometricsUniris)
              .getDisplayName(context),
          const AuthenticationMethod(AuthMethod.biometricsUniris)
              .getDescription(context),
          AuthenticationMethod.getIcon(AuthMethod.biometricsUniris),
          theme.pickerItemIconEnabled,
          AuthMethod.biometricsUniris,
          false,
        ),
      )
      ..add(
        PickerItem(
          const AuthenticationMethod(AuthMethod.yubikeyWithYubicloud)
              .getDisplayName(context),
          const AuthenticationMethod(AuthMethod.yubikeyWithYubicloud)
              .getDescription(context),
          AuthenticationMethod.getIcon(AuthMethod.yubikeyWithYubicloud),
          theme.pickerItemIconEnabled,
          AuthMethod.yubikeyWithYubicloud,
          true,
        ),
      );

    final bool securityConfiguration = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return IntroConfigureSecurity(
            accessModes: accessModes,
            name: name,
            seed: seed,
          );
        },
      ),
    );

    return securityConfiguration;
  }

  Future<void> createKeychain() async {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    ShowSendingAnimation.build(
      context,
      theme,
      title: localizations.appWalletInitInProgress,
    );

    var error = false;

    try {
      await sl.get<DBHelper>().clearAppWallet();
      final vault = await HiveVaultDatasource.getInstance();
      await vault.setSeed(widget.seed!);

      final originPrivateKey = sl.get<ApiService>().getOriginKey();

      await KeychainUtil().createKeyChain(
        ref.read(SettingsProviders.settings).network,
        widget.seed,
        widget.name,
        originPrivateKey,
      );
    } catch (e) {
      error = true;
      final localizations = AppLocalization.of(context)!;
      final theme = ref.watch(ThemeProviders.selectedTheme);
      UIUtil.showSnackbar(
        '${localizations.sendError} ($e)',
        context,
        ref,
        theme.text!,
        theme.snackBarShadow!,
      );
    }

    if (error == false) {
    } else {
      Navigator.of(context).pop();
    }
  }
}
