/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_price_impact.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_ratio.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/state.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapInfos extends ConsumerWidget {
  const SwapInfos({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(swapFormNotifierProvider);

    if (swap.tokenToSwap == null ||
        swap.tokenSwapped == null ||
        swap.pool == null ||
        swap.pool!.poolAddress.isEmpty) {
      return const SizedBox.shrink();
    }

    final tokenAddressRatioPrimary = swap.tokenToSwap!.address;

    final tvlAsyncValue =
        ref.watch(DexPoolProviders.estimatePoolTVLInFiat(swap.pool));

    if (swap.calculationInProgress) {
      return _buildLoadingState(context);
    }

    if (swap.tokenSwapped == null ||
        swap.tokenToSwap == null ||
        swap.pool == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRowWithFees(context, ref, swap),
                _buildRowWithPriceImpact(context, swap),
                _buildRowWithMinReceived(context, ref, swap),
                _buildRowWithTVL(context, tvlAsyncValue),
                _buildRowWithRatio(context, swap, tokenAddressRatioPrimary),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper method to build the loading state when calculations are in progress
  Widget _buildLoadingState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLoadingRow(
            context,
            AppLocalizations.of(context)!.swapInfosFees,
          ),
          _buildLoadingRow(
            context,
            AppLocalizations.of(context)!.swapInfosPriceImpact,
          ),
          _buildLoadingRow(
            context,
            AppLocalizations.of(context)!.swapInfosMinimumReceived,
          ),
          _buildLoadingRow(
            context,
            AppLocalizations.of(context)!.swapInfosTVL,
          ),
          _buildLoadingRow(
            context,
            AppLocalizations.of(context)!.swapInfosRatio,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingRow(BuildContext context, String label) {
    return SheetDetailCard(
      children: [
        SelectableText(label, style: AppTextStyles.bodyMedium(context)),
        const SizedBox(
          height: 5,
          width: 5,
          child: CircularProgressIndicator(strokeWidth: 1),
        ),
      ],
    );
  }

  Widget _buildRowWithFees(
    BuildContext context,
    WidgetRef ref,
    SwapFormState swap,
  ) {
    return SheetDetailCard(
      children: [
        SelectableText(
          AppLocalizations.of(context)!.swapInfosFees,
          style: AppTextStyles.bodyMedium(context),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Tooltip(
                  message: swap.tokenToSwap!.symbol,
                  child: SelectableText(
                    '${swap.swapTotalFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol.reduceSymbol()}',
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
                FutureBuilder<String>(
                  future: FiatValue().display(
                    ref,
                    swap.tokenToSwap!,
                    swap.swapTotalFees,
                    withParenthesis: false,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SelectableText(
                        snapshot.data!,
                        style: AppTextStyles.bodyMedium(context),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            if (swap.pool!.infos!.fees != 0)
              Text(
                '${AppLocalizations.of(context)!.swapInfosLiquidityProviderFees}\n(${swap.pool!.infos!.fees}%): ${swap.swapFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol}',
                style: AppTextStyles.bodyMedium(context),
                textAlign: TextAlign.end,
              ),
            if (swap.pool!.infos!.protocolFees != 0)
              Text(
                '${AppLocalizations.of(context)!.swapInfosProtocolFees}\n(${swap.pool!.infos!.protocolFees}%): ${swap.swapProtocolFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol}',
                style: AppTextStyles.bodyMedium(context),
                textAlign: TextAlign.end,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildRowWithPriceImpact(BuildContext context, SwapFormState swap) {
    return SheetDetailCard(
      children: [
        SelectableText(
          AppLocalizations.of(context)!.swapInfosPriceImpact,
          style: AppTextStyles.bodyMedium(context),
        ),
        DexPriceImpact(
          priceImpact: swap.priceImpact,
          withLabel: false,
          withOpacity: false,
          textStyle: AppTextStyles.bodyMedium(context),
        ),
      ],
    );
  }

  Widget _buildRowWithMinReceived(
    BuildContext context,
    WidgetRef ref,
    SwapFormState swap,
  ) {
    return SheetDetailCard(
      children: [
        SelectableText(
          AppLocalizations.of(context)!.swapInfosMinimumReceived,
          style: AppTextStyles.bodyMedium(context),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Tooltip(
              message: swap.tokenSwapped!.symbol,
              child: SelectableText(
                '${swap.minToReceive.formatNumber(precision: 8)} ${swap.tokenSwapped!.symbol.reduceSymbol()}',
                style: AppTextStyles.bodyMedium(context),
              ),
            ),
            const SizedBox(width: 5),
            FutureBuilder<String>(
              future: FiatValue().display(
                ref,
                swap.tokenSwapped!,
                swap.minToReceive,
                withParenthesis: false,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SelectableText(
                    snapshot.data!,
                    style: AppTextStyles.bodyMedium(context),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRowWithTVL(
    BuildContext context,
    AsyncValue<double> tvlAsyncValue,
  ) {
    return SheetDetailCard(
      children: [
        SelectableText(
          AppLocalizations.of(context)!.swapInfosTVL,
          style: AppTextStyles.bodyMedium(context),
        ),
        tvlAsyncValue.when(
          data: (tvl) => SelectableText(
            '\$${tvl.formatNumber(precision: 2)}',
            style: AppTextStyles.bodyMedium(context),
          ),
          loading: () => const SizedBox.shrink(),
          error: (error, stackTrace) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildRowWithRatio(
    BuildContext context,
    SwapFormState swap,
    String tokenAddressRatioPrimary,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          AppLocalizations.of(context)!.swapInfosRatio,
          style: AppTextStyles.bodyMedium(context),
        ),
        if (swap.pool != null && swap.pool!.infos != null)
          DexRatio(
            ratio: tokenAddressRatioPrimary.toUpperCase() ==
                    swap.pool?.pair.token1.address.toUpperCase()
                ? swap.pool!.infos!.ratioToken1Token2
                : swap.pool!.infos!.ratioToken2Token1,
            token1Symbol: tokenAddressRatioPrimary.toUpperCase() ==
                    swap.pool!.pair.token1.address.toUpperCase()
                ? swap.pool!.pair.token1.symbol
                : swap.pool!.pair.token2.symbol,
            token2Symbol: tokenAddressRatioPrimary.toUpperCase() ==
                    swap.pool!.pair.token1.address.toUpperCase()
                ? swap.pool!.pair.token2.symbol
                : swap.pool!.pair.token1.symbol,
            textStyle: AppTextStyles.bodyMedium(context),
          ),
      ],
    );
  }
}
