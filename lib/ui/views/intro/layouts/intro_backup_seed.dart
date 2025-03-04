import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/intro/layouts/seed_language_switch.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/settings/mnemonic_display.dart';
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
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _generateSeedAndMnemonic('en');
    ref.read(SettingsProviders.settings.notifier).setLanguageSeed('en');
  }

  void _generateSeedAndMnemonic(String languageCode) {
    setState(() {
      seed = AppSeeds.generateSeed();
      mnemonic = AppMnemomics.seedToMnemonic(seed!, languageCode: languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String>(
      SettingsProviders.settings.select((settings) => settings.languageSeed),
      (String? previousLanguage, String newLanguage) {
        _generateSeedAndMnemonic(newLanguage);
      },
    );

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
        BtnFooterPrimary(
          buttonText: localizations.iveBackedItUp,
          onTap: () async {
            context.go(
              IntroBackupConfirm.routerPage,
              extra: {'name': widget.name, 'seed': seed},
            );
          },
          isLocked: isPressed,
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
    final textStyle = Theme.of(context).textTheme.bodySmallWithOpacity;
    final boldTextStyle = textStyle.copyWith(
      fontWeight: FontWeightTelegraf.fontWeightBold,
    );

    return mnemonic != null
        ? Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Column(
              children: [
                const SeedLanguageSwitch(),
                const SizedBox(height: 10),
                MnemonicDisplay(
                  seed: seed!,
                  wordList: mnemonic!,
                  displaySeedHex: false,
                  explanation: Align(
                    alignment: Alignment.topLeft,
                    child: _buildExplanationText(
                      localizations.recoveryPhraseIntroExplanation1,
                      localizations.recoveryPhraseIntroExplanation2,
                      localizations.recoveryPhraseIntroExplanation3,
                      textStyle,
                      boldTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildExplanationText(
    String text1,
    String text2,
    String text3,
    TextStyle textStyle,
    TextStyle boldTextStyle,
  ) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: text1, style: textStyle),
          TextSpan(text: text2, style: boldTextStyle),
          TextSpan(text: text3, style: textStyle),
        ],
      ),
    );
  }
}
