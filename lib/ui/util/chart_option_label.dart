import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

extension PriceHistoryIntervalToString on aedappfm.MarketPriceHistoryInterval {
  String getChartOptionLabel(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (this) {
      case aedappfm.MarketPriceHistoryInterval.hour:
        return localizations.chartOptionLabel1h;
      case aedappfm.MarketPriceHistoryInterval.day:
        return localizations.chartOptionLabel24h;
      case aedappfm.MarketPriceHistoryInterval.week:
        return localizations.chartOptionLabel7d;
      case aedappfm.MarketPriceHistoryInterval.twoWeeks:
        return localizations.chartOptionLabel14d;
      case aedappfm.MarketPriceHistoryInterval.month:
        return localizations.chartOptionLabel30d;
      case aedappfm.MarketPriceHistoryInterval.twoMonths:
        return localizations.chartOptionLabel60d;
      case aedappfm.MarketPriceHistoryInterval.year:
        return localizations.chartOptionLabel1y;
    }
  }
}
