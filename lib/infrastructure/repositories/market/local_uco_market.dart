import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/domain/repositories/market/market.dart';
import 'package:aewallet/infrastructure/datasources/price.hive.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/data/price.dart';

class HiveUcoMarketRepository implements MarketLocalRepositoryInterface {
  final priceHiveDatasource = PriceHiveDatasource.instance();

  @override
  Future<Result<MarketPrice?, Failure>> getPrice({
    required AvailableCurrencyEnum currency,
  }) =>
      Result.guard(() async {
        final price = await priceHiveDatasource.getPrice(currency);
        if (price == null) return null;

        return MarketPrice(
          amount: price.amount,
          useOracle: price.useOracleUcoPrice,
          lastLoading: price.lastLoading,
        );
      });

  @override
  Future<Result<void, Failure>> setPrice({
    required AvailableCurrencyEnum currency,
    required MarketPrice price,
  }) =>
      Result.guard(
        () => priceHiveDatasource.updatePrice(
          currency,
          Price(
            amount: price.amount,
            lastLoading: price.lastLoading,
            useOracleUcoPrice: price.useOracle,
          ),
        ),
      );
}
