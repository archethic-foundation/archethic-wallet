/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/price_history/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/widgets/balance/balance_infos.dart';
import 'package:aewallet/ui/widgets/components/history_chart.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:animate_do/animate_do.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class ChartSheet extends ConsumerWidget implements SheetSkeletonInterface {
  const ChartSheet({
    super.key,
  });

  static const String routerPage = '/chart';

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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    return SheetAppBar(
      title: AppLocalizations.of(context)!.chart,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(HomePage.routerPage);
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
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
                      ArchethicTheme.text20,
                      ArchethicTheme.text,
                    ],
                  ),
                  gradientColorsBar: LinearGradient(
                    colors: <Color>[
                      ArchethicTheme.text.withOpacity(0.9),
                      ArchethicTheme.text.withOpacity(0),
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                  tooltipBg: ArchethicTheme.backgroundDark,
                  tooltipText: ArchethicThemeStyles.textStyleSize12W100Primary,
                  axisTextStyle:
                      ArchethicThemeStyles.textStyleSize12W100Primary,
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
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  ),
                  backgroundColorOpacity:
                      ArchethicTheme.bottomBarBackgroundColorOpacity,
                  activeIconColor: ArchethicTheme.bottomBarActiveIconColor,
                  activeTitleColor: ArchethicTheme.bottomBarActiveTitleColor,
                  activeColor: ArchethicTheme.bottomBarActiveColor,
                  inactiveColor: ArchethicTheme.bottomBarInactiveIcon,
                );
              }).toList(),
            ),
          ],
        ),
        if (asyncChartInfos.valueOrNull != null) const BalanceInfosKpi(),
      ],
    );
  }
}

class _ChartLoading extends ConsumerWidget {
  const _ChartLoading();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        height: 78,
        child: Center(
          child: CircularProgressIndicator(
            color: ArchethicTheme.text,
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
    final priceChartInterval = ref.watch(PriceHistoryProviders.scaleOption);
    return Center(
      child: TextButton(
        child: Icon(Symbols.replay, color: ArchethicTheme.text, size: 30),
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
