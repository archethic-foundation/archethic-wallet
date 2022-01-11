// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/styles.dart';
import 'package:archethic_wallet/ui/widgets/sheet_util.dart';
import 'package:archethic_wallet/ui/widgets/tx_all_list.dart';

class BalanceInfosWidget {
  Widget buildInfos(BuildContext context) {
    if (StateContainer.of(context).chartInfos != null &&
        StateContainer.of(context).chartInfos!.data != null) {
      return InkWell(
        onTap: () {
          Sheets.showAppHeightNineSheet(
              context: context, widget: const TxAllListWidget());
        },
        child: Ink(
          child: FadeIn(
            duration: const Duration(milliseconds: 1000),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.08,
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, left: 0.0, top: 0.0, bottom: 0.0),
                      child: AutoSizeText(
                        'UCO',
                        style: AppStyles.textStyleSize80W700Primary15(context),
                      ),
                    ),
                  ),
                  Container(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              right: 20.0, left: 0.0, top: 0.0, bottom: 0.0),
                          child: LineChart(
                            mainData(context),
                            swapAnimationCurve: Curves.easeInOutCubic,
                            swapAnimationDuration:
                                const Duration(milliseconds: 1000),
                          ))),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 0.0, left: 10.0, top: 0.0, bottom: 0.0),
                      child: AutoSizeText(
                        StateContainer.of(context).wallet!.accountBalance.uco ==
                                0
                            ? StateContainer.of(context)
                                .localWallet!
                                .getAccountBalanceUCODisplay()
                            : StateContainer.of(context)
                                .wallet!
                                .getAccountBalanceUCODisplay(),
                        style: AppStyles.textStyleSize40W900Primary(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
          ),
        ],
      );
    }
  }

  static LineChartData mainData(BuildContext context) {
    final List<Color> gradientColors = <Color>[
      StateContainer.of(context).curTheme.backgroundDark!,
      StateContainer.of(context).curTheme.backgroundDarkest!,
    ];
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: false,
        bottomTitles: SideTitles(showTitles: false),
        leftTitles: SideTitles(
          showTitles: false,
        ),
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
          colors: gradientColors,
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
