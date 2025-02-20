import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/feature_flags.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participants_count.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:numeral/numeral.dart';

class AirdropBanner extends ConsumerWidget {
  const AirdropBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeAirdrop = ref.watch(
      SettingsProviders.settings.select((settings) => settings.activeAirdrop),
    );

    final flag = ref
        .watch(getFeatureFlagProvider(kApplicationCode, 'airdrop'))
        .valueOrNull;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    if (activeAirdrop == false ||
        flag != true ||
        connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
      return const SizedBox.shrink();
    }

    return ref.watch(airdropBannerStatusProvider).when(
          skipLoadingOnReload: true,
          error: (error, stackTrace) => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
          data: (bannerStatus) => _buildAirdropContent(
            context,
            ref,
            bannerStatus.state,
            bannerStatus.email,
          ),
        );
  }

  Widget _buildAirdropContent(
    BuildContext context,
    WidgetRef ref,
    AirdropState state,
    String? email,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final titleTextStyle = AppTextStyles.bodyLarge(context).copyWith(
      fontWeight: FontWeight.bold,
      fontSize: state == AirdropState.newParticipation ? 26 : 22,
    );
    final buttonTextStyle = AppTextStyles.bodyMedium(context).copyWith(
      fontWeight: FontWeight.bold,
    );

    String title;
    String? description;
    String? buttonText;
    VoidCallback? onButtonPressed;

    switch (state) {
      case AirdropState.newParticipation:
        title = localizations.airdropBannerNewParticipationTitle;
        buttonText = localizations.airdropBannerNewParticipationBtn;
        onButtonPressed = () async {
          await ref
              .read(SettingsProviders.settings.notifier)
              .setMainScreenCurrentPage(4);
          ref.read(mainTabControllerProvider)!.animateTo(
                4,
                duration: Duration.zero,
              );
        };
        break;
      case AirdropState.shouldAddMail:
        title = localizations.airdropBannerShouldAddMailTitle;
        description = localizations.airdropBannerShouldAddMailDesc;
        buttonText = localizations.airdropBannerShouldAddMailBtn;
        onButtonPressed = () async {
          await ref
              .read(SettingsProviders.settings.notifier)
              .setMainScreenCurrentPage(4);
          ref.read(mainTabControllerProvider)!.animateTo(
                4,
                duration: Duration.zero,
              );
        };
        break;
      case AirdropState.shouldFarm:
        title = localizations.airdropBannerShouldFarmTitle;
        description = localizations.airdropBannerShouldFarmDesc;
        buttonText = localizations.airdropBannerShouldFarmBtn;
        onButtonPressed = () async {
          await ref
              .read(SettingsProviders.settings.notifier)
              .setMainScreenCurrentPage(3);
          ref.read(mainTabControllerProvider)!.animateTo(
                3,
                duration: Duration.zero,
              );
        };
        break;
      case AirdropState.shouldConfirmMailAndFarm:
        title = localizations.airdropBannerShouldConfirmMailAndFarmTitle;
        description = localizations.airdropBannerShouldConfirmMailAndFarmDesc;
        buttonText = localizations.airdropBannerShouldConfirmMailAndFarmBtn;
        onButtonPressed = () async {
          await ref
              .read(SettingsProviders.settings.notifier)
              .setMainScreenCurrentPage(4);
          ref.read(mainTabControllerProvider)!.animateTo(
                4,
                duration: Duration.zero,
              );
        };
        break;
      case AirdropState.shouldConfirmMail:
        title = localizations.airdropBannerShouldConfirmMailTitle;
        description = localizations.airdropBannerShouldConfirmMailDesc;
        buttonText = localizations.airdropBannerShouldConfirmMailBtn;
        onButtonPressed = () async {
          await ref
              .read(SettingsProviders.settings.notifier)
              .setMainScreenCurrentPage(4);
          ref.read(mainTabControllerProvider)!.animateTo(
                4,
                duration: Duration.zero,
              );
        };
        break;
      case AirdropState.ok:
        title = localizations.airdropBannerTitle;
        buttonText = localizations.airdropBannerOkBtn;
        onButtonPressed = () async {
          await ref
              .read(SettingsProviders.settings.notifier)
              .setMainScreenCurrentPage(4);
          ref.read(mainTabControllerProvider)!.animateTo(
                4,
                duration: Duration.zero,
              );
        };
        break;
    }

    double? ucoPerParticipant;
    ref.watch(airdropUCOPerParticipantFiatValueProvider).when(
          data: (airdropUCOPerParticipantFiatValue) {
            ucoPerParticipant = airdropUCOPerParticipantFiatValue;
          },
          loading: () {},
          error: (error, stack) {},
        );

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: _buildBannerContainer(
        context,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                onTap: onButtonPressed,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state != AirdropState.ok)
                      const AirdropParticipantsCount(),
                    if (state != AirdropState.ok)
                      Text(
                        '\$${ucoPerParticipant?.numeral(digits: 2) ?? ''} ${localizations.airdropPerParticipant}',
                        style: AppTextStyles.bodyMediumWithOpacity(context),
                      ),
                    if (state != AirdropState.ok) const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AutoSizeText(
                        title,
                        style: titleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (description != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AutoSizeText(
                          description,
                          style: AppTextStyles.bodySmallWithOpacity(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width,
                    ),
                    InkWell(
                      onTap: onButtonPressed,
                      child: IntrinsicWidth(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            buttonText,
                            style: buttonTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: IconButton(
                onPressed: () async {
                  await ref
                      .read(SettingsProviders.settings.notifier)
                      .setActiveAirdrop(false);
                },
                icon: const Icon(
                  Symbols.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerContainer(
    BuildContext context, {
    required Widget child,
  }) {
    return aedappfm.BlockInfo(
      borderWidth: 0,
      paddingEdgeInsetsClipRRect: EdgeInsets.zero,
      paddingEdgeInsetsInfo: EdgeInsets.zero,
      width: MediaQuery.of(context).size.width,
      info: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    aedappfm.ArchethicThemeBase.raspberry500,
                    aedappfm.ArchethicThemeBase.raspberry500.withOpacity(0.5),
                    aedappfm.ArchethicThemeBase.blue600.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
          _buildBackgroundImage(),
          child,
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      top: -60,
      left: -300,
      child: Transform.rotate(
        angle: -10 * 3.14 / 180,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              'assets/themes/archethic/logo_crystal.png',
            ),
          ),
        ),
      ),
    );
  }
}

enum AirdropState {
  newParticipation,
  shouldConfirmMail,
  shouldConfirmMailAndFarm,
  shouldAddMail,
  shouldFarm,
  ok,
}
