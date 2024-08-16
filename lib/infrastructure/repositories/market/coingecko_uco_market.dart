/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/domain/repositories/market/market.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:coingecko_api/coingecko_api.dart';

class CoingeckoUCOMarketRepository implements MarketRepositoryInterface {
  CoingeckoUCOMarketRepository();

  CoinGeckoApi? _coinGeckoApi;
  CoinGeckoApi get coinGeckoApi => _coinGeckoApi ??= sl.get<CoinGeckoApi>();

  static const archethicId = 'archethic';

  @override
  bool canHandleCurrency(AvailableCurrencyEnum currency) =>
      currency != AvailableCurrencyEnum.usd;

  @override
  Future<Result<MarketPrice, Failure>> getUCOMarketPrice(
    AvailableCurrencyEnum currency,
  ) =>
      Result.guard(
        () async {
          final coinData = await coinGeckoApi.simple.listPrices(
            ids: [archethicId],
            vsCurrencies: [currency.name],
            includeLastUpdatedAt: true,
          );
          if (coinData.isError) {
            throw Failure.other(
              cause: coinData.errorMessage,
            );
          }

          final firstData = coinData.data.isEmpty ? null : coinData.data[0];
          if (firstData == null) {
            throw const Failure.invalidValue();
          }

          final price = firstData.getPriceIn(currency.name);
          if (price == null) {
            throw const Failure.invalidValue();
          }

          return MarketPrice(
            amount: price,
            lastLoading: firstData.lastUpdatedAt.microsecondsSinceEpoch ~/
                Duration.millisecondsPerSecond,
            useOracle: false,
          );
        },
      );
}
