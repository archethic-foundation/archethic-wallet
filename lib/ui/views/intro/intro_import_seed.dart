/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

// Project imports:
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/intro/intro_configure_security.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/vault.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
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
  String language = 'en';
  List<String> phrase = List<String>.filled(24, '');

  StreamSubscription<AuthenticatedEvent>? _authSub;

  @override
  void initState() {
    isPressed = false;
    _registerBus();
    Preferences.getInstance().then((Preferences preferences) => preferences.setLanguageSeed('en'));
    super.initState();
  }

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton().registerTo<AuthenticatedEvent>().listen((AuthenticatedEvent event) async {
      await StateContainer.of(context).requestUpdate();

      StateContainer.of(context).checkTransactionInputs(
        AppLocalization.of(context)!.transactionInputNotification,
      );
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
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.theme);

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
          builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
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
                                            StateContainer.of(context).activeVibrations,
                                          );

                                      final preferences = await Preferences.getInstance();
                                      preferences.setLanguageSeed('en');
                                      setState(() {
                                        language = 'en';
                                      });
                                    },
                                    child: language == 'en'
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
                                            StateContainer.of(context).activeVibrations,
                                          );

                                      final preferences = await Preferences.getInstance();
                                      preferences.setLanguageSeed('fr');
                                      setState(() {
                                        language = 'fr';
                                      });
                                    },
                                    child: language == 'fr'
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
                        Container(
                          margin: EdgeInsets.only(
                            left: smallScreen(context) ? 30 : 40,
                            right: smallScreen(context) ? 30 : 40,
                            top: 15,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            localizations.importSecretPhraseHint,
                            style: theme.textStyleSize16W600Primary,
                            textAlign: TextAlign.start,
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 10),
                              GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: 1.2,
                                shrinkWrap: true,
                                crossAxisCount: 4,
                                children: List.generate(24, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          (index + 1).toString(),
                                          style: theme.textStyleSize12W100Primary,
                                        ),
                                        Autocomplete<String>(
                                          optionsBuilder: (
                                            TextEditingValue textEditingValue,
                                          ) {
                                            if (textEditingValue.text == '') {
                                              return const Iterable<String>.empty();
                                            }
                                            return AppMnemomics.getLanguage(
                                              language,
                                            ).list.where((String option) {
                                              return option.contains(
                                                unorm.nfkd(
                                                  textEditingValue.text.toLowerCase(),
                                                ),
                                              );
                                            });
                                          },
                                          onSelected: (String selection) {
                                            if (!AppMnemomics.isValidWord(
                                              selection,
                                              languageCode: language,
                                            )) {
                                              setState(() {
                                                _mnemonicIsValid = false;
                                                _mnemonicError = localizations.mnemonicInvalidWord.replaceAll(
                                                  '%1',
                                                  selection,
                                                );
                                              });
                                            } else {
                                              phrase[index] = selection;
                                              setState(() {
                                                _mnemonicError = '';
                                                _mnemonicIsValid = true;
                                              });
                                            }
                                          },
                                          fieldViewBuilder: (
                                            context,
                                            textEditingController,
                                            focusNode,
                                            onFieldSubmitted,
                                          ) {
                                            return Stack(
                                              alignment: AlignmentDirectional.center,
                                              children: <Widget>[
                                                TextFormField(
                                                  controller: textEditingController,
                                                  focusNode: focusNode,
                                                  style: theme.textStyleSize12W400Primary,
                                                  autocorrect: false,
                                                  onChanged: (value) {
                                                    if (!AppMnemomics.isValidWord(
                                                      value,
                                                      languageCode: language,
                                                    )) {
                                                      setState(() {
                                                        _mnemonicIsValid = false;
                                                        _mnemonicError = localizations.mnemonicInvalidWord.replaceAll(
                                                          '%1',
                                                          value,
                                                        );
                                                      });
                                                    } else {
                                                      phrase[index] = value;
                                                      setState(() {
                                                        _mnemonicError = '';
                                                        _mnemonicIsValid = true;
                                                      });
                                                    }
                                                  },
                                                ),
                                                Positioned(
                                                  bottom: 1,
                                                  child: Container(
                                                    height: 1,
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                      gradient: theme.gradient,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (isPressed == true || phrase.contains(''))
                      AppButton.buildAppButton(
                        const Key('ok'),
                        context,
                        ref,
                        AppButtonType.primaryOutline,
                        localizations.ok,
                        Dimens.buttonTopDimens,
                        onPressed: () {},
                      )
                    else
                      AppButton.buildAppButton(
                        const Key('ok'),
                        context,
                        ref,
                        AppButtonType.primary,
                        localizations.ok,
                        Dimens.buttonTopDimens,
                        onPressed: () async {
                          final currency = ref.watch(CurrencyProviders.selectedCurrency);

                          _showSendingAnimation(context);
                          setState(() {
                            _mnemonicError = '';
                            isPressed = true;
                          });

                          _mnemonicIsValid = true;
                          for (final word in phrase) {
                            if (word.trim() == '') {
                              _mnemonicIsValid = false;
                              _mnemonicError = localizations.mnemonicSizeError;
                            } else {
                              if (AppMnemomics.isValidWord(
                                    word,
                                    languageCode: language,
                                  ) ==
                                  false) {
                                _mnemonicIsValid = false;
                                _mnemonicError = localizations.mnemonicInvalidWord.replaceAll('%1', word);
                              }
                            }
                          }
                          if (_mnemonicIsValid == true) {
                            await sl.get<DBHelper>().clearAppWallet();
                            StateContainer.of(context).appWallet = null;
                            final seed = AppMnemomics.mnemonicListToSeed(
                              phrase,
                              languageCode: language,
                            );
                            final vault = await Vault.getInstance();
                            vault.setSeed(seed);
                            final tokenPrice = await Price.getCurrency(
                              currency.currency.name,
                            );

                            try {
                              final appWallet = await KeychainUtil().getListAccountsFromKeychain(
                                StateContainer.of(context).appWallet,
                                seed,
                                currency.currency.name,
                                StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel(),
                                tokenPrice,
                              );

                              StateContainer.of(context).appWallet = appWallet;
                              final accounts = appWallet!.appKeychain!.accounts;

                              if (accounts == null || accounts.isEmpty) {
                                setState(() {
                                  _mnemonicIsValid = false;
                                });
                                UIUtil.showSnackbar(
                                  localizations.noKeychain,
                                  context,
                                  ref,
                                  theme.text!,
                                  theme.snackBarShadow!,
                                );
                                Navigator.of(context).pop();
                              } else {
                                accounts.sort(
                                  (a, b) => a.name!.compareTo(b.name!),
                                );
                                await _accountsDialog(accounts);
                                await _launchSecurityConfiguration(
                                  StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.name!,
                                  seed,
                                );
                              }
                            } catch (e) {
                              setState(() {
                                _mnemonicIsValid = false;
                              });
                              UIUtil.showSnackbar(
                                localizations.noKeychain,
                                context,
                                ref,
                                theme.text!,
                                theme.snackBarShadow!,
                              );
                              Navigator.of(context).pop();
                            }
                          }

                          setState(() {
                            isPressed = false;
                          });
                        },
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
    final theme = ref.watch(ThemeProviders.theme);
    final biometricsAvalaible = await sl.get<BiometricUtil>().hasBiometrics();
    final accessModes = <PickerItem>[];
    accessModes.add(
      PickerItem(
        const AuthenticationMethod(AuthMethod.pin).getDisplayName(context),
        const AuthenticationMethod(AuthMethod.pin).getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.pin),
        theme.pickerItemIconEnabled,
        AuthMethod.pin,
        true,
      ),
    );
    accessModes.add(
      PickerItem(
        const AuthenticationMethod(AuthMethod.password).getDisplayName(context),
        const AuthenticationMethod(AuthMethod.password).getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.password),
        theme.pickerItemIconEnabled,
        AuthMethod.password,
        true,
      ),
    );
    if (biometricsAvalaible) {
      accessModes.add(
        PickerItem(
          const AuthenticationMethod(AuthMethod.biometrics).getDisplayName(context),
          const AuthenticationMethod(AuthMethod.biometrics).getDescription(context),
          AuthenticationMethod.getIcon(AuthMethod.biometrics),
          theme.pickerItemIconEnabled,
          AuthMethod.biometrics,
          true,
        ),
      );
    }
    accessModes.add(
      PickerItem(
        const AuthenticationMethod(AuthMethod.biometricsUniris).getDisplayName(context),
        const AuthenticationMethod(AuthMethod.biometricsUniris).getDescription(context),
        AuthenticationMethod.getIcon(AuthMethod.biometricsUniris),
        theme.pickerItemIconEnabled,
        AuthMethod.biometricsUniris,
        false,
      ),
    );
    accessModes.add(
      PickerItem(
        const AuthenticationMethod(AuthMethod.yubikeyWithYubicloud).getDisplayName(context),
        const AuthenticationMethod(AuthMethod.yubikeyWithYubicloud).getDescription(context),
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

  Future<void> _accountsDialog(List<Account> accounts) async {
    final theme = ref.watch(ThemeProviders.theme);
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    for (final account in accounts) {
      pickerItemsList.add(PickerItem(account.name!, null, null, null, account, true));
    }

    final selection = await showDialog<Account>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final localizations = AppLocalization.of(context)!;
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
      await StateContainer.of(context).appWallet!.appKeychain!.setAccountSelected(selection);
    }
  }

  void _showSendingAnimation(BuildContext context) {
    final theme = ref.watch(ThemeProviders.theme);
    Navigator.of(context).push(
      AnimationLoadingOverlay(
        AnimationType.send,
        theme.animationOverlayStrong!,
        theme.animationOverlayMedium!,
      ),
    );
  }
}
