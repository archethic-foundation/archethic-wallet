/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/recovery_phrase_saved.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/settings/mnemonic_display.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppSeedBackupSheet extends ConsumerWidget {
  const AppSeedBackupSheet(this.mnemonic, this.seed, {super.key});

  final List<String>? mnemonic;
  final String seed;

  static const routerPage = '/app_seed_backup';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final recoveryPhraseSavedAsync =
        ref.watch(RecoveryPhraseSavedProvider.isRecoveryPhraseSaved);

    return Scaffold(
      drawerEdgeDragWidth: 0,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: recoveryPhraseSavedAsync.map(
        data: (data) => data.value == false
            ? Row(
                children: <Widget>[
                  AppButtonTinyConnectivity(
                    localizations.recoveryPhraseSave,
                    Dimens.buttonBottomDimens,
                    key: const Key('saveRecoveryPhrase'),
                    onPressed: () async {
                      final languageSeed = ref.read(
                        SettingsProviders.settings.select(
                          (settings) => settings.languageSeed,
                        ),
                      );
                      final seed = AppMnemomics.mnemonicListToSeed(
                        mnemonic!,
                        languageCode: languageSeed,
                      );
                      context.go(
                        IntroBackupConfirm.routerPage,
                        extra: {
                          'name': null,
                          'seed': seed,
                          'welcomeProcess': false,
                        },
                      );
                    },
                  ),
                ],
              )
            : const SizedBox(),
        error: (error) => const SizedBox(),
        loading: (loading) => const SizedBox(),
      ),
      backgroundColor: ArchethicTheme.background,
      appBar: SheetAppBar(
        title: localizations.recoveryPhrase,
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.go(HomePage.routerPage);
          },
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
            opacity: 0.7,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 120, bottom: 100),
          child: Column(
            children: <Widget>[
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
                                  seed: seed,
                                  wordList: mnemonic!,
                                  obscureSeed: true,
                                  explanation: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      AutoSizeText(
                                        localizations.dipslayPhraseExplanation,
                                        style: ArchethicThemeStyles
                                            .textStyleSize12W100Primary,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel2,
                                        style: ArchethicThemeStyles
                                            .textStyleSize14W600Primary,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel3,
                                        style: ArchethicThemeStyles
                                            .textStyleSize12W100Primary,
                                      ),
                                      Divider(
                                        height: 20,
                                        color: ArchethicTheme.text60,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel4,
                                        style: ArchethicThemeStyles
                                            .textStyleSize14W600Primary,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel5,
                                        style: ArchethicThemeStyles
                                            .textStyleSize12W100Primary,
                                      ),
                                      Divider(
                                        height: 20,
                                        color: ArchethicTheme.text60,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel6,
                                        style: ArchethicThemeStyles
                                            .textStyleSize14W600Primary,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AutoSizeText(
                                        localizations.backupSafetyLabel7,
                                        style: ArchethicThemeStyles
                                            .textStyleSize12W100Primary,
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
