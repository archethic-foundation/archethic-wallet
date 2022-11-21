import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/domain/repositories/market/market.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/util/get_it_instance.dart';

class HiveUcoMarketRepository implements MarketLocalRepositoryInterface {
  @override
  Future<Result<MarketPrice?, Failure>> getPrice({
    required AvailableCurrencyEnum currency,
  }) =>
      Result.guard(() async {
        final price = await sl.get<DBHelper>().getPrice(currency);
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
        () => sl.get<DBHelper>().updatePrice(
              currency,
              Price(
                amount: price.amount,
                lastLoading: price.lastLoading,
                useOracleUcoPrice: price.useOracle,
              ),
            ),
      );
}
