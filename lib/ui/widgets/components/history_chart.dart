/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/util/currency_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
    required this.lineTouchEnabled,
  });

  final List<aedappfm.PriceHistoryValue> intervals;
  final Gradient gradientColors;
  final Gradient gradientColorsBar;
  final Color tooltipBg;
  final TextStyle tooltipText;
  final TextStyle axisTextStyle;
  final aedappfm.MarketPriceHistoryInterval optionChartSelected;
  final String currency;
  final bool completeChart;
  final bool lineTouchEnabled;

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
      belowBarData: completeChart
          ? BarAreaData(show: true, gradient: gradientColorsBar)
          : BarAreaData(show: true, gradient: gradientColorsBar),
      dotData: const FlDotData(show: false),
    );

    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: lineTouchEnabled,
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
                case aedappfm.MarketPriceHistoryInterval.hour:
                case aedappfm.MarketPriceHistoryInterval.day:
                  title =
                      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                  break;
                case aedappfm.MarketPriceHistoryInterval.week:
                case aedappfm.MarketPriceHistoryInterval.twoWeeks:
                case aedappfm.MarketPriceHistoryInterval.month:
                case aedappfm.MarketPriceHistoryInterval.twoMonths:
                  title =
                      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}';
                  break;
                case aedappfm.MarketPriceHistoryInterval.year:
                  title =
                      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year.toString().padLeft(2, '0')}';
                  break;
              }
              return LineTooltipItem(
                '$title\n${CurrencyUtil.formatWithNumberOfDigits(touchedSpot.y, 5)}',
                tooltipText,
              );
            }).toList();
          },
        ),
      ),
      lineBarsData: [barData],
      borderData: FlBorderData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: const AxisTitles(),
        leftTitles: const AxisTitles(),
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
                        case aedappfm.MarketPriceHistoryInterval.day:
                          title = '${dt.hour.toString().padLeft(2, '0')}h';
                          break;
                        case aedappfm.MarketPriceHistoryInterval.hour:
                          title =
                              '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                          break;
                        case aedappfm.MarketPriceHistoryInterval.week:
                        case aedappfm.MarketPriceHistoryInterval.twoWeeks:
                        case aedappfm.MarketPriceHistoryInterval.month:
                        case aedappfm.MarketPriceHistoryInterval.twoMonths:
                        case aedappfm.MarketPriceHistoryInterval.year:
                          title =
                              '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}';
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
            : const AxisTitles(),
        rightTitles: completeChart
            ? AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 60,
                  getTitlesWidget: (value, titleMeta) {
                    final axisTitle =
                        value == titleMeta.max || value == titleMeta.min
                            ? const SizedBox.shrink()
                            : FittedBox(
                                child: Text(
                                  CurrencyUtil.formatWithNumberOfDigits(
                                    value,
                                    value > 100 ? 2 : 4,
                                  ),
                                  style: axisTextStyle,
                                ),
                              );
                    return SideTitleWidget(
                      axisSide: titleMeta.axisSide,
                      child: axisTitle,
                    );
                  },
                ),
              )
            : const AxisTitles(),
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
    return LineChart(
      _chartData,
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 1000),
    );
  }
}
