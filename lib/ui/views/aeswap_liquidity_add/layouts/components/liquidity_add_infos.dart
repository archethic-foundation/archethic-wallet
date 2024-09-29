import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddInfos extends ConsumerWidget {
  const LiquidityAddInfos({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityAdd = ref.watch(liquidityAddFormNotifierProvider);
    if (liquidityAdd.token1 == null ||
        liquidityAdd.token2 == null ||
        (liquidityAdd.token1minAmount == 0 &&
            liquidityAdd.token2minAmount == 0 &&
            liquidityAdd.expectedTokenLP == 0)) {
      return const SizedBox.shrink();
    }

    if (liquidityAdd.calculationInProgress) {
      return Opacity(
        opacity: AppTextStyles.kOpacityText,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetDetailCard(
              children: [
                Tooltip(
                  message: liquidityAdd.token1!.symbol,
                  child: SelectableText(
                    '${AppLocalizations.of(context)!.liquidityAddInfosMinimumAmount} ${liquidityAdd.token1!.symbol.reduceSymbol()}: ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
            SheetDetailCard(
              children: [
                Tooltip(
                  message: liquidityAdd.token2!.symbol,
                  child: SelectableText(
                    '${AppLocalizations.of(context)!.liquidityAddInfosMinimumAmount} ${liquidityAdd.token2!.symbol.reduceSymbol()}: ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
            SheetDetailCard(
              children: [
                SelectableText(
                  AppLocalizations.of(context)!.liquidityAddInfosExpectedToken,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 5,
                  width: 5,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetDetailCard(
            children: [
              SelectableText(
                '${AppLocalizations.of(context)!.liquidityAddInfosMinimumAmount} ${liquidityAdd.token1!.symbol}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Tooltip(
                message: liquidityAdd.token1!.symbol,
                child: SelectableText(
                  '${liquidityAdd.token1minAmount.formatNumber()} ${liquidityAdd.token1!.symbol.reduceSymbol()}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              SelectableText(
                '${AppLocalizations.of(context)!.liquidityAddInfosMinimumAmount} ${liquidityAdd.token2!.symbol}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SelectableText(
                '${liquidityAdd.token2minAmount.formatNumber()} ${liquidityAdd.token2!.symbol}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              SelectableText(
                AppLocalizations.of(context)!.liquidityAddInfosExpectedToken,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SelectableText(
                '${liquidityAdd.expectedTokenLP.formatNumber()} ${liquidityAdd.expectedTokenLP > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
