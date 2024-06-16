/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../balance_infos.dart';

class BalanceInfosChart extends ConsumerWidget {
  const BalanceInfosChart({required this.chartInfos, super.key});

  final List<aedappfm.PriceHistoryValue>? chartInfos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(SettingsProviders.settings);

    if (chartInfos == null) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      child: HistoryChart(
        intervals: chartInfos!,
        gradientColors: LinearGradient(
          colors: <Color>[
            ArchethicTheme.text.withOpacity(0.05),
            ArchethicTheme.text.withOpacity(0),
          ],
        ),
        gradientColorsBar: LinearGradient(
          colors: <Color>[
            ArchethicTheme.text.withOpacity(0.1),
            ArchethicTheme.text.withOpacity(0.05),
          ],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
        ),
        tooltipBg: ArchethicTheme.backgroundDark,
        tooltipText: ArchethicThemeStyles.textStyleSize12W100Primary,
        axisTextStyle: ArchethicThemeStyles.textStyleSize12W100Primary,
        optionChartSelected: settings.priceChartIntervalOption,
        currency: settings.currency.name,
        completeChart: false,
        lineTouchEnabled: false,
      ),
    );
  }
}
