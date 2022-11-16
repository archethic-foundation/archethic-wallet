/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../balance_infos.dart';

class BalanceInfosKpi extends ConsumerWidget {
  const BalanceInfosKpi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    final chartInfos = ref
        .watch(
          PriceHistoryProviders.chartData(
            scaleOption: preferences.priceChartIntervalOption,
          ),
        )
        .valueOrNull;

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

    if (chartInfos == null) {
      return const SizedBox(
        height: 30,
      );
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

              /// TODO(Chralu): reactiver
              // AutoSizeText(
              //            '${chartInfos!.getPriceChangePercentage(selectedPriceHistoryInterval)!.toStringAsFixed(2)}%',
              //   style: chartInfos.getPriceChangePercentage(
              //             selectedPriceHistoryInterval,
              //           )! >=
              //           0
              //       ? theme.textStyleSize12W100PositiveValue
              //       : theme.textStyleSize12W100NegativeValue,
              // ),
              const SizedBox(width: 5),

              /// TODO(Chralu): reactiver
              // if (chartInfos.getPriceChangePercentage(
              //       selectedPriceHistoryInterval,
              //     )! >=
              //     0)
              //   FaIcon(
              //     FontAwesomeIcons.caretUp,
              //     color: theme.positiveValue,
              //   )
              // else
              FaIcon(
                FontAwesomeIcons.caretDown,
                color: theme.negativeValue,
              ),
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
                  child: const IconWidget(
                    icon: 'assets/icons/menu/oracle.svg',
                    width: 15,
                    height: 15,
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
