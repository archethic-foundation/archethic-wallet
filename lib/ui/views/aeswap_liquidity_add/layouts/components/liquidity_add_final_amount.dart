import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddFinalAmount extends ConsumerWidget {
  const LiquidityAddFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(liquidityAddFormNotifierProvider);

    final finalAmount = liquidityAdd.finalAmount;
    final timeout = ref.watch(
      liquidityAddFormNotifierProvider.select((value) => value.failure != null),
    );

    return Row(
      children: [
        if (finalAmount != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                AppLocalizations.of(context)!.liquidityAddFinalAmount,
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
              ? Row(
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.liquidityAddFinalAmount,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(strokeWidth: 1),
                      ),
                    ),
                  ],
                )
              : SelectableText(
                  '${AppLocalizations.of(context)!.liquidityAddFinalAmount} ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
                  style: AppTextStyles.bodyLarge(context),
                ),
      ],
    );
  }
}
