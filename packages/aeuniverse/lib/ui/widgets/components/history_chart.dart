/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:core/util/currency_util.dart';
import 'package:core_ui/model/asset_history_interval.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryChart extends StatelessWidget {
  const HistoryChart(
      {Key? key,
      required this.intervals,
      required this.gradientColors,
      required this.gradientColorsBar,
      required this.tooltipBg,
      required this.tooltipText,
      required this.optionChartSelected,
      required this.currency,
      required this.completeChart})
      : super(key: key);

  final List<AssetHistoryInterval> intervals;
  final Gradient gradientColors;
  final Gradient gradientColorsBar;
  final Color tooltipBg;
  final TextStyle tooltipText;
  final String optionChartSelected;
  final String currency;
  final bool completeChart;

  double get maxY {
    double max = intervals.fold<double>(
      0,
      (acc, i) => i.price > acc ? i.price.toDouble() : acc,
    );
    return max * 1.025;
  }

  double get minY {
    double min = intervals.fold<double>(
      double.maxFinite,
      (acc, i) => i.price < acc ? i.price.toDouble() : acc,
    );
    return min * 0.975;
  }

  LineChartData get _chartData {
    LineChartBarData barData = LineChartBarData(
      spots: intervals
          .mapIndexed<FlSpot>(
            (idx, i) => FlSpot(
              idx.toDouble(),
              i.price.toDouble(),
            ),
          )
          .toList(),
      isCurved: true,
      gradient: gradientColors,
      isStrokeCapRound: true,
      barWidth: 2,
      belowBarData: completeChart
          ? BarAreaData(show: true, gradient: gradientColorsBar)
          : BarAreaData(show: false),
      dotData: FlDotData(show: false),
    );

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding: const EdgeInsets.all(8),
          tooltipBgColor: tooltipBg.withOpacity(1),
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              String title = '';
              DateTime dt = intervals[touchedSpot.x.toInt()].time;
              switch (optionChartSelected) {
                case '7d':
                  title = '${dt.day}/${dt.month}';
                  break;
                case '14d':
                  title = '${dt.day}/${dt.month}';
                  break;
                case '30d':
                  title = '${dt.day}/${dt.month}';
                  break;
                case '60d':
                  title = '${dt.day}/${dt.month}';
                  break;
                case '200d':
                  title = '${dt.day}/${dt.month}/${dt.year}';
                  break;
                case '1y':
                  title = '${dt.day}/${dt.month}/${dt.year}';
                  break;
                case '24h':
                default:
                  title = '${dt.hour}:${dt.minute}';
                  break;
              }
              return LineTooltipItem(
                '$title\n${CurrencyUtil.getConvertedAmountWithNumberOfDigits(currency, touchedSpot.y, 5)}',
                tooltipText,
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
        enabled: true,
      ),
      lineBarsData: [barData],
      borderData: FlBorderData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: completeChart
            ? AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    interval: (intervals.length ~/ 4).toDouble(),
                    reservedSize: 30,
                    getTitlesWidget: (value, titleMeta) {
                      String title = '';
                      if (value != 0 &&
                          value < intervals.length - intervals.length ~/ 4) {
                        DateTime dt = intervals[value.toInt()].time;
                        switch (optionChartSelected) {
                          case '7d':
                            title = '${dt.day}/${dt.month}';
                            break;
                          case '14d':
                            title = '${dt.day}/${dt.month}';
                            break;
                          case '30d':
                            title = '${dt.day}/${dt.month}';
                            break;
                          case '60d':
                            title = '${dt.day}/${dt.month}';
                            break;
                          case '200d':
                            title = '${dt.day}/${dt.month}/${dt.year}';
                            break;
                          case '1y':
                            title = '${dt.day}/${dt.month}/${dt.year}';
                            break;
                          case '24h':
                            title = '${dt.hour}h';
                            break;
                          default:
                            title = '${dt.hour}h';
                            break;
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 5),
                        child: Text(
                          title,
                        ),
                      );
                    }),
              )
            : AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: completeChart
            ? AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 60,
                    getTitlesWidget: (value, titleMeta) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 5),
                          child: Text(
                              CurrencyUtil.getConvertedAmountWithNumberOfDigits(
                                  currency, value, 3)));
                    }),
              )
            : AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      gridData: FlGridData(
          drawVerticalLine: false,
          drawHorizontalLine: completeChart ? true : false),
      maxY: maxY,
      minY: minY,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: LineChart(
        _chartData,
        swapAnimationCurve: Curves.decelerate,
        swapAnimationDuration: const Duration(milliseconds: 1000),
      ),
    );
  }
}
