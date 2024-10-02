import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDepositFinalAmount extends ConsumerWidget {
  const FarmLockDepositFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    final finalAmount = farmLockDeposit.finalAmount;
    final timeout = ref.watch(
      farmLockDepositFormNotifierProvider
          .select((value) => value.failure != null),
    );

    return Row(
      children: [
        if (finalAmount != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                AppLocalizations.of(context)!.farmLockDepositFinalAmount,
                style: AppTextStyles.bodyLarge(context),
              ),
              SelectableText(
                '${finalAmount.formatNumber(precision: 8)} ${finalAmount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                style: AppTextStyles.bodyLargeSecondaryColor(context),
              ),
            ],
          )
        else
          timeout == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.farmLockDepositFinalAmount,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(strokeWidth: 1),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.farmLockDepositFinalAmount,
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
