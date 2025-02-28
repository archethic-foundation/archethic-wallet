import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/intro/layouts/seed_language_switch.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/settings/mnemonic_display.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:aewallet/util/seeds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  bool _listenerInitialized = false;

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
    if (!_listenerInitialized) {
      ref.listen<String>(
        SettingsProviders.settings.select((settings) => settings.languageSeed),
        (String? previousLanguage, String newLanguage) {
          setState(() {
            seed = AppSeeds.generateSeed();
            mnemonic = AppMnemomics.seedToMnemonic(
              seed!,
              languageCode: newLanguage,
            );
            _listenerInitialized = false;
          });
        },
      );
      _listenerInitialized = true;
    }

    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      backgroundImage: ArchethicTheme.backgroundWelcome,
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

    return SheetAppBar(
      title: localizations.yourRecoveryPhrase,
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
            child: Column(
              children: [
                const SeedLanguageSwitch(),
                const SizedBox(
                  height: 10,
                ),
                MnemonicDisplay(
                  seed: seed!,
                  wordList: mnemonic!,
                  displaySeedHex: false,
                  explanation: Align(
                    alignment: Alignment.topLeft,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: localizations.recoveryPhraseIntroExplanation1,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmallWithOpacity,
                          ),
                          TextSpan(
                            text: localizations.recoveryPhraseIntroExplanation2,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmallWithOpacity
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          TextSpan(
                            text: localizations.recoveryPhraseIntroExplanation3,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmallWithOpacity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
