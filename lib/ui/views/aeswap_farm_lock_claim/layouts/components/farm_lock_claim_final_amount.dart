import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_claim/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockClaimFinalAmount extends ConsumerWidget {
  const FarmLockClaimFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockClaim = ref.watch(farmLockClaimFormNotifierProvider);
    final finalAmount = farmLockClaim.finalAmount;
    final timeout = ref.watch(
      farmLockClaimFormNotifierProvider
          .select((value) => value.failure != null),
    );

    return Row(
      children: [
        if (finalAmount != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                AppLocalizations.of(context)!.farmLockClaimFinalAmount,
                style: AppTextStyles.bodyLarge(context),
              ),
              SelectableText(
                '${finalAmount.formatNumber(precision: 8)} ${farmLockClaim.rewardToken!.symbol}',
                style: AppTextStyles.bodyLargeSecondaryColor(context),
              ),
            ],
          )
        else if (timeout)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                AppLocalizations.of(context)!.farmLockClaimFinalAmount,
                style: AppTextStyles.bodyLarge(context),
              ),
              SelectableText(
                AppLocalizations.of(context)!.finalAmountNotRecovered,
                style: AppTextStyles.bodyLarge(context),
              ),
            ],
          ),
      ],
    );
  }
}
