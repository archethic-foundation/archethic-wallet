import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/domain/repositories/market/price_history.dart';
import 'package:aewallet/infrastructure/repositories/market/coingecko_price_history_repository.dart';
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
  Ref ref, {
  required MarketPriceHistoryInterval scaleOption,
}) async {
  final selectedCurrency = ref.watch(
    SettingsProviders.settings.select((settings) => settings.currency),
  );
  return ref
      .watch(_repositoryProvider)
      .getWithInterval(
        vsCurrency: selectedCurrency,
        interval: scaleOption,
      )
      .valueOrThrow;
}

@Riverpod(keepAlive: true)
Future<double> _priceEvolution(
  Ref ref, {
  required MarketPriceHistoryInterval scaleOption,
}) async {
  final priceHistory = await ref.watch(
    _priceHistoryProvider(scaleOption: scaleOption).future,
  );

  return ref
      .watch(_repositoryProvider)
      .getPriceEvolution(
        priceHistory: priceHistory,
        interval: scaleOption,
      )
      .valueOrThrow;
}

abstract class PriceHistoryProviders {
  static final scaleOption = _intervalOptionProvider;
  static const chartData = _priceHistoryProvider;
  static const priceEvolution = _priceEvolutionProvider;
}
