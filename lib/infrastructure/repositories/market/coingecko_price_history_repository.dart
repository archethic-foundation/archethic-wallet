import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/domain/repositories/market/price_history.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/data/coin_market_data.dart';

class CoinGeckoPriceHistoryRepository
    implements PriceHistoryRepositoryInterface {
  CoinGeckoApi? _coinGeckoApi;
  CoinGeckoApi get coinGeckoApi => _coinGeckoApi ??= sl.get<CoinGeckoApi>();

  @override
  Future<Result<double, Failure>> getPriceEvolution({
    required List<PriceHistoryValue> priceHistory,
    required MarketPriceHistoryInterval interval,
    required String coinId,
  }) =>
      Result.guard(
        () async {
          final coinResult = await coinGeckoApi.coins.getCoinData(
            id: coinId,
            // ignore: avoid_redundant_argument_values
            marketData: true,
            communityData: false,
            developerData: false,
            localization: false,
            // ignore: avoid_redundant_argument_values
            sparkline: false,
            tickers: false,
          );

          final result = coinResult.data?.marketData?.priceEvolution(
            priceHistory: priceHistory,
            interval: interval,
          );
          if (result == null) throw const Failure.invalidValue();
          return result;
        },
      );

  @override
  Future<Result<List<PriceHistoryValue>, Failure>> getWithInterval({
    required AvailableCurrencyEnum vsCurrency,
    required MarketPriceHistoryInterval interval,
    required String coinId,
  }) =>
      Result.guard(
        () async {
          final now = DateTime.now();
          final coinGeckoResponse =
              await coinGeckoApi.coins.getCoinMarketChartRanged(
            id: coinId,
            vsCurrency: vsCurrency.name,
            from: now.subtract(
              interval.duration,
            ),
            to: now,
          );

          if (coinGeckoResponse.isError) {
            if (coinGeckoResponse.errorCode == 429) {
              throw const Failure.quotaExceeded();
            }
            throw Failure.other(cause: coinGeckoResponse.errorMessage);
          }
          return coinGeckoResponse.data
              .map(
                (marketChartDataDTO) => PriceHistoryValue(
                  price: marketChartDataDTO.price ?? 0,
                  time: marketChartDataDTO.date,
                ),
              )
              .toList();
        },
      );
}

extension CoinGeckoPriceHistoryConversion on MarketPriceHistoryInterval {
  Duration get duration {
    switch (this) {
      case MarketPriceHistoryInterval.hour:
        return const Duration(hours: 1);
      case MarketPriceHistoryInterval.day:
        return const Duration(days: 1);
      case MarketPriceHistoryInterval.week:
        return const Duration(days: 7);
      case MarketPriceHistoryInterval.twoWeeks:
        return const Duration(days: 14);
      case MarketPriceHistoryInterval.month:
        return const Duration(days: 30);
      case MarketPriceHistoryInterval.twoMonths:
        return const Duration(days: 60);
      case MarketPriceHistoryInterval.year:
        return const Duration(days: 365);
      case MarketPriceHistoryInterval.all:
        return const Duration(days: 365000);
    }
  }
}

extension CoinGeckoMarketDataSelection on CoinMarketData {
  double _priceEvolution({
    required List<PriceHistoryValue> priceHistory,
  }) =>
      ((priceHistory.last.price / priceHistory.first.price) - 1) * 100;

  double? priceEvolution({
    required List<PriceHistoryValue> priceHistory,
    required MarketPriceHistoryInterval interval,
  }) {
    switch (interval) {
      case MarketPriceHistoryInterval.hour:
        return _priceEvolution(priceHistory: priceHistory);
      case MarketPriceHistoryInterval.day:
        return priceChangePercentage24h;
      case MarketPriceHistoryInterval.week:
        return priceChangePercentage7d;
      case MarketPriceHistoryInterval.twoWeeks:
        return priceChangePercentage14d;
      case MarketPriceHistoryInterval.month:
        return priceChangePercentage30d;
      case MarketPriceHistoryInterval.twoMonths:
        return priceChangePercentage60d;
      case MarketPriceHistoryInterval.year:
        return priceChangePercentage1y;
      case MarketPriceHistoryInterval.all:
        return _priceEvolution(priceHistory: priceHistory);
    }
  }
}
