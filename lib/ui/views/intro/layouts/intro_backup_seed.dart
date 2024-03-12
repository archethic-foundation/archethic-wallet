/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/settings/mnemonic_display.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:aewallet/util/seeds.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';

class IntroBackupSeedPage extends ConsumerStatefulWidget {
  const IntroBackupSeedPage({super.key, this.name});
  final String? name;

  static const routerPage = '/intro_backup';

  @override
  ConsumerState<IntroBackupSeedPage> createState() => _IntroBackupSeedState();
}

class _IntroBackupSeedState extends ConsumerState<IntroBackupSeedPage>
    implements SheetSkeletonInterface {
  String? seed;
  List<String>? mnemonic;
  bool? isPressed;

  @override
  void initState() {
    super.initState();
    isPressed = false;
    seed = AppSeeds.generateSeed();
    mnemonic = AppMnemomics.seedToMnemonic(seed!);
    ref.read(SettingsProviders.settings.notifier).setLanguageSeed('en');
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.iveBackedItUp,
          Dimens.buttonBottomDimens,
          key: const Key('iveBackedItUp'),
          onPressed: () async {
            context.go(
              IntroBackupConfirm.routerPage,
              extra: {'name': widget.name, 'seed': seed},
            );
          },
          disabled: isPressed == true,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    final preferences = ref.watch(SettingsProviders.settings);
    final language = ref.watch(
      SettingsProviders.settings.select(
        (settings) => settings.languageSeed,
      ),
    );

    return SheetAppBar(
      title: localizations.recoveryPhrase,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(
            IntroNewWalletDisclaimer.routerPage,
            extra: widget.name,
          );
        },
      ),
      widgetRight: connectivityStatusProvider == ConnectivityStatus.isConnected
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: TextButton(
                    onPressed: () async {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      seed = AppSeeds.generateSeed();
                      mnemonic = AppMnemomics.seedToMnemonic(
                        seed!,
                      );
                      ref
                          .read(
                            SettingsProviders.settings.notifier,
                          )
                          .setLanguageSeed('en');
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
                SizedBox(
                  height: 50,
                  width: 50,
                  child: TextButton(
                    onPressed: () async {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      seed = AppSeeds.generateSeed();
                      mnemonic = AppMnemomics.seedToMnemonic(
                        seed!,
                        languageCode: 'fr',
                      );

                      ref
                          .read(
                            SettingsProviders.settings.notifier,
                          )
                          .setLanguageSeed('fr');
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
          : const Padding(
              padding: EdgeInsets.only(
                right: 7,
                top: 7,
              ),
              child: IconNetworkWarning(
                alignment: Alignment.topRight,
              ),
            ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return mnemonic != null
        ? Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 20,
            ),
            child: MnemonicDisplay(
              seed: seed!,
              wordList: mnemonic!,
              explanation: Align(
                alignment: Alignment.topLeft,
                child: AutoSizeText(
                  localizations.recoveryPhraseIntroExplanation,
                  textAlign: TextAlign.justify,
                  style: ArchethicThemeStyles.textStyleSize12W100Primary,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
