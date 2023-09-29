/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/recovery_phrase_saved.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/infrastructure/datasources/hive_vault.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/security_configuration.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class IntroBackupConfirm extends ConsumerStatefulWidget {
  const IntroBackupConfirm({
    required this.name,
    required this.seed,
    this.welcomeProcess = true,
    super.key,
  });
  final String? name;
  final String? seed;
  final bool welcomeProcess;
  @override
  ConsumerState<IntroBackupConfirm> createState() => _IntroBackupConfirmState();
}

class _IntroBackupConfirmState extends ConsumerState<IntroBackupConfirm>
    with SecurityConfigurationMixin {
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
      final localizations = AppLocalizations.of(context)!;
      final theme = ref.read(ThemeProviders.selectedTheme);
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

      if (event.response != 'ok') {
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
            icon: Symbols.info,
          );

          if (keychainAccessRequested) break;

          setState(() {
            keychainAccessRequested = true;
          });
          await KeychainUtil().createKeyChainAccess(
            ref.read(SettingsProviders.settings).network,
            widget.seed,
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
            icon: Symbols.info,
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
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

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
            child: Stack(
              children: [
                Column(
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
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        child: Chip(
                                          avatar: CircleAvatar(
                                            backgroundColor:
                                                Colors.grey.shade800,
                                            child: Text(
                                              (entry.key + 1).toString(),
                                              style: theme
                                                  .textStyleSize12W100Primary60,
                                            ),
                                          ),
                                          label: Text(
                                            entry.value,
                                            style: theme
                                                .textStyleSize12W400Primary,
                                          ),
                                          onDeleted: () {
                                            setState(() {
                                              wordListToSelect.add(entry.value);
                                              wordListSelected
                                                  .removeAt(entry.key);
                                            });
                                          },
                                          deleteIconColor: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
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
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        child: GestureDetector(
                                          onTap: () {
                                            wordListSelected.add(entry.value);
                                            wordListToSelect
                                                .removeAt(entry.key);
                                            setState(() {});
                                          },
                                          child: Chip(
                                            label: Text(
                                              entry.value,
                                              style: theme
                                                  .textStyleSize12W400Primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            AppButtonTinyConnectivity(
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
                                  ref.read(
                                    RecoveryPhraseSavedProvider
                                        .setRecoveryPhraseSaved(true),
                                  );

                                  if (widget.welcomeProcess) {
                                    await launchSecurityConfiguration(
                                      context,
                                      ref,
                                      widget.seed!,
                                    );
                                  } else {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              disabled: wordListSelected.length != 24,
                            ),
                          ],
                        ),
                        if (widget.welcomeProcess)
                          Row(
                            children: <Widget>[
                              AppButtonTinyConnectivity(
                                localizations.pass,
                                Dimens.buttonBottomDimens,
                                key: const Key('pass'),
                                onPressed: () {
                                  AppDialogs.showConfirmDialog(
                                    context,
                                    ref,
                                    localizations
                                        .passBackupConfirmationDisclaimer,
                                    localizations.passBackupConfirmationMessage,
                                    localizations
                                        .passRecoveryPhraseBackupSecureLater,
                                    () async {
                                      ref.read(
                                        RecoveryPhraseSavedProvider
                                            .setRecoveryPhraseSaved(false),
                                      );
                                      await launchSecurityConfiguration(
                                        context,
                                        ref,
                                        widget.seed!,
                                      );
                                    },
                                    titleStyle: theme
                                        .textStyleSize14W600EquinoxPrimaryRed,
                                    additionalContent:
                                        localizations.archethicDoesntKeepCopy,
                                    additionalContentStyle:
                                        theme.textStyleSize12W300PrimaryRed,
                                    cancelText: localizations
                                        .passRecoveryPhraseBackupSecureNow,
                                  );
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
                if (connectivityStatusProvider ==
                    ConnectivityStatus.isDisconnected)
                  const IconNetworkWarning(
                    alignment: Alignment.topRight,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createKeychain() async {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.read(ThemeProviders.selectedTheme);
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
      final localizations = AppLocalizations.of(context)!;
      final theme = ref.read(ThemeProviders.selectedTheme);
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
