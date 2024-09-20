/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_price_impact.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_ratio.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/state.dart';
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
    final swap = ref.watch(SwapFormProvider.swapForm);

    if (swap.tokenToSwap == null ||
        swap.tokenSwapped == null ||
        swap.pool == null ||
        swap.pool!.poolAddress.isEmpty) {
      return const SizedBox.shrink();
    }

    final tokenAddressRatioPrimary =
        swap.tokenToSwap!.address == null ? 'UCO' : swap.tokenToSwap!.address!;

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

    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDivider(context),
            const SizedBox(height: 5),
            _buildRowWithFees(context, ref, swap),
            _buildRowWithPriceImpact(context, swap),
            _buildRowWithMinReceived(context, ref, swap),
            _buildRowWithTVL(context, tvlAsyncValue),
            _buildRowWithRatio(context, swap, tokenAddressRatioPrimary),
          ],
        ),
      ),
    );
  }

  /// Helper method to build the loading state when calculations are in progress
  Widget _buildLoadingState(BuildContext context) {
    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDivider(context),
            const SizedBox(height: 5),
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
      ),
    );
  }

  Widget _buildLoadingRow(BuildContext context, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  Widget _buildDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 50,
            height: 1,
            decoration: BoxDecoration(
              gradient: aedappfm.AppThemeBase.gradient,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRowWithFees(
    BuildContext context,
    WidgetRef ref,
    SwapFormState swap,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          AppLocalizations.of(context)!.swapInfosFees,
          style: AppTextStyles.bodyMedium(context),
        ),
        Row(
          children: [
            Tooltip(
              message: swap.tokenToSwap!.symbol,
              child: SelectableText(
                '${swap.swapTotalFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol.reduceSymbol()}',
                style: AppTextStyles.bodyMedium(context),
              ),
            ),
            const SizedBox(width: 5),
            FutureBuilder<String>(
              future: FiatValue()
                  .display(ref, swap.tokenToSwap!, swap.swapTotalFees),
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
            const SizedBox(width: 5),
            _buildFeesTooltip(context, swap),
          ],
        ),
      ],
    );
  }

  Widget _buildFeesTooltip(BuildContext context, SwapFormState swap) {
    return Tooltip(
      message:
          '${AppLocalizations.of(context)!.swapInfosLiquidityProviderFees} (${swap.pool!.infos!.fees}%): ${swap.swapFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol} \n'
          '${AppLocalizations.of(context)!.swapInfosProtocolFees} (${swap.pool!.infos!.protocolFees}%): ${swap.swapProtocolFees.formatNumber(precision: 8)} ${swap.tokenToSwap!.symbol}',
      child: const Padding(
        padding: EdgeInsets.only(bottom: 2),
        child: Icon(aedappfm.Iconsax.info_circle, size: 13),
      ),
    );
  }

  Widget _buildRowWithPriceImpact(BuildContext context, SwapFormState swap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          AppLocalizations.of(context)!.swapInfosMinimumReceived,
          style: AppTextStyles.bodyMedium(context),
        ),
        Row(
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
              future: FiatValue()
                  .display(ref, swap.tokenSwapped!, swap.minToReceive),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    swap.pool?.pair.token1.address!.toUpperCase()
                ? swap.pool!.infos!.ratioToken1Token2
                : swap.pool!.infos!.ratioToken2Token1,
            token1Symbol: tokenAddressRatioPrimary.toUpperCase() ==
                    swap.pool!.pair.token1.address!.toUpperCase()
                ? swap.pool!.pair.token1.symbol
                : swap.pool!.pair.token2.symbol,
            token2Symbol: tokenAddressRatioPrimary.toUpperCase() ==
                    swap.pool!.pair.token1.address!.toUpperCase()
                ? swap.pool!.pair.token2.symbol
                : swap.pool!.pair.token1.symbol,
            textStyle: AppTextStyles.bodyMedium(context),
          ),
      ],
    );
  }
}
