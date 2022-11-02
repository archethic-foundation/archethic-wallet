/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/domain/repositories/market.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:coingecko_api/coingecko_api.dart';

class CoingeckoUCOMarketRepository implements MarketRepositoryInterface {
  CoingeckoUCOMarketRepository();

  CoinGeckoApi? _coinGeckoApi;
  CoinGeckoApi get coinGeckoApi => _coinGeckoApi ??= sl.get<CoinGeckoApi>();

  static const archethicId = 'archethic';

  @override
  bool useOracle = false;

  @override
  bool canHandleCurrency(String currency) {
    return currency != 'eur' && currency != 'usd';
  }

  @override
  Future<Result<MarketPrice, Failure>> getUCOMarketPrice(
    String currency,
  ) async {
    try {
      if (currency.isEmpty) {
        return const Result.failure(
          Failure.invalidValue(),
        );
      }

      final coinData = await coinGeckoApi.simple.listPrices(
        ids: [archethicId],
        vsCurrencies: [currency],
        includeLastUpdatedAt: true,
      );
      if (coinData.isError) {
        return Result.failure(
          Failure.other(
            cause: coinData.errorMessage,
          ),
        );
      }

      if (coinData.data.isEmpty ||
          coinData.data[0].getPriceIn(archethicId) == null) {
        return const Result.failure(
          Failure.invalidValue(),
        );
      }

      return Result.success(
        MarketPrice(
          amount: coinData.data[0].getPriceIn(archethicId)!,
          lastLoading: coinData.data[0].lastUpdatedAt.microsecondsSinceEpoch ~/
              Duration.millisecondsPerSecond,
          useOracle: false,
        ),
      );
    } catch (e, stack) {
      return Result.failure(
        Failure.other(
          cause: e,
          stack: stack,
        ),
      );
    }
  }
}
