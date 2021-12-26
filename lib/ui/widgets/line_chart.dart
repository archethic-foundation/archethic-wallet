// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/styles.dart';

class LineChartWidget {
  List<FlSpot> data = <FlSpot>[];
  double minY = 0;
  double minX = 0;
  double maxY = 0;
  double maxX = 0;

  static Widget buildTinyCoinsChart(BuildContext context) {
    if (StateContainer.of(context).chartInfos != null &&
        StateContainer.of(context).chartInfos!.data != null) {
      return Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.70,
            child: Container(
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.backgroundDark,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color:
                        StateContainer.of(context).curTheme.backgroundDarkest!,
                    blurRadius: 3.0,
                    spreadRadius: 0.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Padding(
                  padding: const EdgeInsets.only(
                      right: 18.0, left: 12.0, top: 24, bottom: 12),
                  child: LineChart(
                    mainData(context),
                  )),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 5.0),
              child: Text(
                'UCO (1d)',
                style: AppStyles.textStyleSize12W100Primary(context),
              ),
            ),
          ),
          SizedBox(
            child: Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 100.0),
                child: StateContainer.of(context)
                            .chartInfos!
                            .priceChangePercentage24h! >=
                        0
                    ? Row(
                        children: <Widget>[
                          Text(
                            StateContainer.of(context)
                                    .chartInfos!
                                    .priceChangePercentage24h!
                                    .toStringAsFixed(2) +
                                '%',
                            style: AppStyles.textStyleSize12W100PositiveValue(
                                context),
                          ),
                          FaIcon(FontAwesomeIcons.caretUp,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .positiveValue),
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          Text(
                            StateContainer.of(context)
                                    .chartInfos!
                                    .priceChangePercentage24h!
                                    .toStringAsFixed(2) +
                                '%',
                            style: AppStyles.textStyleSize12W100NegativeValue(
                                context),
                          ),
                          FaIcon(FontAwesomeIcons.caretDown,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .negativeValue),
                        ],
                      )),
          ),
        ],
      );
    } else {
      return Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.70,
            child: Container(
                decoration: BoxDecoration(
                  color: StateContainer.of(context).curTheme.backgroundDark,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: StateContainer.of(context)
                          .curTheme
                          .backgroundDarkest!,
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.only(
                      right: 18.0, left: 12.0, top: 24, bottom: 12),
                  child: Center(child: CircularProgressIndicator()),
                )),
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
        drawVerticalLine: false,
        getDrawingHorizontalLine: (double value) {
          return FlLine(
            color: StateContainer.of(context).curTheme.backgroundDarkest,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (double value) {
          return FlLine(
            color: StateContainer.of(context).curTheme.backgroundDarkest,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 10,
          getTextStyles: (BuildContext context, double value) =>
              const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10),
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          getTextStyles: (BuildContext context, double value) =>
              const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10),
          reservedSize: 10,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: StateContainer.of(context).chartInfos!.minX,
      maxX: StateContainer.of(context).chartInfos!.maxX,
      minY: StateContainer.of(context).chartInfos!.minY,
      maxY: StateContainer.of(context).chartInfos!.maxY,
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
            colors: gradientColors
                .map((Color color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    );
  }
}
