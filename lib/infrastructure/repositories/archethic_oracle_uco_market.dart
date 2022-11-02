/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/domain/repositories/market.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class ArchethicOracleUCOMarketRepository implements MarketRepositoryInterface {
  ArchethicOracleUCOMarketRepository();

  @override
  bool useOracle = true;

  archethic.OracleService? _archethicOracleApi;
  archethic.OracleService get archethicOracleApi =>
      _archethicOracleApi ??= sl.get<archethic.OracleService>();

  @override
  bool canHandleCurrency(String currency) {
    return currency == 'eur' || currency == 'usd';
  }

  @override
  Future<Result<MarketPrice, Failure>> getUCOMarketPrice(
    String currency,
  ) async {
    try {
      // TODO(reddwarf03): Provide a way to get the last value of an oracle #451

      final oracleData = await archethicOracleApi.getOracleData();

      if (oracleData.uco == null || oracleData.uco!.eur == 0) {
        return const Result.failure(
          Failure.invalidValue(),
        );
      }

      switch (currency) {
        case 'eur':
          return Result.success(
            MarketPrice(
              amount: oracleData.uco!.eur!,
              lastLoading: DateTime.now().millisecondsSinceEpoch ~/
                  Duration.millisecondsPerSecond,
              useOracle: useOracle,
            ),
          );
        case 'usd':
          return Result.success(
            MarketPrice(
              amount: oracleData.uco!.usd!,
              lastLoading: DateTime.now().millisecondsSinceEpoch ~/
                  Duration.millisecondsPerSecond,
              useOracle: true,
            ),
          );
        default:
          return const Result.failure(
            Failure.invalidValue(),
          );
      }
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
