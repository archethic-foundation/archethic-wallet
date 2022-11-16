import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/domain/repositories/price_history.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:coingecko_api/coingecko_api.dart';

class CoinGeckoPriceHistoryRepository
    implements PriceHistoryRepositoryInterface {
  CoinGeckoApi? _coinGeckoApi;
  CoinGeckoApi get coinGeckoApi => _coinGeckoApi ??= sl.get<CoinGeckoApi>();

  static const archethicId = 'archethic';

  // Future<Result<List<double>, Failure>> getEvolution() async {
  //   final coinResult = await coinGeckoApi.coins.getCoinData(
  //     id: archethicId,
  //     // ignore: avoid_redundant_argument_values
  //     marketData: true,
  //     communityData: false,
  //     developerData: false,
  //     localization: false,
  //     // ignore: avoid_redundant_argument_values
  //     sparkline: false,
  //     tickers: false,
  //   );

  //   coinResult.data.marketData.
  //   }

  @override
  Future<Result<List<PriceHistoryValue>, Failure>> getWithInterval({
    required AvailableCurrencyEnum vsCurrency,
    required MarketPriceHistoryInterval interval,
  }) =>
      Result.guard(
        () async {
          final now = DateTime.now();
          final coinGeckoResponse =
              await coinGeckoApi.coins.getCoinMarketChartRanged(
            id: archethicId,
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
      case MarketPriceHistoryInterval.twoHundredDays:
        return const Duration(days: 200);
      case MarketPriceHistoryInterval.year:
        return const Duration(days: 365);
      case MarketPriceHistoryInterval.all:
        return const Duration(days: 365000);
    }
  }
}
