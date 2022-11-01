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
  Future<Result<MarketPrice, Failure>> getUCOMarketPrice(
    String currency,
  ) async {
    try {
      final oracleData = await archethicOracleApi.getOracleData();

      // TODO(reddwarf03): find a way to know which currencies are managed by the blockchain with an oracle
      // TODO(reddwarf03): Provide a way to get the last value of an oracle #451
      if (currency != 'eur' && currency != 'usd') {
        return const Result.failure(
          Failure.invalidValue(),
        );
      }

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
