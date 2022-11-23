/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/price_history/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/balance/balance_infos.dart';
import 'package:aewallet/ui/widgets/components/history_chart.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
// Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ChartSheet extends ConsumerWidget {
  const ChartSheet({
    super.key,
  });

  static const List<MarketPriceHistoryInterval> _chartIntervalOptions = [
    MarketPriceHistoryInterval.hour,
    MarketPriceHistoryInterval.day,
    MarketPriceHistoryInterval.week,
    MarketPriceHistoryInterval.twoWeeks,
    MarketPriceHistoryInterval.month,
    MarketPriceHistoryInterval.twoMonths,
    MarketPriceHistoryInterval.year,
    MarketPriceHistoryInterval.all,
  ];

  int _intervalOptionIndex(MarketPriceHistoryInterval interval) =>
      _chartIntervalOptions.indexWhere((element) => element == interval);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(
      SettingsProviders.settings.select((settings) => settings.currency),
    );

    final selectedInterval = ref.watch(PriceHistoryProviders.scaleOption);
    final asyncChartInfos = ref.watch(
      PriceHistoryProviders.chartData(
        scaleOption: selectedInterval,
      ),
    );

    return Column(
      children: <Widget>[
        SheetHeader(
          title: AppLocalization.of(context)!.chart,
        ),
        FadeIn(
          duration: const Duration(milliseconds: 1000),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            padding: const EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: asyncChartInfos.when(
                data: (chartInfos) => HistoryChart(
                  intervals: chartInfos,
                  gradientColors: LinearGradient(
                    colors: <Color>[
                      theme.text20!,
                      theme.text!,
                    ],
                  ),
                  gradientColorsBar: LinearGradient(
                    colors: <Color>[
                      theme.text!.withOpacity(0.9),
                      theme.text!.withOpacity(0),
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                  tooltipBg: theme.backgroundDark!,
                  tooltipText: theme.textStyleSize12W100Primary,
                  axisTextStyle: theme.textStyleSize12W100Primary,
                  optionChartSelected: selectedInterval,
                  currency: currency.name,
                  completeChart: true,
                ),
                error: (_, __) {
                  if (asyncChartInfos.isLoading) {
                    return const _ChartLoading();
                  }
                  return const _ChartLoadFailed();
                },
                loading: () => const _ChartLoading(),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Wrap(
          children: [
            BottomBar(
              selectedIndex: _intervalOptionIndex(selectedInterval),
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 500),
              itemPadding: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(right: 10, left: 10),
              onTap: (int index) async {
                final settings = ref.read(SettingsProviders.settings);

                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      settings.activeVibrations,
                    );
                await ref
                    .read(SettingsProviders.settings.notifier)
                    .setPriceChartInterval(_chartIntervalOptions[index]);
              },
              items: _chartIntervalOptions.map((optionChart) {
                return BottomBarItem(
                  icon: Text(
                    optionChart.getChartOptionLabel(context),
                    style: theme.textStyleSize12W100Primary,
                  ),
                  backgroundColorOpacity:
                      theme.bottomBarBackgroundColorOpacity!,
                  activeIconColor: theme.bottomBarActiveIconColor,
                  activeTitleColor: theme.bottomBarActiveTitleColor,
                  activeColor: theme.bottomBarActiveColor!,
                  inactiveColor: theme.bottomBarInactiveIcon,
                );
              }).toList(),
            ),
          ],
        ),
        if (asyncChartInfos.valueOrNull != null) const BalanceInfosKpi()
      ],
    );
  }
}

class _ChartLoading extends ConsumerWidget {
  const _ChartLoading();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Center(
      child: SizedBox(
        height: 78,
        child: Center(
          child: CircularProgressIndicator(
            color: theme.text,
            strokeWidth: 1,
          ),
        ),
      ),
    );
  }
}

class _ChartLoadFailed extends ConsumerWidget {
  const _ChartLoadFailed();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final priceChartInterval = ref.watch(PriceHistoryProviders.scaleOption);
    return Center(
      child: TextButton(
        child: Icon(Icons.replay_outlined, color: theme.text, size: 30),
        onPressed: () {
          ref.invalidate(
            PriceHistoryProviders.chartData(
              scaleOption: priceChartInterval,
            ),
          );
        },
      ),
    );
  }
}
