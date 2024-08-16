import 'package:aewallet/application/oracle/provider.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/domain/repositories/market/market.dart';
import 'package:aewallet/domain/usecases/market/get_market_price.dart';
import 'package:aewallet/infrastructure/repositories/market/archethic_oracle_uco_market.dart';
import 'package:aewallet/infrastructure/repositories/market/coingecko_uco_market.dart';
import 'package:aewallet/infrastructure/repositories/market/local_uco_market.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'market_price.g.dart';

@Riverpod(keepAlive: true)
List<MarketRepositoryInterface> _remoteRepositories(
  _RemoteRepositoriesRef ref,
) =>
    [
      ArchethicOracleUCOMarketRepository(),
      CoingeckoUCOMarketRepository(),
    ];

@Riverpod(keepAlive: true)
MarketLocalRepositoryInterface _localRepository(_LocalRepositoryRef ref) =>
    HiveUcoMarketRepository();

@Riverpod(keepAlive: true)
Future<MarketPrice> _currencyMarketPrice(
  _CurrencyMarketPriceRef ref, {
  required AvailableCurrencyEnum currency,
}) =>
    GetUCOMarketPriceUsecases(
      remoteRepositories: ref.watch(_remoteRepositoriesProvider),
      localRepository: ref.watch(_localRepositoryProvider),
    ).updateFromRemoteUseCase.run(currency).valueOrThrow;

@Riverpod(keepAlive: true)
Future<MarketPrice> _selectedCurrencyMarketPrice(
  _SelectedCurrencyMarketPriceRef ref,
) async {
  final archethicOracleUCO =
      ref.watch(ArchethicOracleUCOProviders.archethicOracleUCO);
  return MarketPrice(
    amount: archethicOracleUCO.usd,
    lastLoading: archethicOracleUCO.timestamp,
    useOracle: true,
  );
}

@riverpod
Future<double> _convertedToSelectedCurrency(
  _ConvertedToSelectedCurrencyRef ref, {
  required double nativeAmount,
}) async {
  final selectedCurrencyMarketPrice = await ref.watch(
    _selectedCurrencyMarketPriceProvider.future,
  );
  return selectedCurrencyMarketPrice.amount * nativeAmount;
}

abstract class MarketPriceProviders {
  static const currencyMarketPrice = _currencyMarketPriceProvider;
  static final selectedCurrencyMarketPrice =
      _selectedCurrencyMarketPriceProvider;
  static const convertedToSelectedCurrency =
      _convertedToSelectedCurrencyProvider;
}
