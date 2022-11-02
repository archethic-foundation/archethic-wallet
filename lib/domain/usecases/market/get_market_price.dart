/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/domain/repositories/market.dart';
import 'package:aewallet/domain/usecases/usecase.dart';

class GetUCOMarketPriceUsecase
    implements UseCase<String, Result<MarketPrice, Failure>> {
  const GetUCOMarketPriceUsecase({
    required this.repositories,
  });

  final List<MarketRepositoryInterface> repositories;

  MarketRepositoryInterface _findRepo(String currency) =>
      repositories.firstWhere(
        (repository) => repository.canHandleCurrency(currency),
      );

  @override
  Future<Result<MarketPrice, Failure>> run(String currency) async {
    if (currency.isEmpty) {
      return const Result.failure(Failure.invalidValue());
    }

    final repo = _findRepo(currency);

    return repo.getUCOMarketPrice(currency);
  }
}
