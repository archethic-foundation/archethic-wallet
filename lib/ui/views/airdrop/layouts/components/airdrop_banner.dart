import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/feature_flags.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/ui/figma_components/box/box_purple_gradient.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participants_count.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;

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
          error: (error, stackTrace) {
            return const SizedBox.shrink();
          },
          loading: () {
            return const SizedBox.shrink();
          },
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
      child: BoxPurpleGradient(
        content: InkWell(
          onTap: onButtonPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightBold,
                            fontSize: state == AirdropState.newParticipation
                                ? 26
                                : 22,
                            shadows: [
                              const Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 8,
                              ),
                            ],
                            height: 1.2,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightBold,
                            fontSize: state == AirdropState.newParticipation
                                ? 26
                                : 22,
                            color: Colors.white,
                            height: 1.2,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
                width: MediaQuery.of(context).size.width,
              ),
              const AirdropParticipantsCount(
                withShadow: true,
              ),
              if (state != AirdropState.ok)
                Text(
                  '\$${ucoPerParticipant?.formatNumber(precision: 0).replaceAll('.', '') ?? ''} ${localizations.airdropPerParticipant}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMediumWithOpacity
                      .copyWith(
                    fontWeight: FontWeightTelegraf.fontWeightSemibold,
                    shadows: [
                      const Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 10),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AutoSizeText(
                    description,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmallWithOpacity
                        .copyWith(
                      fontWeight: FontWeightTelegraf.fontWeightRegular,
                      shadows: [
                        const Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 10),
              BtnPrimary(
                buttonText: buttonText,
                onTap: onButtonPressed,
                btnPrimaryType: BtnPrimaryType.dark,
              ),
            ],
          ),
        ),
        onClose: () async {
          await ref
              .read(SettingsProviders.settings.notifier)
              .setActiveAirdrop(false);
        },
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
