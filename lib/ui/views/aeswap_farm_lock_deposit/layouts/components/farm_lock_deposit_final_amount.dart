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
    final farmLockDeposit =
        ref.watch(FarmLockDepositFormProvider.farmLockDepositForm);

    final finalAmount = farmLockDeposit.finalAmount;
    final timeout = ref.watch(
      FarmLockDepositFormProvider.farmLockDepositForm
          .select((value) => value.failure != null),
    );

    return Row(
      children: [
        if (finalAmount != null)
          SelectableText(
            '${AppLocalizations.of(context)!.farmLockDepositFinalAmount} ${finalAmount.formatNumber(precision: 8)} ${finalAmount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
            style: AppTextStyles.bodyLarge(context),
          )
        else
          timeout == false
              ? Row(
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
              : SelectableText(
                  '${AppLocalizations.of(context)!.farmLockDepositFinalAmount} ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
                  style: AppTextStyles.bodyLarge(context),
                ),
      ],
    );
  }
}
