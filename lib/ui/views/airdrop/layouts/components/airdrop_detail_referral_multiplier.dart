import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_modal_invitation.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_modal_referral_multiplier.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AirdropDetailReferralMultiplier extends ConsumerWidget {
  const AirdropDetailReferralMultiplier({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);

    return Column(
      children: [
        Text(
          localizations.airdropDashboardDetailReferralMultiplierTitle,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeightTelegraf.fontWeightSemibold,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          textAlign: TextAlign.center,
          localizations.airdropDashboardDetailReferralMultiplierDesc,
          style: Theme.of(context).textTheme.bodyMediumWithOpacity,
        ),
        const SizedBox(
          height: 20,
        ),
        aedappfm.BlockInfo(
          width: MediaQuery.of(context).size.width,
          paddingEdgeInsetsClipRRect: EdgeInsets.zero,
          paddingEdgeInsetsInfo: const EdgeInsets.all(10),
          blockInfoColor: aedappfm.BlockInfoColor.neutral,
          info: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations
                    .airdropDashboardDetailReferralMultiplierReferralsRegistered,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                airdropForm.referralRegistered.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        aedappfm.BlockInfo(
          width: MediaQuery.of(context).size.width,
          paddingEdgeInsetsClipRRect: EdgeInsets.zero,
          paddingEdgeInsetsInfo: const EdgeInsets.all(10),
          blockInfoColor: aedappfm.BlockInfoColor.neutral,
          info: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations
                    .airdropDashboardDetailReferralMultiplierReferralsParticipant,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '${airdropForm.referralParticipant}/${airdropForm.referralParticipantRewarded}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (airdropForm.referralParticipant >
            airdropForm.referralParticipantRewarded)
          Column(
            children: [
              MessageBox(
                messageBoxType: MessageBoxType.warning,
                content: Text.rich(
                  TextSpan(
                    text: '',
                    children: <InlineSpan>[
                      TextSpan(
                        text: localizations
                            .airdropDashboardDetailReferralMultiplierWarningDesc1,
                        style:
                            Theme.of(context).textTheme.bodyMediumWithOpacity,
                      ),
                      TextSpan(
                        text:
                            '${airdropForm.referralParticipant}${localizations.airdropDashboardDetailReferralMultiplierWarningDesc2}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeightTelegraf.fontWeightSemibold,
                            ),
                      ),
                      TextSpan(
                        text: localizations
                            .airdropDashboardDetailReferralMultiplierWarningDesc3,
                        style:
                            Theme.of(context).textTheme.bodyMediumWithOpacity,
                      ),
                      TextSpan(
                        text: localizations
                            .airdropDashboardDetailReferralMultiplierWarningDesc4(
                          airdropForm.referralParticipantRewarded,
                          airdropForm.referralParticipant,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeightTelegraf.fontWeightSemibold,
                            ),
                      ),
                      TextSpan(
                        text: localizations
                            .airdropDashboardDetailReferralMultiplierWarningDesc5,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeightTelegraf.fontWeightSemibold,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        aedappfm.BlockInfo(
          width: MediaQuery.of(context).size.width,
          paddingEdgeInsetsClipRRect: EdgeInsets.zero,
          paddingEdgeInsetsInfo: const EdgeInsets.all(10),
          blockInfoColor: aedappfm.BlockInfoColor.neutral,
          info: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.airdropDashboardDetailReferrallMultiplierValue,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '${airdropForm.referralMultiplier}x',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BtnPrimary(
          buttonText: localizations.airdropDashboardDetailReferralMultiplierBtn,
          onTap: () async {
            await CupertinoScaffold.showCupertinoModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  heightFactor: 1,
                  child: Scaffold(
                    backgroundColor: aedappfm.AppThemeBase.sheetBackground
                        .withValues(alpha: 0.2),
                    body: const AirdropModalReferralMultiplier(),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        BtnPrimary(
          btnPrimaryType: BtnPrimaryType.outlinePrimary,
          buttonText: localizations.airdropDashboardBlocInvitationBtn,
          onTap: () async {
            await CupertinoScaffold.showCupertinoModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  heightFactor: 1,
                  child: Scaffold(
                    backgroundColor: aedappfm.AppThemeBase.sheetBackground
                        .withValues(alpha: 0.2),
                    body: const AirdropModalInvitation(),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
