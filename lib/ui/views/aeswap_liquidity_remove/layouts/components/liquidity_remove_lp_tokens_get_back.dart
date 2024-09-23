/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveTokensGetBack extends ConsumerWidget {
  const LiquidityRemoveTokensGetBack({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

    if (liquidityRemove.calculationInProgress) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SelectableText(
              AppLocalizations.of(context)!.liquidityRemoveTokensGetBackHeader,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          SheetDetailCard(
            children: [
              Text(
                liquidityRemove.token1!.symbol,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.end,
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
              Text(
                liquidityRemove.token2!.symbol,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.end,
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
      );
    }

    if (liquidityRemove.lpTokenAmount <= 0 ||
        liquidityRemove.lpTokenAmount > liquidityRemove.lpTokenBalance) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SelectableText(
            AppLocalizations.of(context)!.liquidityRemoveTokensGetBackHeader,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        SheetDetailCard(
          children: [
            Text(
              liquidityRemove.token1!.symbol,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.end,
            ),
            Row(
              children: [
                SelectableText(
                  '+ ${liquidityRemove.token1AmountGetBack.formatNumber(precision: 8)} ${liquidityRemove.token1!.symbol}',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(
                  width: 5,
                ),
                if (liquidityRemove.token1 != null &&
                    liquidityRemove.token1AmountGetBack > 0)
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      liquidityRemove.token1!,
                      liquidityRemove.token1AmountGetBack,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SelectableText(
                          snapshot.data!,
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
              ],
            ),
          ],
        ),
        SheetDetailCard(
          children: [
            Text(
              liquidityRemove.token2!.symbol,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.end,
            ),
            Row(
              children: [
                SelectableText(
                  '+ ${liquidityRemove.token2AmountGetBack.formatNumber(precision: 8)} ${liquidityRemove.token2!.symbol}',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(
                  width: 5,
                ),
                if (liquidityRemove.token2 != null &&
                    liquidityRemove.token2AmountGetBack > 0)
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      liquidityRemove.token2!,
                      liquidityRemove.token2AmountGetBack,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SelectableText(
                          snapshot.data!,
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
