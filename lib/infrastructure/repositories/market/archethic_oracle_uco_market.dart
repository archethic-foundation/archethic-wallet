/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/domain/repositories/market/market.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class ArchethicOracleUCOMarketRepository implements MarketRepositoryInterface {
  ArchethicOracleUCOMarketRepository();

  @override
  bool canHandleCurrency(AvailableCurrencyEnum currency) =>
      currency == AvailableCurrencyEnum.usd;

  Future<double> _getConversionRatio() async {
    final oracleUcoPrice =
        await sl.get<archethic.OracleService>().getOracleData();
    final usdConversionRate = oracleUcoPrice.uco?.usd;
    if (usdConversionRate == null || usdConversionRate == 0) {
      throw const Failure.network();
    }
    return usdConversionRate;
  }

  // TODO(reddwarf03): Provide a way to get the last value of an oracle #451 (3)
  @override
  Future<Result<MarketPrice, Failure>> getUCOMarketPrice(
    AvailableCurrencyEnum currency,
  ) =>
      Result.guard(() async {
        final price = await _getConversionRatio();

        return MarketPrice(
          amount: price,
          useOracle: true,
          lastLoading: DateTime.now().millisecondsSinceEpoch ~/
              Duration.millisecondsPerSecond,
        );
      });
}
