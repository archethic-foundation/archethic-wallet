import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveFinalAmount extends ConsumerWidget {
  const LiquidityRemoveFinalAmount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);
    if (liquidityRemove.liquidityRemoveOk == false)
      return const SizedBox.shrink();

    final finalAmountToken1 = liquidityRemove.finalAmountToken1;
    final finalAmountToken2 = liquidityRemove.finalAmountToken2;
    final finalAmountLPToken = liquidityRemove.finalAmountLPToken;
    final timeout = ref.watch(
      liquidityRemoveFormNotifierProvider
          .select((value) => value.failure != null),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (finalAmountToken1 != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!
                        .liquidityRemoveFinalAmountTokenObtained,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  SelectableText(
                    '${finalAmountToken1.formatNumber(precision: 8)} ${liquidityRemove.token1!.symbol}',
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
                          AppLocalizations.of(context)!
                              .liquidityRemoveFinalAmountTokenObtained,
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
                      children: [
                        SelectableText(
                          AppLocalizations.of(context)!
                              .liquidityRemoveFinalAmountTokenObtained,
                          style: AppTextStyles.bodyLarge(context),
                        ),
                        SelectableText(
                          ' ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      ],
                    ),
          ],
        ),
        Row(
          children: [
            if (finalAmountToken2 != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!
                        .liquidityRemoveFinalAmountTokenObtained,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  SelectableText(
                    '${finalAmountToken2.formatNumber(precision: 8)} ${liquidityRemove.token2!.symbol}',
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
                          AppLocalizations.of(context)!
                              .liquidityRemoveFinalAmountTokenObtained,
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
                      children: [
                        SelectableText(
                          AppLocalizations.of(context)!
                              .liquidityRemoveFinalAmountTokenObtained,
                          style: AppTextStyles.bodyLarge(context),
                        ),
                        SelectableText(
                          ' ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      ],
                    ),
          ],
        ),
        Row(
          children: [
            if (finalAmountLPToken != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!
                        .liquidityRemoveFinalAmountTokenBurned,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  SelectableText(
                    '${finalAmountLPToken.formatNumber(precision: 8)} ${finalAmountLPToken > 1 ? 'LP Tokens' : 'LP Token'}',
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
                          AppLocalizations.of(context)!
                              .liquidityRemoveFinalAmountTokenBurned,
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
                      children: [
                        SelectableText(
                          AppLocalizations.of(context)!
                              .liquidityRemoveFinalAmountTokenBurned,
                          style: AppTextStyles.bodyLarge(context),
                        ),
                        SelectableText(
                          ' ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      ],
                    ),
          ],
        ),
      ],
    );
  }
}
