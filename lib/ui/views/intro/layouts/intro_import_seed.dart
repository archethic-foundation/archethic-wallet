/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';
import 'dart:ui';

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/recovery_phrase_saved.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_configure_security.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_welcome.dart';
import 'package:aewallet/ui/views/intro/layouts/seed_language_switch.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/account_formatters.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

class IntroImportSeedPage extends ConsumerStatefulWidget {
  const IntroImportSeedPage({super.key});

  static const routerPage = '/intro_import';

  @override
  ConsumerState<IntroImportSeedPage> createState() => _IntroImportSeedState();
}

class _IntroImportSeedState extends ConsumerState<IntroImportSeedPage>
    implements SheetSkeletonInterface {
  final _logger = Logger('IntroImportSeed');

  bool _mnemonicIsValid = false;
  String _mnemonicError = '';
  bool? isPressed;
  final wordEditingControllers = List<TextEditingController?>.filled(
    24,
    null,
  );

  final List<bool> _hasFocusList = List.filled(24, false);

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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final languageSeed = ref.watch(
      SettingsProviders.settings.select(
        (settings) => settings.languageSeed,
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BtnFooterPrimary(
          buttonText: localizations.next,
          key: const Key('seedWordsOKbutton'),
          onTap: () async {
            setState(() {
              _mnemonicError = '';
              isPressed = true;
            });

            _mnemonicIsValid = true;
            for (final word in phrase) {
              final _word = word.trim();
              if (_word == '') {
                _mnemonicIsValid = false;
                _mnemonicError = localizations.mnemonicSizeError;
              } else {
                if (AppMnemomics.isValidWord(
                      _word,
                      languageCode: languageSeed,
                    ) ==
                    false) {
                  _mnemonicIsValid = false;
                  _mnemonicError =
                      localizations.mnemonicInvalidWord.replaceAll('%1', _word);
                }
              }
            }

            if (!_mnemonicIsValid) {
              setState(() {
                isPressed = false;
              });
              return;
            }

            final result = await context.push(
              IntroConfigureSecurity.routerPage,
              extra: {
                'isImportProfile': true,
              },
            );
            if (result != null && result == false) {
              setState(() {
                _mnemonicError = '';
                isPressed = false;
              });
              return;
            }
            context.loadingOverlay.show(
              title: localizations.pleaseWait,
            );

            try {
              final newSession = await ref
                  .read(sessionNotifierProvider.notifier)
                  .restoreFromMnemonics(
                    mnemonics: phrase.toList(),
                    languageCode: languageSeed,
                  );
              context.loadingOverlay.hide();
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
                context.go(IntroImportSeedPage.routerPage);
                return;
              }

              await _accountsDialog(
                newSession.wallet.appKeychain.accounts,
              );
              context.loadingOverlay.show(
                title: localizations.pleaseWait,
              );

              await (await ref
                      .read(accountsNotifierProvider.notifier)
                      .selectedAccountNotifier)
                  ?.refreshAll();

              ref.read(
                RecoveryPhraseSavedProvider.setRecoveryPhraseSaved(true),
              );
              context.go(HomePage.routerPage);
              context.loadingOverlay.hide();

              setState(() {
                isPressed = false;
              });
            } catch (e) {
              context.loadingOverlay.hide();
              setState(() {
                _mnemonicIsValid = false;
                isPressed = false;
              });
              UIUtil.showSnackbar(
                (e == ArchethicKeychainNotExistsException)
                    ? localizations.noKeychain
                    : e is TimeoutException
                        ? localizations.failureTimeout
                        : e.toString(),
                context,
                ref,
                ArchethicTheme.text,
                ArchethicTheme.snackBarShadow,
              );
              context.go(IntroImportSeedPage.routerPage);
              return;
            }
          },
          isLocked: isPressed == true,
        ),
        const SizedBox(
          height: 10,
        ),
        BtnFooterPrimary(
          btnPrimaryType: BtnFooterPrimaryType.outlinePrimary,
          buttonText: localizations.paste24Words,
          key: const Key('seedWordsPast24Words'),
          onTap: () async {
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
                pastedWords.length != wordEditingControllers.length ||
                pastedWords.any(
                  (element) => !AppMnemomics.isValidWord(
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
              for (var i = 0; i < wordEditingControllers.length; i++) {
                wordEditingControllers[i]?.text = pastedWords.elementAt(i);
              }
              _mnemonicError = '';
              _mnemonicIsValid = true;
            });
          },
          isLocked: isPressed == true,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return SheetAppBar(
      title: localizations.importSecretPhrase,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(IntroWelcome.routerPage);
        },
      ),
      widgetRight:
          connectivityStatusProvider == ConnectivityStatus.isDisconnected
              ? const Padding(
                  padding: EdgeInsets.only(
                    right: 7,
                    top: 7,
                  ),
                  child: IconNetworkWarning(
                    alignment: Alignment.topRight,
                  ),
                )
              : const SizedBox.shrink(),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final languageSeed = ref.watch(
      SettingsProviders.settings.select(
        (settings) => settings.languageSeed,
      ),
    );

    void _validateWord(String word) {
      if (word.isEmpty) {
        setState(() {
          _mnemonicError = '';
          _mnemonicIsValid = true;
        });
        return;
      }
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

    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1) ${localizations.importSecretPhraseLanguage}',
              style: Theme.of(context).textTheme.bodySmallWithOpacity,
            ),
            const SizedBox(
              height: 10,
            ),
            const SeedLanguageSwitch(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                '2) ${localizations.importSecretPhraseHint}',
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        if (_mnemonicError != '')
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: MessageBox(
              messageBoxType: MessageBoxType.warning,
              content: Text(
                _mnemonicError,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          )
        else
          const SizedBox(
            height: 62,
          ),
        GridView.count(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1 / 0.64,
          shrinkWrap: true,
          crossAxisCount: 4,
          children: List.generate(24, (index) {
            return SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Autocomplete<String>(
                  optionsBuilder: (
                    TextEditingValue textEditingValue,
                  ) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return AppMnemomics.getLanguage(
                      languageSeed,
                    ).list.where((String option) {
                      return option.startsWith(
                        unorm.nfkd(
                          textEditingValue.text.toLowerCase(),
                        ),
                      );
                    });
                  },
                  onSelected: (String selection) {
                    wordEditingControllers[index]?.text = selection;
                    _validateWord(selection);
                    FocusScope.of(context).nextFocus();
                  },
                  fieldViewBuilder: (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    wordEditingControllers[index] = textEditingController;

                    focusNode.addListener(() {
                      setState(() {
                        _hasFocusList[index] = focusNode.hasFocus;
                      });
                    });

                    return Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        key: Key('seedWord$index'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: _hasFocusList[index]
                                                  ? Colors.black
                                                  : null,
                                            ),
                                        autocorrect: false,
                                        controller: textEditingController,
                                        focusNode: focusNode,
                                        onChanged: (value) {
                                          final _value = value.trim();
                                          _validateWord(_value);
                                        },
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [
                                          LowerCaseTextFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                          hintText: (index + 1).toString(),
                                          contentPadding:
                                              const EdgeInsets.only(left: 10),
                                          filled: true,
                                          fillColor: _hasFocusList[index]
                                              ? Colors.white
                                              : Colors.white
                                                  .withValues(alpha: 0.15),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          focusColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
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
        _logger.info('<<accountName${account.nameDisplayed}>>');
      }
    }

    final selection = await showDialog<Account>(
      barrierDismissible: false,
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        final localizations = AppLocalizations.of(context)!;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: ArchethicTheme.backgroundPopupColor,
          elevation: 0,
          contentPadding: EdgeInsets.zero,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ArchethicTheme.sheetBackground.withValues(alpha: 0.2),
                  border: Border.all(
                    color: ArchethicTheme.sheetBorder,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.accountsHeader,
                            style:
                                ArchethicThemeStyles.textStyleSize24W700Primary,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (accounts.length > 1)
                            Text(
                              localizations.selectAccountDescSeveral,
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            )
                          else
                            Text(
                              localizations.selectAccountDescOne,
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: PickerWidget(
                          pickerItems: pickerItemsList,
                          selectedIndexes: const [0],
                          onSelected: (value) {
                            context.pop(value.value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    if (selection != null) {
      await ref
          .read(accountsNotifierProvider.notifier)
          .selectAccount(selection);
    }
    return selection;
  }
}
