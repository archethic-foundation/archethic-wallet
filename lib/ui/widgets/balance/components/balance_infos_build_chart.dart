/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../balance_infos.dart';

class BalanceInfosBuildChart extends StatelessWidget {
  const BalanceInfosBuildChart({super.key});

  @override
  Widget build(BuildContext context) {
    var optionChartList = List<OptionChart>.empty(growable: true);
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;
    final chartInfos = StateContainer.of(context).chartInfos;

    return InkWell(
      onTap: () async {
        await sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              StateContainer.of(context).activeVibrations,
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
        final OptionChart? optionChart;
        final idChartOption = StateContainer.of(context).idChartOption!;
        switch (idChartOption) {
          case '1h':
            optionChart = optionChartList[0];
            break;
          case '24h':
            optionChart = optionChartList[1];
            break;
          case '7d':
            optionChart = optionChartList[2];
            break;
          case '14d':
            optionChart = optionChartList[3];
            break;
          case '30d':
            optionChart = optionChartList[4];
            break;
          case '60d':
            optionChart = optionChartList[5];
            break;
          case '200d':
            optionChart = optionChartList[6];
            break;
          case '1y':
            optionChart = optionChartList[7];
            break;
          case 'all':
            optionChart = optionChartList[8];
            break;
          default:
            optionChart = optionChartList[0];
            break;
        }
        Sheets.showAppHeightNineSheet(
          context: context,
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
                      style: AppStyles.textStyleSize14W600EquinoxPrimary(
                        context,
                      ),
                    ),
                    IconWidget.buildIconDataWidget(
                      context,
                      Icons.arrow_circle_right_outlined,
                      20,
                      20,
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
                          tooltipText:
                              AppStyles.textStyleSize12W100Primary(context),
                          axisTextStyle:
                              AppStyles.textStyleSize12W100Primary(context),
                          optionChartSelected:
                              StateContainer.of(context).idChartOption!,
                          currency: StateContainer.of(context)
                              .curCurrency
                              .currency
                              .name,
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
}
