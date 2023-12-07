/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/recovery_phrase_saved.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/security_configuration.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/intro/intro_welcome.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

class IntroImportSeedPage extends ConsumerStatefulWidget {
  const IntroImportSeedPage({super.key});

  static const routerPage = '/intro_import';

  @override
  ConsumerState<IntroImportSeedPage> createState() => _IntroImportSeedState();
}

class _IntroImportSeedState extends ConsumerState<IntroImportSeedPage>
    with SecurityConfigurationMixin {
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

  @override
  void initState() {
    isPressed = false;
    ref.read(SettingsProviders.settings.notifier).setLanguageSeed('en');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

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
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              ArchethicTheme.backgroundDark,
              ArchethicTheme.background,
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
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
                            color: ArchethicTheme.text,
                            onPressed: () {
                              context.go(IntroWelcome.routerPage);
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
                        ),
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
                        style: ArchethicThemeStyles.textStyleSize28W700Primary,
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
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 48,
                                    child: TextButton.icon(
                                      label: const Text(''),
                                      icon: Icon(
                                        Symbols.content_paste,
                                        weight: IconSize.weightM,
                                        opticalSize: IconSize.opticalSizeM,
                                        grade: IconSize.gradeM,
                                        color: ArchethicThemeStyles
                                            .textStyleSize16W600Primary.color,
                                      ),
                                      onPressed: () async {
                                        final data = await Clipboard.getData(
                                          'text/plain',
                                        );

                                        final pastedWords = data?.text
                                            ?.trimLeft()
                                            .trimRight()
                                            .toLowerCase()
                                            .split(RegExp('[^a-zA-ZÀ-ÿ]'))
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
                                            ArchethicTheme.text,
                                            ArchethicTheme.snackBarShadow,
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
                                  style: ArchethicThemeStyles
                                      .textStyleSize14W200Primary,
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
                                  childAspectRatio: 1 / 0.62,
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
                                                        LowerCaseTextFormatter(),
                                                      ],
                                                      controller:
                                                          textEditingController,
                                                      focusNode: focusNode,
                                                      style: ArchethicThemeStyles
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
                                                              ArchethicTheme
                                                                  .gradient,
                                                        ),
                                                      ),
                                                    ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButtonTinyConnectivity(
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
                                ArchethicTheme.text,
                                ArchethicTheme.snackBarShadow,
                              );
                              setState(() {
                                isPressed = false;
                              });
                              return;
                            }
                            ShowSendingAnimation.build(
                              context,
                            );
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
                                ArchethicTheme.text,
                                ArchethicTheme.snackBarShadow,
                              );
                              context.pop();
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
                            ref.read(
                              RecoveryPhraseSavedProvider
                                  .setRecoveryPhraseSaved(true),
                            );

                            await launchSecurityConfiguration(
                              context,
                              ref,
                              newSession.wallet.seed,
                              IntroImportSeedPage.routerPage,
                              null,
                            );
                            setState(() {
                              isPressed = false;
                            });
                          },
                          disabled: isPressed == true,
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

  Future<Account?> _accountsDialog(List<Account> accounts) async {
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
                  style: ArchethicThemeStyles.textStyleSize24W700Primary,
                ),
                const SizedBox(
                  height: 5,
                ),
                if (accounts.length > 1)
                  Text(
                    localizations.selectAccountDescSeveral,
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  )
                else
                  Text(
                    localizations.selectAccountDescOne,
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: ArchethicTheme.text45,
            ),
          ),
          content: SingleChildScrollView(
            child: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndexes: const [0],
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
