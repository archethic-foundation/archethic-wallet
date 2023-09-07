/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../balance_infos.dart';

class BalanceInfosKpi extends ConsumerWidget {
  const BalanceInfosKpi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    final chartInfos = ref
        .watch(
          PriceHistoryProviders.chartData(
            scaleOption: preferences.priceChartIntervalOption,
          ),
        )
        .valueOrNull;
    if (chartInfos == null) {
      return const SizedBox(
        height: 30,
      );
    }

    final currencyMarketPrice = ref
        .watch(
          MarketPriceProviders.selectedCurrencyMarketPrice,
        )
        .valueOrNull;
    final selectedCurrency = ref.watch(
      SettingsProviders.settings.select((settings) => settings.currency),
    );
    final accountSelectedBalance = ref.watch(
      AccountProviders.selectedAccount.select(
        (value) => value.valueOrNull?.balance,
      ),
    );
    if (accountSelectedBalance == null || currencyMarketPrice == null) {
      return const SizedBox();
    }

    final selectedPriceHistoryInterval =
        ref.watch(PriceHistoryProviders.scaleOption);
    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: Container(
        height: 30,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            children: <Widget>[
              AutoSizeText(
                '1 ${accountSelectedBalance.nativeTokenName} = ${CurrencyUtil.getAmountPlusSymbol(selectedCurrency.name, currencyMarketPrice.amount)}',
                style: theme.textStyleSize12W100Primary,
              ),
              const SizedBox(
                width: 10,
              ),
              const _PriceEvolutionIndicator(),
              const SizedBox(
                width: 10,
              ),
              AutoSizeText(
                selectedPriceHistoryInterval.getChartOptionLabel(
                  context,
                ),
                style: theme.textStyleSize12W100Primary,
              ),
              const SizedBox(
                width: 10,
              ),
              if (currencyMarketPrice.useOracle)
                InkWell(
                  onTap: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    AppDialogs.showInfoDialog(
                      context,
                      ref,
                      localizations.informations,
                      localizations.currencyOracleInfo,
                    );
                  },
                  child: Icon(
                    Icons.info_outlined,
                    color: theme.text,
                    size: 15,
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceEvolutionIndicator extends ConsumerWidget {
  const _PriceEvolutionIndicator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final preferences = ref.watch(SettingsProviders.settings);
    final asyncPriceEvolution = ref.watch(
      PriceHistoryProviders.priceEvolution(
        scaleOption: preferences.priceChartIntervalOption,
      ),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      child: asyncPriceEvolution.maybeWhen(
        data: (priceEvolution) {
          return Row(
            children: [
              AutoSizeText(
                '${priceEvolution.toStringAsFixed(2)}%',
                style: priceEvolution >= 0
                    ? theme.textStyleSize12W100PositiveValue
                    : theme.textStyleSize12W100NegativeValue,
              ),
              const SizedBox(width: 5),
              if (priceEvolution >= 0)
                Icon(
                  Icons.arrow_upward_outlined,
                  color: theme.positiveValue,
                  size: 14,
                )
              else
                Icon(
                  Icons.arrow_downward_outlined,
                  color: theme.negativeValue,
                  size: 14,
                ),
            ],
          );
        },
        orElse: () {
          return const SizedBox();
        },
      ),
    );
  }
}
