import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/application/airdrop/airdrop_notifier.dart';
import 'package:aewallet/application/feature_flags.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/model/airdrop.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/airddrop_dashboard/layouts/airdrop_dashboard_sheet.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/airdrop_participate_sheet.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participants_count.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class AirdropBanner extends ConsumerWidget {
  const AirdropBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeAirdrop = ref.watch(
      SettingsProviders.settings.select((settings) => settings.activeAirdrop),
    );
    if (!activeAirdrop) return const SizedBox();

    final flag = ref.watch(getFeatureFlagProvider(kApplicationCode, 'airdrop'));
    final airdrop = ref.watch(airdropNotifierProvider).value;

    return flag.when(
      data: (data) {
        if (data != true) return const SizedBox.shrink();
        if (airdrop == null) {
          return _buildAirdropContent(
            context,
            ref,
            AirdropState.newParticipation,
          );
        }

        return _determineAirdropState(context, ref, airdrop);
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }

  Widget _determineAirdropState(
    BuildContext context,
    WidgetRef ref,
    Airdrop airdrop,
  ) {
    final isMailConfirmed = airdrop.isMailConfirmed;
    final personalLPAmount = airdrop.personalLPAmount;

    if (isMailConfirmed == null) {
      if (personalLPAmount == null || personalLPAmount == 0) {
        return _buildAirdropContent(
          context,
          ref,
          AirdropState.newParticipation,
        );
      } else if (personalLPAmount > 0) {
        return _buildAirdropContent(context, ref, AirdropState.shouldAddMail);
      }
    }

    if (isMailConfirmed != null) {
      if (!isMailConfirmed) {
        if (personalLPAmount! > 0) {
          return _buildAirdropContent(
            context,
            ref,
            AirdropState.shouldConfirmMail,
          );
        } else if (personalLPAmount == 0) {
          return _buildAirdropContent(
            context,
            ref,
            AirdropState.shouldConfirmMailAndFarm,
          );
        }
      } else if (isMailConfirmed) {
        if (personalLPAmount == 0) {
          return _buildAirdropContent(context, ref, AirdropState.shouldFarm);
        } else if (personalLPAmount! > 0) {
          return _buildAirdropContent(context, ref, AirdropState.ok);
        }
      }
    }

    return _buildAirdropContent(context, ref, AirdropState.newParticipation);
  }

  Widget _buildAirdropContent(
    BuildContext context,
    WidgetRef ref,
    AirdropState state,
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
          await context.push(AirdropParticipateSheet.routerPage);
        };
        break;
      case AirdropState.shouldAddMail:
        title = localizations.airdropBannerShouldAddMailTitle;
        description = localizations.airdropBannerShouldAddMailDesc;
        buttonText = localizations.airdropBannerShouldAddMailBtn;
        onButtonPressed = () async {
          ref.read(airdropPersonalLPProvider);
          await context.push(AirdropDashboardSheet.routerPage);
        };
        break;
      case AirdropState.shouldFarm:
        title = localizations.airdropBannerShouldFarmTitle;
        description = localizations.airdropBannerShouldFarmDesc;
        buttonText = localizations.airdropBannerShouldFarmBtn;
        onButtonPressed = () async {
          ref.read(airdropPersonalLPProvider);
          await context.push(AirdropDashboardSheet.routerPage);
        };
        break;
      case AirdropState.shouldConfirmMailAndFarm:
        title = localizations.airdropBannerShouldConfirmMailAndFarmTitle;
        description = localizations.airdropBannerShouldConfirmMailAndFarmDesc;
        buttonText = localizations.airdropBannerShouldConfirmMailAndFarmBtn;
        onButtonPressed = () async {
          ref.read(airdropPersonalLPProvider);
          final airdrop = await ref.read(airdropNotifierProvider.future);
          await context.push(
            Uri(
              path: AirdropParticipateSheet.routerPage,
              queryParameters: {
                'airdropMailAddress': airdrop?.email,
                'airdropProcessStepIndex':
                    AirdropProcessStep.confirmEmail.index.toString(),
              },
            ).toString(),
          );
        };
        break;
      case AirdropState.shouldConfirmMail:
        title = localizations.airdropBannerShouldConfirmMailTitle;
        description = localizations.airdropBannerShouldConfirmMailDesc;
        buttonText = localizations.airdropBannerShouldConfirmMailBtn;
        onButtonPressed = () async {
          ref.read(airdropPersonalLPProvider);
          final airdrop = await ref.read(airdropNotifierProvider.future);
          await context.push(
            Uri(
              path: AirdropParticipateSheet.routerPage,
              queryParameters: {
                'airdropMailAddress': airdrop?.email,
                'airdropProcessStepIndex':
                    AirdropProcessStep.confirmEmail.index.toString(),
              },
            ).toString(),
          );
        };
        break;
      case AirdropState.ok:
        title = localizations.airdropBannerTitle;
        onButtonPressed = () async {
          ref.read(airdropPersonalLPProvider);
          await context.push(AirdropDashboardSheet.routerPage);
        };
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: _buildBannerContainer(
        context,
        height: state == AirdropState.ok ? 90 : 235,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InkWell(
              onTap: buttonText == null ? onButtonPressed : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state != AirdropState.ok)
                    const AirdropParticipantsCount(),
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
                  if (buttonText != null)
                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width,
                    ),
                  if (buttonText != null)
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
    required double height,
    required Widget child,
  }) {
    return aedappfm.BlockInfo(
      borderWith: 0,
      paddingEdgeInsetsClipRRect: EdgeInsets.zero,
      paddingEdgeInsetsInfo: EdgeInsets.zero,
      height: height,
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
