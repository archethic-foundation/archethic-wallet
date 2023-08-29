/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/recovery_phrase_saved.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/intro/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/settings/mnemonic_display.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSeedBackupSheet extends ConsumerWidget {
  const AppSeedBackupSheet(this.mnemonic, {super.key});

  final List<String>? mnemonic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final recoveryPhraseSavedAsync =
        ref.watch(RecoveryPhraseSavedProvider.isRecoveryPhraseSaved);

    return TapOutsideUnfocus(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
          minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.035,
          ),
          child: Column(
            children: <Widget>[
              SheetHeader(
                title: localizations.recoveryPhrase,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ArchethicScrollbar(
                        child: Column(
                          children: <Widget>[
                            if (mnemonic != null)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  left: 10,
                                  right: 10,
                                ),
                                child: MnemonicDisplay(
                                  wordList: mnemonic!,
                                  obscureSeed: true,
                                  explanation: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      AutoSizeText(
                                        localizations.dipslayPhraseExplanation,
                                        style: theme.textStyleSize12W100Primary,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel2,
                                        style: theme.textStyleSize14W600Primary,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel3,
                                        style: theme.textStyleSize12W100Primary,
                                      ),
                                      Divider(
                                        height: 20,
                                        color: theme.text60,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel4,
                                        style: theme.textStyleSize14W600Primary,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel5,
                                        style: theme.textStyleSize12W100Primary,
                                      ),
                                      Divider(
                                        height: 20,
                                        color: theme.text60,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel6,
                                        style: theme.textStyleSize14W600Primary,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel7,
                                        style: theme.textStyleSize12W100Primary,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    recoveryPhraseSavedAsync.map(
                      data: (data) => data.value == false
                          ? Row(
                              children: <Widget>[
                                AppButtonTinyConnectivity(
                                  localizations.recoveryPhraseSave,
                                  icon: Icons.note_add,
                                  Dimens.buttonBottomDimens,
                                  key: const Key('saveRecoveryPhrase'),
                                  onPressed: () async {
                                    final seed =
                                        AppMnemomics.mnemonicListToSeed(
                                      mnemonic!,
                                    );
                                    Sheets.showAppHeightNineSheet(
                                      context: context,
                                      ref: ref,
                                      widget: IntroBackupConfirm(
                                        name: null,
                                        seed: seed,
                                        welcomeProcess: false,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : const SizedBox(),
                      error: (error) => const SizedBox(),
                      loading: (loading) => const SizedBox(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
