/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';

abstract class MarketRepositoryInterface {
  MarketRepositoryInterface();

  bool useOracle = false;

  Future<Result<MarketPrice, Failure>> getUCOMarketPrice(
    String currency,
  );
}
