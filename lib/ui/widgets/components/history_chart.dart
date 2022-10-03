/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/model/asset_history_interval.dart';
import 'package:aewallet/util/currency_util.dart';
// Package imports:
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoryChart extends StatelessWidget {
  const HistoryChart({
    super.key,
    required this.intervals,
    required this.gradientColors,
    required this.gradientColorsBar,
    required this.tooltipBg,
    required this.tooltipText,
    required this.axisTextStyle,
    required this.optionChartSelected,
    required this.currency,
    required this.completeChart,
  });

  final List<AssetHistoryInterval> intervals;
  final Gradient gradientColors;
  final Gradient gradientColorsBar;
  final Color tooltipBg;
  final TextStyle tooltipText;
  final TextStyle axisTextStyle;
  final String optionChartSelected;
  final String currency;
  final bool completeChart;

  double get maxY {
    final max = intervals.fold<double>(
      0,
      (acc, i) => i.price > acc ? i.price.toDouble() : acc,
    );
    return max * 1.025;
  }

  double get minY {
    final min = intervals.fold<double>(
      double.maxFinite,
      (acc, i) => i.price < acc ? i.price.toDouble() : acc,
    );
    return min * 0.975;
  }

  LineChartData get _chartData {
    final barData = LineChartBarData(
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
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          tooltipPadding: const EdgeInsets.all(8),
          tooltipBgColor: tooltipBg.withOpacity(1),
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              var title = '';
              final dt = intervals[touchedSpot.x.toInt()].time;
              switch (optionChartSelected) {
                case '1h':
                  title =
                      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                  break;
                case '24h':
                  title =
                      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                  break;
                case '7d':
                  title =
                      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}';
                  break;
                case '14d':
                  title =
                      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}';
                  break;
                case '30d':
                  title =
                      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}';
                  break;
                case '60d':
                  title =
                      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}';
                  break;
                case '200d':
                  title =
                      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
                  break;
                case '1y':
                  title =
                      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
                  break;
                case 'all':
                  title =
                      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
                  break;
                default:
                  title =
                      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
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
                    var title = '';
                    if (value != 0 &&
                        value < intervals.length - intervals.length ~/ 4) {
                      final dt = intervals[value.toInt()].time;
                      switch (optionChartSelected) {
                        case '1h':
                          title =
                              '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                          break;
                        case '24h':
                          title = '${dt.hour.toString().padLeft(2, '0')}h';
                          break;
                        case '7d':
                          title =
                              '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}';
                          break;
                        case '14d':
                          title =
                              '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}';
                          break;
                        case '30d':
                          title =
                              '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}';
                          break;
                        case '60d':
                          title =
                              '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}';
                          break;
                        case '200d':
                          title =
                              '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
                          break;
                        case '1y':
                          title =
                              '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
                          break;
                        case 'all':
                          title =
                              '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
                          break;
                        default:
                          title = '${dt.hour.toString().padLeft(2, '0')}h';
                          break;
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, left: 5),
                      child: Text(
                        title,
                        style: axisTextStyle,
                      ),
                    );
                  },
                ),
              )
            : AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: completeChart
            ? AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 60,
                  getTitlesWidget: (value, titleMeta) {
                    final axisTitle = value == titleMeta.max ||
                            value == titleMeta.min
                        ? const SizedBox.shrink()
                        : Text(
                            CurrencyUtil.getConvertedAmountWithNumberOfDigits(
                              currency,
                              value,
                              3,
                            ),
                            style: axisTextStyle,
                          );
                    return SideTitleWidget(
                      axisSide: titleMeta.axisSide,
                      child: axisTitle,
                    );
                  },
                ),
              )
            : AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      gridData: FlGridData(
        drawVerticalLine: false,
        drawHorizontalLine: completeChart,
      ),
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
