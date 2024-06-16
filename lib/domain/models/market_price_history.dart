import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_price_history.freezed.dart';
part 'market_price_history.g.dart';

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

class PriceHistoryValueConverter
    implements JsonConverter<PriceHistoryValue, Map<String, dynamic>> {
  const PriceHistoryValueConverter();

  @override
  PriceHistoryValue fromJson(Map<String, dynamic> json) {
    return PriceHistoryValue.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(PriceHistoryValue object) => object.toJson();
}

@freezed
class PriceHistoryValue with _$PriceHistoryValue {
  const factory PriceHistoryValue({
    required num price,
    required DateTime time,
  }) = _PriceHistoryValue;

  factory PriceHistoryValue.fromJson(Map<String, dynamic> json) =>
      _$PriceHistoryValueFromJson(json);
}
