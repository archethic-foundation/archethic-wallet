/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/views/sheets/chart_sheet.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core_ui/model/chart_infos.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BalanceInfosWidget {
  List<OptionChart> optionChartList = List<OptionChart>.empty(growable: true);

  Widget buildInfos(BuildContext context) {
    return InkWell(
      onTap: () {
        sl.get<HapticUtil>().feedback(FeedbackType.light);
        optionChartList = <OptionChart>[
          OptionChart('24h', ChartInfos.getChartOptionLabel(context, '24h')),
          OptionChart('7d', ChartInfos.getChartOptionLabel(context, '7d')),
          OptionChart('14d', ChartInfos.getChartOptionLabel(context, '14d')),
          OptionChart('30d', ChartInfos.getChartOptionLabel(context, '30d')),
          OptionChart('60d', ChartInfos.getChartOptionLabel(context, '60d')),
          OptionChart('200d', ChartInfos.getChartOptionLabel(context, '200d')),
          OptionChart('1y', ChartInfos.getChartOptionLabel(context, '1y')),
        ];
        final OptionChart? optionChart;
        final String _idChartOption = StateContainer.of(context).idChartOption!;
        switch (_idChartOption) {
          case '7d':
            optionChart = optionChartList[1];
            break;
          case '14d':
            optionChart = optionChartList[2];
            break;
          case '30d':
            optionChart = optionChartList[3];
            break;
          case '60d':
            optionChart = optionChartList[4];
            break;
          case '200d':
            optionChart = optionChartList[5];
            break;
          case '1y':
            optionChart = optionChartList[6];
            break;
          case '24h':
          default:
            optionChart = optionChartList[0];
            break;
        }
        Sheets.showAppHeightNineSheet(
            context: context,
            widget: ChartSheet(
              optionChartList: optionChartList,
              optionChart: optionChart,
            ));
      },
      child: Ink(
        child: FadeIn(
          duration: const Duration(milliseconds: 1000),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: Stack(
              children: <Widget>[
                FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: StateContainer.of(context).chartInfos != null &&
                            StateContainer.of(context).chartInfos!.data != null
                        ? LineChart(
                            mainData(context),
                            swapAnimationCurve: Curves.easeInOutCubic,
                            swapAnimationDuration:
                                const Duration(milliseconds: 1000),
                          )
                        : const SizedBox(),
                  ),
                ),
                StateContainer.of(context).showBalance
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: AutoSizeText(
                            StateContainer.of(context)
                                        .wallet!
                                        .accountBalance
                                        .networkCurrencyValue ==
                                    0
                                ? StateContainer.of(context)
                                    .localWallet!
                                    .accountBalance
                                    .getNetworkAccountBalanceDisplay()
                                : StateContainer.of(context)
                                    .wallet!
                                    .accountBalance
                                    .getNetworkAccountBalanceDisplay(),
                            style:
                                AppStyles.textStyleSize40W900Primary(context),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKPI(BuildContext context) {
    if (StateContainer.of(context).chartInfos != null &&
        StateContainer.of(context).chartInfos!.data != null) {
      return FadeIn(
        duration: const Duration(milliseconds: 1000),
        child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0),
            child: Row(
              children: <Widget>[
                StateContainer.of(context).showBalance
                    ? AutoSizeText(
                        StateContainer.of(context)
                            .wallet!
                            .accountBalance
                            .getConvertedAccountBalanceDisplay(),
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyleSize12W100Primary(context))
                    : const SizedBox(),
                StateContainer.of(context).showBalance
                    ? const SizedBox(
                        width: 10,
                      )
                    : const SizedBox(),
                AutoSizeText(
                  StateContainer.of(context)
                              .wallet!
                              .accountBalance
                              .networkCurrencyValue ==
                          0
                      ? '1 ' +
                          StateContainer.of(context)
                              .curNetwork
                              .getNetworkCryptoCurrencyLabel() +
                          ' = ' +
                          StateContainer.of(context)
                              .localWallet!
                              .accountBalance
                              .getLocalCurrencyPriceDisplay()
                      : '1 ' +
                          StateContainer.of(context)
                              .curNetwork
                              .getNetworkCryptoCurrencyLabel() +
                          ' = ' +
                          StateContainer.of(context)
                              .wallet!
                              .accountBalance
                              .getLocalCurrencyPriceDisplay(),
                  style: AppStyles.textStyleSize12W100Primary(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                AutoSizeText(
                  StateContainer.of(context)
                          .chartInfos!
                          .getPriceChangePercentage(
                              StateContainer.of(context).idChartOption!)!
                          .toStringAsFixed(2) +
                      '%',
                  style: StateContainer.of(context)
                              .chartInfos!
                              .getPriceChangePercentage(
                                  StateContainer.of(context).idChartOption!)! >=
                          0
                      ? AppStyles.textStyleSize12W100PositiveValue(context)
                      : AppStyles.textStyleSize12W100NegativeValue(context),
                ),
                const SizedBox(width: 5),
                StateContainer.of(context).chartInfos!.getPriceChangePercentage(
                            StateContainer.of(context).idChartOption!)! >=
                        0
                    ? FaIcon(FontAwesomeIcons.caretUp,
                        color:
                            StateContainer.of(context).curTheme.positiveValue)
                    : FaIcon(FontAwesomeIcons.caretDown,
                        color:
                            StateContainer.of(context).curTheme.negativeValue),
                const SizedBox(
                  width: 10,
                ),
                AutoSizeText(
                  ChartInfos.getChartOptionLabel(
                      context, StateContainer.of(context).idChartOption!),
                  style: AppStyles.textStyleSize12W100Primary(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                StateContainer.of(context).useOracleUcoPrice
                    ? InkWell(
                        onTap: () {
                          sl.get<HapticUtil>().feedback(FeedbackType.light);
                          AppDialogs.showInfoDialog(
                            context,
                            AppLocalization.of(context)!.informations,
                            AppLocalization.of(context)!.currencyOracleInfo,
                          );
                        },
                        child: buildIconWidget(
                          context,
                          'packages/aewallet/assets/icons/oracle.png',
                          15,
                          15,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 30,
      );
    }
  }

  static LineChartData mainData(BuildContext context) {
    final Gradient gradientColors = LinearGradient(colors: <Color>[
      StateContainer.of(context).curTheme.backgroundDark!,
      StateContainer.of(context).curTheme.backgroundDarkest!,
    ]);

    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: false,
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: StateContainer.of(context).chartInfos!.minX,
      maxX: StateContainer.of(context).chartInfos!.maxX,
      minY: StateContainer.of(context).chartInfos!.minY,
      maxY: StateContainer.of(context).chartInfos!.maxY,
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding: const EdgeInsets.all(8),
          tooltipBgColor: const Color(0xff2e3747).withOpacity(0.8),
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              return LineTooltipItem(
                '${touchedSpot.y}',
                const TextStyle(color: Colors.white, fontSize: 12.0),
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
        enabled: true,
      ),
      lineBarsData: <LineChartBarData>[
        LineChartBarData(
          spots: StateContainer.of(context).chartInfos!.data,
          isCurved: true,
          gradient: gradientColors,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }
}
