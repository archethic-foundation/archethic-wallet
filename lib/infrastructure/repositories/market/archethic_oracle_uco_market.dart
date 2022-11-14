/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/domain/repositories/market.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class ArchethicOracleUCOMarketRepository implements MarketRepositoryInterface {
  ArchethicOracleUCOMarketRepository();

  archethic.OracleService? _archethicOracleApi;
  archethic.OracleService get archethicOracleApi =>
      _archethicOracleApi ??= sl.get<archethic.OracleService>();

  @override
  bool canHandleCurrency(AvailableCurrencyEnum currency) =>
      currency == AvailableCurrencyEnum.eur ||
      currency == AvailableCurrencyEnum.usd;

  Future<double> _getConversionRatio(AvailableCurrencyEnum currency) async {
    final oracleUcoPrice = await archethicOracleApi.getOracleData();
    final eurConversionRate = oracleUcoPrice.uco?.eur;
    final usdConversionRate = oracleUcoPrice.uco?.usd;
    if (eurConversionRate == null ||
        eurConversionRate == 0 ||
        usdConversionRate == null ||
        usdConversionRate == 0) {
      throw const Failure.network();
    }
    if (currency == AvailableCurrencyEnum.eur) return eurConversionRate;
    if (currency == AvailableCurrencyEnum.usd) return usdConversionRate;
    throw const Failure.invalidValue();
  }

  // TODO(reddwarf03): Provide a way to get the last value of an oracle #451
  @override
  Future<Result<MarketPrice, Failure>> getUCOMarketPrice(
    AvailableCurrencyEnum currency,
  ) =>
      Result.guard(() async {
        final price = await _getConversionRatio(currency);

        return MarketPrice(
          amount: price,
          useOracle: true,
          lastLoading: DateTime.now().millisecondsSinceEpoch ~/
              Duration.millisecondsPerSecond,
        );
      });
}
