// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartInfos {
  ChartInfos(
      {this.minY,
      this.maxY,
      this.minX,
      this.maxX,
      this.data,
      this.priceChangePercentage24h,
      this.priceChangePercentage14d,
      this.priceChangePercentage1y,
      this.priceChangePercentage200d,
      this.priceChangePercentage30d,
      this.priceChangePercentage60d,
      this.priceChangePercentage7d});

  double? minY = 0;
  double? maxY = 0;
  double? minX = 0;
  double? maxX = 0;
  List<FlSpot>? data;
  double? priceChangePercentage14d = 0;
  double? priceChangePercentage1y = 0;
  double? priceChangePercentage200d = 0;
  double? priceChangePercentage30d = 0;
  double? priceChangePercentage60d = 0;
  double? priceChangePercentage7d = 0;
  double? priceChangePercentage24h = 0;

  double? getPriceChangePercentage(String duration) {
    switch (duration) {
      case '14d':
        return priceChangePercentage14d;
      case '1y':
        return priceChangePercentage1y;
      case '200d':
        return priceChangePercentage200d;
      case '30d':
        return priceChangePercentage30d;
      case '60d':
        return priceChangePercentage60d;
      case '7d':
        return priceChangePercentage7d;
      case '24h':
      default:
        return priceChangePercentage24h;
    }
  }

  static String getChartOptionLabel(BuildContext context, String duration) {
    switch (duration) {
      case '14d':
        return AppLocalization.of(context)!.chartOptionLabel14d;
      case '1y':
        return AppLocalization.of(context)!.chartOptionLabel1y;
      case '200d':
        return AppLocalization.of(context)!.chartOptionLabel200d;
      case '30d':
        return AppLocalization.of(context)!.chartOptionLabel30d;
      case '60d':
        return AppLocalization.of(context)!.chartOptionLabel60d;
      case '7d':
        return AppLocalization.of(context)!.chartOptionLabel7d;
      case '24h':
      default:
        return AppLocalization.of(context)!.chartOptionLabel24h;
    }
  }
}
