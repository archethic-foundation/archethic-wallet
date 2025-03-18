import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_banner.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_bloc_invitation.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_detail_personal_multiplier.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_detail_referral_multiplier.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_personal_multiplier.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_personal_rewards.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_referral_multiplier.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropParticipateStepDashboardSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepDashboardSheet({
    required this.airdropState,
    required this.personalMultiplier,
    super.key,
  });

  final AirdropState? airdropState;
  final int personalMultiplier;

  @override
  ConsumerState<AirdropParticipateStepDashboardSheet> createState() =>
      _AirdropParticipateStepDashboardSheetState();
}

class _AirdropParticipateStepDashboardSheetState
    extends ConsumerState<AirdropParticipateStepDashboardSheet> {
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
                        const SizedBox(
                          height: 120,
                          child: Row(
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
                        ),
                        const SizedBox(height: 20),
                        const AirdropPersonalRewards(),
                        const AirdropBlocInvitation(),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  ColoredBox(
                    color: Colors.white.withValues(alpha: 0.1),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          AirdropDetailPersonalMultiplier(),
                          SizedBox(height: 10),
                          AirdropDetailReferralMultiplier(),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
