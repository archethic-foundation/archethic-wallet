import 'dart:ui';

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/version.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/checkbox/checkbox_confirm.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_import_seed.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_new_wallet_get_first_infos.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/ui/widgets/dialogs/environment_dialog.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroWelcome extends ConsumerStatefulWidget {
  const IntroWelcome({super.key});

  static const routerPage = '/intro_welcome';
  @override
  ConsumerState<IntroWelcome> createState() => _IntroWelcomeState();
}

class _IntroWelcomeState extends ConsumerState<IntroWelcome>
    implements SheetSkeletonInterface {
  bool cguChecked = false;

  @override
  Widget build(BuildContext context) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      backgroundImage: ArchethicTheme.backgroundWelcome,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return _Footer(
      isConnectivityAvailable:
          connectivityStatusProvider == ConnectivityStatus.isConnected,
      cguChecked: cguChecked,
      onToggleCGU: (newValue) {
        setState(() {
          cguChecked = newValue!;
        });
      },
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.only(top: 25),
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 30,
                child: SvgPicture.asset(
                  '${ArchethicTheme.assetsFolder}Archethic - Logo.svg',
                  colorFilter:
                      ColorFilter.mode(ArchethicTheme.text, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      ),
      systemOverlayStyle: ArchethicTheme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: const [
        LanguageToggleButton(),
      ],
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text.rich(
            TextSpan(
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeightTelegraf.fontWeightUltrabold,
                    height: 1.3,
                    textBaseline: TextBaseline.alphabetic, // Ajoutez ceci
                  ),
              children: [
                TextSpan(
                  text: localizations.welcomeTitle,
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Baseline(
                      baseline: 0.6,
                      baselineType: TextBaseline.alphabetic,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: ArchethicGradients.gradientArchethic,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          localizations.welcomeTitle2,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: 40,
                                color: Colors.black,
                                fontWeight: FontWeightTelegraf.fontWeightBlack,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: localizations.welcomeDesc1,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMediumWithOpacity
                      .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
                ),
                TextSpan(
                  text: localizations.welcomeDesc2,
                  style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: localizations.welcomeDesc3,
                  style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                ),
                TextSpan(
                  text: localizations.welcomeDesc4,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMediumWithOpacity
                      .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
                ),
                TextSpan(
                  text: localizations.welcomeDesc5,
                  style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                ),
                TextSpan(
                  text: localizations.welcomeDesc6,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMediumWithOpacity
                      .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
                ),
                TextSpan(
                  text: localizations.welcomeDesc7,
                  style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                ),
                TextSpan(
                  text: localizations.welcomeDesc8,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMediumWithOpacity
                      .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
                ),
                TextSpan(
                  text: localizations.welcomeDesc9,
                  style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            localizations.welcomeDesc10,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
          ),
          const SizedBox(
            height: 20,
          ),
          CheckboxConfirm(
            text: Row(
              children: [
                Text(
                  localizations.welcomeConfirmCGU1,
                  style: Theme.of(context).textTheme.bodySmallWithOpacity,
                ),
                InkWell(
                  onTap: () async {
                    await launchUrl(
                      Uri.parse(
                        'https://www.archethic.net/privacy-policy-wallet.html',
                      ),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Text(
                    localizations.welcomeConfirmCGU2,
                    style: Theme.of(context).textTheme.bodySmallLink,
                  ),
                ),
              ],
            ),
            value: cguChecked,
            onChanged: (newValue) {
              setState(() {
                cguChecked = newValue;
              });
            },
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

class _Footer extends ConsumerWidget {
  const _Footer({
    required this.isConnectivityAvailable,
    required this.cguChecked,
    required this.onToggleCGU,
  });

  final bool isConnectivityAvailable;
  final bool cguChecked;
  final Function(bool? newValue) onToggleCGU;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _ButtonNewWallet(
          cguChecked: cguChecked,
        ),
        const SizedBox(
          height: 10,
        ),
        _ButtonImportWallet(
          cguChecked: cguChecked,
        ),
        const SizedBox(
          height: 10,
        ),
        const _VersionInfo(),
      ],
    );
  }
}

class _VersionInfo extends ConsumerWidget {
  const _VersionInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Consumer(
            builder: (context, ref, child) {
              final asyncVersionString = ref.watch(
                versionStringProvider(
                  AppLocalizations.of(context)!,
                ),
              );

              return Text(
                asyncVersionString.asData?.value ?? '',
                textAlign: TextAlign.left,
                style: ArchethicThemeStyles.textStyleSize10W100Primary,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ButtonNewWallet extends ConsumerWidget {
  const _ButtonNewWallet({required this.cguChecked});

  final bool cguChecked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return BtnFooterPrimary(
      buttonText: localizations.newWallet,
      onTap: () async {
        if (cguChecked) {
          await ref
              .read(SettingsProviders.settings.notifier)
              .setEnvironment(aedappfm.Environment.mainnet);

          context.go(
            IntroNewWalletGetFirstInfos.routerPage,
          );
        }
      },
      isLocked: !cguChecked,
      key: const Key('newWallet'),
    );
  }
}

class _ButtonImportWallet extends ConsumerWidget {
  const _ButtonImportWallet({required this.cguChecked});

  final bool cguChecked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return BtnFooterPrimary(
      buttonText: localizations.importWallet,
      onTap: () async {
        if (cguChecked) {
          final environment = await context.push(EnvironmentDialog.routerPage);
          if (environment != null) {
            await ref
                .read(SettingsProviders.settings.notifier)
                .setEnvironment(environment as aedappfm.Environment);
          }
          context.go(IntroImportSeedPage.routerPage);
        }
      },
      isLocked: !cguChecked,
      key: const Key('importWallet'),
      btnPrimaryType: BtnFooterPrimaryType.outlinePrimary,
    );
  }
}

class LanguageToggleButton extends ConsumerStatefulWidget {
  const LanguageToggleButton({
    super.key,
  });

  @override
  ConsumerState<LanguageToggleButton> createState() =>
      LanguageToggleButtonState();
}

class LanguageToggleButtonState extends ConsumerState<LanguageToggleButton> {
  bool isEnglishSelected = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = Localizations.localeOf(context);
      setState(() {
        isEnglishSelected = locale.languageCode != 'fr';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 10),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isEnglishSelected = !isEnglishSelected;
          });

          if (isEnglishSelected) {
            await ref
                .read(SettingsProviders.settings.notifier)
                .selectLanguage(AvailableLanguage.english);
          } else {
            await ref
                .read(SettingsProviders.settings.notifier)
                .selectLanguage(AvailableLanguage.french);
          }
        },
        child: Container(
          width: 120,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFF363346),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: isEnglishSelected ? 0 : 60,
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: ArchethicGradients.gradientArchethic,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    localizations.languageEnglish,
                    style: isEnglishSelected
                        ? Theme.of(context).textTheme.bodySmall
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .color!
                                  .withOpacity(0.5),
                            ),
                  ),
                  Text(
                    localizations.languageFrancais,
                    style: !isEnglishSelected
                        ? Theme.of(context).textTheme.bodySmall
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .color!
                                  .withOpacity(0.5),
                            ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
