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
    final farmLockWithdraw =
        ref.watch(FarmLockWithdrawFormProvider.farmLockWithdrawForm);
    if (farmLockWithdraw.farmLockWithdrawOk == false) {
      return const SizedBox.shrink();
    }

    final finalAmountReward = farmLockWithdraw.finalAmountReward;
    final finalAmountWithdraw = farmLockWithdraw.finalAmountWithdraw;
    final timeout = ref.watch(
      FarmLockWithdrawFormProvider.farmLockWithdrawForm
          .select((value) => value.failure != null),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (finalAmountWithdraw != null)
          SelectableText(
            '${AppLocalizations.of(context)!.farmLockWithdrawFinalAmount} ${finalAmountWithdraw.formatNumber(precision: 8)} ${finalAmountWithdraw > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
            style: TextStyle(
              fontSize: aedappfm.Responsive.fontSizeFromValue(
                context,
                desktopValue: 13,
              ),
            ),
          )
        else if (timeout == false)
          Row(
            children: [
              SelectableText(
                AppLocalizations.of(context)!.farmLockWithdrawFinalAmount,
                style: TextStyle(
                  fontSize: aedappfm.Responsive.fontSizeFromValue(
                    context,
                    desktopValue: 13,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          )
        else
          SelectableText(
            '${AppLocalizations.of(context)!.farmLockWithdrawFinalAmount} ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
            style: TextStyle(
              fontSize: aedappfm.Responsive.fontSizeFromValue(
                context,
                desktopValue: 13,
              ),
            ),
          ),
        if (finalAmountReward != null)
          if ((farmLockWithdraw.isFarmClose &&
                  farmLockWithdraw.rewardAmount! > 0) ||
              farmLockWithdraw.isFarmClose == false)
            SelectableText(
              '${AppLocalizations.of(context)!.farmLockWithdrawFinalAmountReward} ${finalAmountReward.formatNumber(precision: 8)} ${farmLockWithdraw.rewardToken!.symbol}',
              style: TextStyle(
                fontSize: aedappfm.Responsive.fontSizeFromValue(
                  context,
                  desktopValue: 13,
                ),
              ),
            )
          else
            const SizedBox.shrink()
        else if (timeout == false)
          if (farmLockWithdraw.rewardAmount! > 0)
            Row(
              children: [
                SelectableText(
                  AppLocalizations.of(context)!
                      .farmLockWithdrawFinalAmountReward,
                  style: TextStyle(
                    fontSize: aedappfm.Responsive.fontSizeFromValue(
                      context,
                      desktopValue: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(strokeWidth: 1),
                ),
              ],
            )
          else
            const SizedBox.shrink()
        else
          SelectableText(
            '${AppLocalizations.of(context)!.farmLockWithdrawFinalAmountReward} ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
            style: TextStyle(
              fontSize: aedappfm.Responsive.fontSizeFromValue(
                context,
                desktopValue: 13,
              ),
            ),
          ),
      ],
    );
  }
}
