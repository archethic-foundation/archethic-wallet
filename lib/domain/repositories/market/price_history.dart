import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/model/available_currency.dart';

abstract class PriceHistoryRepositoryInterface {
  Future<Result<List<PriceHistoryValue>, Failure>> getWithInterval({
    required AvailableCurrencyEnum vsCurrency,
    required MarketPriceHistoryInterval interval,
  });

  Future<Result<double, Failure>> getPriceEvolution({
    required List<PriceHistoryValue> priceHistory,
    required MarketPriceHistoryInterval interval,
  });
}
