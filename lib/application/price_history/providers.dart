import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/domain/repositories/market/price_history.dart';
import 'package:aewallet/infrastructure/repositories/market/coingecko_price_history_repository.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
PriceHistoryRepositoryInterface _repository(Ref ref) =>
    CoinGeckoPriceHistoryRepository();

@Riverpod(keepAlive: true)
MarketPriceHistoryInterval _intervalOption(Ref ref) => ref.watch(
      SettingsProviders.settings
          .select((value) => value.priceChartIntervalOption),
    );

@Riverpod(keepAlive: true)
Future<List<PriceHistoryValue>> _priceHistory(
  _PriceHistoryRef ref, {
  required MarketPriceHistoryInterval scaleOption,
  required String coinId,
}) async {
  return ref
      .watch(_repositoryProvider)
      .getWithInterval(
        vsCurrency: AvailableCurrencyEnum.usd,
        interval: scaleOption,
        coinId: coinId,
      )
      .valueOrThrow;
}

abstract class PriceHistoryProviders {
  static final scaleOption = _intervalOptionProvider;
  static const priceHistory = _priceHistoryProvider;
}
