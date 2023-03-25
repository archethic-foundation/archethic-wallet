import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

enum MarketPriceHistoryInterval {
  hour,
  day,
  week,
  twoWeeks,
  month,
  twoMonths,
  year,
  all,
}

extension PriceHistoryIntervalToString on MarketPriceHistoryInterval {
  String getChartOptionLabel(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (this) {
      case MarketPriceHistoryInterval.hour:
        return localizations.chartOptionLabel1h;
      case MarketPriceHistoryInterval.day:
        return localizations.chartOptionLabel24h;
      case MarketPriceHistoryInterval.week:
        return localizations.chartOptionLabel7d;
      case MarketPriceHistoryInterval.twoWeeks:
        return localizations.chartOptionLabel14d;
      case MarketPriceHistoryInterval.month:
        return localizations.chartOptionLabel30d;
      case MarketPriceHistoryInterval.twoMonths:
        return localizations.chartOptionLabel60d;
      case MarketPriceHistoryInterval.year:
        return localizations.chartOptionLabel1y;
      case MarketPriceHistoryInterval.all:
        return localizations.chartOptionLabelAll;
    }
  }
}

@immutable
class PriceHistoryValue {
  const PriceHistoryValue({
    required this.price,
    required this.time,
  });
  final num price;
  final DateTime time;
}
