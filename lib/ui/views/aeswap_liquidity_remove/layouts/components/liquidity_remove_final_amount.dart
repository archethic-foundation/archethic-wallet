import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/text/gradient_text.dart';
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
    final finalAmountToken1 = liquidityRemove.finalAmountToken1;
    final finalAmountToken2 = liquidityRemove.finalAmountToken2;
    final finalAmountLPToken = liquidityRemove.finalAmountLPToken;
    final timeout = ref.watch(
      liquidityRemoveFormNotifierProvider
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
              if (finalAmountToken1 != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .liquidityRemoveFinalAmountTokenObtained,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightSemibold,
                          ),
                    ),
                    GradientText(
                      '${finalAmountToken1.formatNumber(precision: 8)} ${liquidityRemove.token1!.symbol}',
                      gradient: ArchethicGradients.gradientArchethic,
                      style: Theme.of(context).textTheme.bodyLarge!,
                    ),
                  ],
                )
              else if (timeout)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .liquidityRemoveFinalAmountTokenObtained,
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
              if (finalAmountToken2 != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .liquidityRemoveFinalAmountTokenObtained,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightSemibold,
                          ),
                    ),
                    GradientText(
                      '${finalAmountToken2.formatNumber(precision: 8)} ${liquidityRemove.token2!.symbol}',
                      gradient: ArchethicGradients.gradientArchethic,
                      style: Theme.of(context).textTheme.bodyLarge!,
                    ),
                  ],
                )
              else if (timeout)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .liquidityRemoveFinalAmountTokenObtained,
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
              if (finalAmountLPToken != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .liquidityRemoveFinalAmountTokenBurned,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightSemibold,
                          ),
                    ),
                    GradientText(
                      '${finalAmountLPToken.formatNumber(precision: 8)} ${finalAmountLPToken > 1 ? 'LP Tokens' : 'LP Token'}',
                      gradient: ArchethicGradients.gradientArchethic,
                      style: Theme.of(context).textTheme.bodyLarge!,
                    ),
                  ],
                )
              else if (timeout)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!
                          .liquidityRemoveFinalAmountTokenBurned,
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
