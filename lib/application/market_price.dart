import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/domain/repositories/market.dart';
import 'package:aewallet/domain/usecases/market/get_market_price.dart';
import 'package:aewallet/infrastructure/repositories/archethic_oracle_uco_market.dart';
import 'package:aewallet/infrastructure/repositories/coingecko_uco_market.dart';
import 'package:aewallet/util/functional_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'market_price.g.dart';

@Riverpod(keepAlive: true)
List<MarketRepositoryInterface> _repositories(_RepositoriesRef ref) => [
      ArchethicOracleUCOMarketRepository(),
      CoingeckoUCOMarketRepository(),
    ];

@riverpod
Future<MarketPrice?> _getUCOMarketPrice(
  _GetUCOMarketPriceRef ref, {
  required String currency,
}) async {
  final marketPriceResult = await GetUCOMarketPriceUsecase(
    repositories: ref.watch(_repositoriesProvider),
  ).run(currency);
  return marketPriceResult.map(
    success: id,
    failure: (_) => null,
  );
}

abstract class MarketPriceProviders {
  static final getUCOMarketPrice = _getUCOMarketPriceProvider;
}
