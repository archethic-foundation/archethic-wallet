/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/intro/intro_configure_security.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

class IntroImportSeedPage extends ConsumerStatefulWidget {
  const IntroImportSeedPage({super.key});

  @override
  ConsumerState<IntroImportSeedPage> createState() => _IntroImportSeedState();
}

class _IntroImportSeedState extends ConsumerState<IntroImportSeedPage> {
  bool _mnemonicIsValid = false;
  String _mnemonicError = '';
  bool? isPressed;
  final wordEditingControllers = List<TextEditingController?>.filled(
    24,
    null,
  );

  Iterable<String> get phrase => wordEditingControllers.map(
        (textController) => textController?.text ?? '',
      );

  StreamSubscription<AuthenticatedEvent>? _authSub;

  @override
  void initState() {
    isPressed = false;
    _registerBus();
    ref.read(SettingsProviders.settings.notifier).setLanguageSeed('en');
    super.initState();
  }

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) async {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (Route<dynamic> route) => false,
      );
    });
  }

  void _destroyBus() {
    _authSub?.cancel();
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final languageSeed = ref.watch(
      SettingsProviders.settings.select(
        (settings) => settings.languageSeed,
      ),
    );
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    void _validateWord(String word) {
      if (!AppMnemomics.isValidWord(
        word,
        languageCode: languageSeed,
      )) {
        setState(() {
          _mnemonicIsValid = false;
          _mnemonicError = localizations.mnemonicInvalidWord.replaceAll(
            '%1',
            word,
          );
        });
      } else {
        setState(() {
          _mnemonicError = '';
          _mnemonicIsValid = true;
        });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background2Small!,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 15 : 20,
                          ),
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
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                start: 15,
                              ),
                              height: 50,
                              width: 50,
                              child: TextButton(
                                onPressed: () async {
                                  sl.get<HapticUtil>().feedback(
                                        FeedbackType.light,
                                        preferences.activeVibrations,
                                      );

                                  ref
                                      .read(SettingsProviders.settings.notifier)
                                      .setLanguageSeed('en');
                                },
                                child: languageSeed == 'en'
                                    ? Image.asset(
                                        'assets/icons/languages/united-states.png',
                                      )
                                    : Opacity(
                                        opacity: 0.3,
                                        child: Image.asset(
                                          'assets/icons/languages/united-states.png',
                                        ),
                                      ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                start: 15,
                              ),
                              height: 50,
                              width: 50,
                              child: TextButton(
                                onPressed: () async {
                                  sl.get<HapticUtil>().feedback(
                                        FeedbackType.light,
                                        preferences.activeVibrations,
                                      );

                                  ref
                                      .read(SettingsProviders.settings.notifier)
                                      .setLanguageSeed('fr');
                                },
                                child: languageSeed == 'fr'
                                    ? Image.asset(
                                        'assets/icons/languages/france.png',
                                      )
                                    : Opacity(
                                        opacity: 0.3,
                                        child: Image.asset(
                                          'assets/icons/languages/france.png',
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                        start: smallScreen(context) ? 30 : 40,
                        end: smallScreen(context) ? 30 : 40,
                        top: 10,
                      ),
                      alignment: AlignmentDirectional.centerStart,
                      child: AutoSizeText(
                        localizations.importSecretPhrase,
                        style: theme.textStyleSize28W700Primary,
                        maxLines: 1,
                        stepGranularity: 0.1,
                      ),
                    ),
                    Expanded(
                      child: ArchethicScrollbar(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                left: 30,
                                right: 10,
                                top: 15,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      localizations.importSecretPhraseHint,
                                      style: theme.textStyleSize16W600Primary,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 48,
                                    child: TextButton.icon(
                                      label: const Text(''),
                                      icon: Icon(
                                        Iconsax.document_normal,
                                        color: theme
                                            .textStyleSize16W600Primary.color,
                                      ),
                                      onPressed: () async {
                                        final data = await Clipboard.getData(
                                          'text/plain',
                                        );
                                        final pastedWords = data?.text
                                            ?.split(RegExp('[^a-z]'))
                                            .where(
                                              (element) => element.isNotEmpty,
                                            );

                                        if (pastedWords == null ||
                                            pastedWords.length !=
                                                wordEditingControllers.length ||
                                            pastedWords.any(
                                              (element) =>
                                                  !AppMnemomics.isValidWord(
                                                element,
                                                languageCode: languageSeed,
                                              ),
                                            )) {
                                          UIUtil.showSnackbar(
                                            localizations.invalidSeedPaste,
                                            context,
                                            ref,
                                            theme.text!,
                                            theme.snackBarShadow!,
                                          );

                                          return;
                                        }
                                        setState(() {
                                          for (var i = 0;
                                              i < wordEditingControllers.length;
                                              i++) {
                                            wordEditingControllers[i]?.text =
                                                pastedWords.elementAt(i);
                                          }
                                          _mnemonicError = '';
                                          _mnemonicIsValid = true;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            if (_mnemonicError != '')
                              SizedBox(
                                height: 40,
                                child: Text(
                                  _mnemonicError,
                                  style: theme.textStyleSize14W200Primary,
                                ),
                              )
                            else
                              const SizedBox(
                                height: 40,
                              ),
                            Column(
                              children: <Widget>[
                                GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  childAspectRatio: 1 / 0.6,
                                  shrinkWrap: true,
                                  crossAxisCount: 4,
                                  children: List.generate(24, (index) {
                                    return SizedBox(
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Autocomplete<String>(
                                              optionsBuilder: (
                                                TextEditingValue
                                                    textEditingValue,
                                              ) {
                                                if (textEditingValue.text ==
                                                    '') {
                                                  return const Iterable<
                                                      String>.empty();
                                                }
                                                return AppMnemomics.getLanguage(
                                                  languageSeed,
                                                ).list.where((String option) {
                                                  return option.startsWith(
                                                    unorm.nfkd(
                                                      textEditingValue.text
                                                          .toLowerCase(),
                                                    ),
                                                  );
                                                });
                                              },
                                              onSelected: (String selection) {
                                                wordEditingControllers[index]
                                                    ?.text = selection;
                                                _validateWord(selection);
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              },
                                              fieldViewBuilder: (
                                                context,
                                                textEditingController,
                                                focusNode,
                                                onFieldSubmitted,
                                              ) {
                                                wordEditingControllers[index] =
                                                    textEditingController;
                                                return Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: <Widget>[
                                                    TextFormField(
                                                      key:
                                                          Key('seedWord$index'),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: (index + 1)
                                                            .toString(),
                                                      ),
                                                      inputFormatters: [
                                                        LowerCaseTextFormatter()
                                                      ],
                                                      controller:
                                                          textEditingController,
                                                      focusNode: focusNode,
                                                      style: theme
                                                          .textStyleSize12W400Primary,
                                                      autocorrect: false,
                                                      onChanged: (value) {
                                                        final _value =
                                                            value.trim();
                                                        if (_value.isEmpty) {
                                                          return;
                                                        }
                                                        _validateWord(_value);
                                                      },
                                                    ),
                                                    Positioned(
                                                      bottom: 1,
                                                      child: Container(
                                                        height: 1,
                                                        width: MediaQuery.of(
                                                          context,
                                                        ).size.width,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              theme.gradient,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (isPressed == true ||
                            phrase.contains('') ||
                            connectivityStatusProvider ==
                                ConnectivityStatus.isDisconnected)
                          AppButtonTiny(
                            AppButtonTinyType.primaryOutline,
                            localizations.ok,
                            Dimens.buttonTopDimens,
                            key: const Key('seedWordsOKbutton'),
                            onPressed: () {},
                          )
                        else
                          AppButtonTiny(
                            AppButtonTinyType.primary,
                            localizations.ok,
                            Dimens.buttonTopDimens,
                            key: const Key('seedWordsOKbutton'),
                            onPressed: () async {
                              setState(() {
                                _mnemonicError = '';
                                isPressed = true;
                              });

                              _mnemonicIsValid = true;
                              for (final word in phrase) {
                                final _word = word.trim();
                                if (_word == '') {
                                  _mnemonicIsValid = false;
                                  _mnemonicError =
                                      localizations.mnemonicSizeError;
                                } else {
                                  if (AppMnemomics.isValidWord(
                                        _word,
                                        languageCode: languageSeed,
                                      ) ==
                                      false) {
                                    _mnemonicIsValid = false;
                                    _mnemonicError = localizations
                                        .mnemonicInvalidWord
                                        .replaceAll('%1', _word);
                                  }
                                }
                              }

                              if (!_mnemonicIsValid) {
                                UIUtil.showSnackbar(
                                  _mnemonicError,
                                  context,
                                  ref,
                                  theme.text!,
                                  theme.snackBarShadow!,
                                );
                                setState(() {
                                  isPressed = false;
                                });
                                return;
                              }
                              ShowSendingAnimation.build(context, theme);
                              final newSession = await ref
                                  .read(SessionProviders.session.notifier)
                                  .restoreFromMnemonics(
                                    mnemonics: phrase.toList(),
                                    languageCode: languageSeed,
                                  );

                              if (newSession == null) {
                                setState(() {
                                  _mnemonicIsValid = false;
                                  isPressed = false;
                                });
                                UIUtil.showSnackbar(
                                  localizations.noKeychain,
                                  context,
                                  ref,
                                  theme.text!,
                                  theme.snackBarShadow!,
                                );
                                Navigator.of(context).pop();
                                return;
                              }

                              final accountSelected = await _accountsDialog(
                                newSession.wallet.appKeychain.accounts,
                              );

                              ref
                                  .read(
                                    AccountProviders.account(
                                      accountSelected!.name,
                                    ).notifier,
                                  )
                                  .refreshRecentTransactions();
                              ref
                                  .read(
                                    AccountProviders.account(
                                      accountSelected.name,
                                    ).notifier,
                                  )
                                  .refreshNFTs();
                              final securityConfigOk =
                                  await _launchSecurityConfiguration(
                                accountSelected.name,
                                newSession.wallet.seed,
                              );
                              setState(() {
                                isPressed = false;
                              });

                              if (securityConfigOk == false) {
                                Navigator.of(context).pop(false);
                              }
                            },
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

  Future<bool> _launchSecurityConfiguration(String name, String seed) async {
    final theme = ref.read(ThemeProviders.selectedTheme);
    final biometricsAvalaible = await sl.get<BiometricUtil>().hasBiometrics();
    final accessModes = <PickerItem>[
      PickerItem(
        const AuthenticationMethod(AuthMethod.pin).getDisplayName(context),
        const AuthenticationMethod(AuthMethod.pin).getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.pin),
        theme.pickerItemIconEnabled,
        AuthMethod.pin,
        true,
        key: const Key('accessModePIN'),
      ),
      PickerItem(
        const AuthenticationMethod(AuthMethod.password).getDisplayName(context),
        const AuthenticationMethod(AuthMethod.password).getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.password),
        theme.pickerItemIconEnabled,
        AuthMethod.password,
        true,
        key: const Key('accessModePassword'),
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

  Future<Account?> _accountsDialog(List<Account> accounts) async {
    final theme = ref.read(ThemeProviders.selectedTheme);
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    for (var i = 0; i < accounts.length; i++) {
      if (accounts[i].serviceType == 'archethicWallet') {
        final account = accounts[i];
        pickerItemsList.add(
          PickerItem(
            account.nameDisplayed,
            null,
            null,
            null,
            account,
            true,
            key: Key('accountName${account.nameDisplayed}'),
          ),
        );
        log(
          '<<accountName${account.nameDisplayed}>>',
        );
      }
    }

    final selection = await showDialog<Account>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final localizations = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.keychainHeader,
                  style: theme.textStyleSize24W700EquinoxPrimary,
                ),
                const SizedBox(
                  height: 5,
                ),
                if (accounts.length > 1)
                  Text(
                    localizations.selectAccountDescSeveral,
                    style: theme.textStyleSize12W100Primary,
                  )
                else
                  Text(
                    localizations.selectAccountDescOne,
                    style: theme.textStyleSize12W100Primary,
                  ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: theme.text45!,
            ),
          ),
          content: SingleChildScrollView(
            child: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndex: 0,
              onSelected: (value) {
                Navigator.pop(context, value.value);
              },
            ),
          ),
        );
      },
    );
    if (selection != null) {
      await ref
          .read(AccountProviders.accounts.notifier)
          .selectAccount(selection);
    }
    return selection;
  }
}
