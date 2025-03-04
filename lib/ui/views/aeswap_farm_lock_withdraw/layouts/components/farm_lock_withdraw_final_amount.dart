import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/text/gradient_text.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockWithdrawFinalAmount extends ConsumerWidget {
  const FarmLockWithdrawFinalAmount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);
    final finalAmountReward = farmLockWithdraw.finalAmountReward;
    final finalAmountWithdraw = farmLockWithdraw.finalAmountWithdraw;
    final timeout = ref.watch(
      farmLockWithdrawFormNotifierProvider
          .select((value) => value.failure != null),
    );

    return aedappfm.BlockInfo(
      blockInfoColor: aedappfm.BlockInfoColor.purple,
      borderWidth: 0,
      paddingEdgeInsetsInfo: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      info: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (finalAmountWithdraw != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.farmLockWithdrawFinalAmount,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightSemibold,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GradientText(
                        '${finalAmountWithdraw.formatNumber(precision: 8)} ${finalAmountWithdraw > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                        gradient: ArchethicGradients.gradientArchethic,
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                    ),
                  ],
                )
              else if (timeout)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.farmLockWithdrawFinalAmount,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightSemibold,
                          ),
                    ),
                    SelectableText(
                      AppLocalizations.of(context)!.finalAmountNotRecovered,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              if (finalAmountReward != null)
                if ((farmLockWithdraw.isFarmClose &&
                        farmLockWithdraw.rewardAmount! > 0) ||
                    farmLockWithdraw.isFarmClose == false)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        AppLocalizations.of(context)!
                            .farmLockWithdrawFinalAmountReward,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeightTelegraf.fontWeightSemibold,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GradientText(
                          '${finalAmountReward.formatNumber(precision: 8)} ${farmLockWithdraw.rewardToken!.symbol}',
                          gradient: ArchethicGradients.gradientArchethic,
                          style: Theme.of(context).textTheme.bodyLarge!,
                        ),
                      ),
                    ],
                  )
                else if (timeout)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        AppLocalizations.of(context)!
                            .farmLockWithdrawFinalAmountReward,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeightTelegraf.fontWeightSemibold,
                            ),
                      ),
                      SelectableText(
                        AppLocalizations.of(context)!.finalAmountNotRecovered,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
