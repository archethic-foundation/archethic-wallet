// Flutter imports:
import 'package:animate_do/animate_do.dart';
import 'package:archethic_wallet/model/chart_infos.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChartSheet extends StatefulWidget {
  ChartSheet() : super();

  _ChartSheetState createState() => _ChartSheetState();
}

class _ChartSheetState extends State<ChartSheet> {
  String _idChart = '24h';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _idChart = StateContainer.of(context).idChartOption!;
    return Column(
      children: <Widget>[
        // A row for the address text and close button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Empty SizedBox
            SizedBox(
              width: 60,
              height: 40,
            ),
            Column(
              children: <Widget>[
                // Sheet handle
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.primary10,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ],
            ),
            //Empty SizedBox
            SizedBox(
              width: 60,
              height: 40,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 10.0, right: 10.0),
              child: AutoSizeText(
                AppLocalization.of(context)!.chart,
                style: AppStyles.textStyleSize24W700Primary(context),
              ),
            ),
          ],
        ),

        FadeIn(
          duration: Duration(milliseconds: 1000),
          child: Container(
            height: 200,
            padding:
                EdgeInsets.only(top: 20.0, bottom: 0.0, left: 0.0, right: 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, left: 0.0, top: 0.0, bottom: 0.0),
              child: LineChart(
                mainData(context),
                swapAnimationCurve: Curves.decelerate,
                swapAnimationDuration: Duration(milliseconds: 1000),
              ),
            ),
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: StateContainer.of(context)
                      .chartInfos!
                      .getPriceChangePercentage(
                          StateContainer.of(context).idChartOption!)! >=
                  0
              ? FadeIn(
                  duration: Duration(milliseconds: 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      AutoSizeText(
                        StateContainer.of(context)
                                .chartInfos!
                                .getPriceChangePercentage(
                                    StateContainer.of(context).idChartOption!)!
                                .toStringAsFixed(2) +
                            '%',
                        style:
                            AppStyles.textStyleSize16W100PositiveValue(context),
                      ),
                      FaIcon(FontAwesomeIcons.caretUp,
                          color: StateContainer.of(context)
                              .curTheme
                              .positiveValue),
                    ],
                  ),
                )
              : FadeIn(
                  duration: Duration(milliseconds: 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      AutoSizeText(
                        StateContainer.of(context)
                                .chartInfos!
                                .getPriceChangePercentage(
                                    StateContainer.of(context).idChartOption!)!
                                .toStringAsFixed(2) +
                            '%',
                        style:
                            AppStyles.textStyleSize16W100NegativeValue(context),
                      ),
                      FaIcon(FontAwesomeIcons.caretDown,
                          color: StateContainer.of(context)
                              .curTheme
                              .negativeValue),
                    ],
                  ),
                ),
        ),

        Expanded(
          child: Center(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: SafeArea(
                  minimum: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.035,
                    top: 50,
                  ),
                  child: Column(
                    children: <Widget>[
                      AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              getOption('24h'),
                              getOption('7d'),
                              getOption('14d'),
                              getOption('30d'),
                            ],
                          )),
                      AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              getOption('60d'),
                              getOption('200d'),
                              getOption('1y'),
                            ],
                          )),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(BuildContext context) {
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
          tooltipBgColor: Color(0xff2e3747).withOpacity(0.8),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
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

  Widget getOption(String idChartOption) {
    return GestureDetector(
      onTap: () async {
        _idChart = idChartOption;
        await StateContainer.of(context)
            .requestUpdateCoinsChart(option: _idChart);
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _idChart == idChartOption
              ? StateContainer.of(context).curTheme.primary
              : StateContainer.of(context).curTheme.backgroundDarkest,
        ),
        child: Text(
          ChartInfos.getChartOptionLabel(context, idChartOption),
          style: TextStyle(
              color: _idChart == idChartOption
                  ? StateContainer.of(context).curTheme.backgroundDarkest
                  : StateContainer.of(context).curTheme.primary,
              fontSize: AppFontSizes.size12),
        ),
      ),
    );
  }
}
