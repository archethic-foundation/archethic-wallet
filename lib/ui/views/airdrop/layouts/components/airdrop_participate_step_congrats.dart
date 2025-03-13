import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_banner.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_bloc_invitation.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_info_no_lp.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_lp_available.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_note_farm_level.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_personal_multiplier.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_personal_rewards.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_referral_multiplier.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_step_tab.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_wallet_lp_current_value.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AirdropParticipateStepCongratsSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepCongratsSheet({
    required this.airdropState,
    required this.personalMultiplier,
    super.key,
  });

  final AirdropState? airdropState;
  final int personalMultiplier;

  @override
  ConsumerState<AirdropParticipateStepCongratsSheet> createState() =>
      _AirdropParticipateStepCongratsSheetState();
}

class _AirdropParticipateStepCongratsSheetState
    extends ConsumerState<AirdropParticipateStepCongratsSheet> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;
    return Stack(
      children: [
        SingleChildScrollView(
          child: ArchethicScrollbar(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: 120,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    color: const Color(0xFF4B38A7).withValues(alpha: 0.3),
                    child: Column(
                      spacing: 10,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.done_all,
                              color: Color(0xFF00B67A),
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              localizations.airdropDashboardTitleBanner,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeightTelegraf.fontWeightBold,
                                  ),
                            ),
                          ],
                        ),
                        Text(
                          localizations.airdropDashboardDescBanner,
                          style:
                              Theme.of(context).textTheme.bodySmallWithOpacity,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          widget.airdropState != null &&
                                  widget.airdropState == AirdropState.ok
                              ? localizations.airdropDashboardTitle1
                              : localizations
                                  .airdropDashboardCompleteParticipationTitle,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight:
                                        FontWeightTelegraf.fontWeightSemibold,
                                  ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: AirdropPersonalMultiplier(),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: AirdropReferralMultiplier(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Flexible(
                              child: AirdropPersonalRewards(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const AirdropBlocInvitation(),
                        const SizedBox(height: 10),
                        const AirdropInfoNoLP(),
                        const SizedBox(height: 10),
                        const AirdropWalletLPCurrentValue(),
                        const AirdropLPAvailable(),
                        const SizedBox(height: 10),
                        const AirdropStepTab(),
                        const SizedBox(height: 20),
                        const AirdropNoteFarmLevel(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 20,
            ),
            child: BtnFooterPrimary(
              buttonText: widget.personalMultiplier > 0
                  ? localizations.airdropDashboardIncreaseAirdropBtn
                  : localizations.airdropDashboardNoLPBtn,
              onTap: () async {
                await ref
                    .read(SettingsProviders.settings.notifier)
                    .setMainScreenCurrentPage(3);
                ref.read(mainTabControllerProvider)!.animateTo(
                      3,
                      duration: Duration.zero,
                    );
                context.pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}
