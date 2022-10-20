/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../balance_infos.dart';

class BalanceInfosChart extends ConsumerWidget {
  const BalanceInfosChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var optionChartList = List<OptionChart>.empty(growable: true);
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final preferences = ref.watch(SettingsProviders.settings);

    final chartInfos = StateContainer.of(context).chartInfos;

    return InkWell(
      onTap: () async {
        await sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        optionChartList = <OptionChart>[
          OptionChart('1h', ChartInfos.getChartOptionLabel(context, '1h')),
          OptionChart('24h', ChartInfos.getChartOptionLabel(context, '24h')),
          OptionChart('7d', ChartInfos.getChartOptionLabel(context, '7d')),
          OptionChart('14d', ChartInfos.getChartOptionLabel(context, '14d')),
          OptionChart('30d', ChartInfos.getChartOptionLabel(context, '30d')),
          OptionChart('60d', ChartInfos.getChartOptionLabel(context, '60d')),
          OptionChart('200d', ChartInfos.getChartOptionLabel(context, '200d')),
          OptionChart('1y', ChartInfos.getChartOptionLabel(context, '1y')),
          OptionChart('all', ChartInfos.getChartOptionLabel(context, 'all')),
        ];
        final optionChart =
            _getOptionChart(context, StateContainer.of(context).idChartOption!);

        Sheets.showAppHeightNineSheet(
          context: context,
          ref: ref,
          widget: ChartSheet(
            optionChartList: optionChartList,
            optionChart: optionChart,
          ),
        );
      },
      child: Ink(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localizations.priceChartHeader,
                      style: theme.textStyleSize14W600EquinoxPrimary,
                    ),
                    const IconDataWidget(
                      icon: Icons.arrow_circle_right_outlined,
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
              FadeIn(
                duration: const Duration(milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: chartInfos != null && chartInfos.data != null
                      ? HistoryChart(
                          intervals: chartInfos.data!,
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
                          optionChartSelected:
                              StateContainer.of(context).idChartOption!,
                          currency: currency.currency.name,
                          completeChart: false,
                        )
                      : const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OptionChart _getOptionChart(BuildContext context, String idChartOption) {
    switch (idChartOption) {
      case '1h':
        return OptionChart('1h', ChartInfos.getChartOptionLabel(context, '1h'));
      case '24h':
        return OptionChart(
          '24h',
          ChartInfos.getChartOptionLabel(context, '24h'),
        );
      case '7d':
        return OptionChart('7d', ChartInfos.getChartOptionLabel(context, '7d'));
      case '14d':
        return OptionChart(
          '14d',
          ChartInfos.getChartOptionLabel(context, '14d'),
        );
      case '30d':
        return OptionChart(
          '30d',
          ChartInfos.getChartOptionLabel(context, '30d'),
        );
      case '60d':
        return OptionChart(
          '60d',
          ChartInfos.getChartOptionLabel(context, '60d'),
        );
      case '200d':
        return OptionChart(
          '200d',
          ChartInfos.getChartOptionLabel(context, '200d'),
        );
      case '1y':
        return OptionChart('1y', ChartInfos.getChartOptionLabel(context, '1y'));
      case 'all':
        return OptionChart(
          'all',
          ChartInfos.getChartOptionLabel(context, 'all'),
        );
      default:
        return OptionChart('1h', ChartInfos.getChartOptionLabel(context, '1h'));
    }
  }
}
