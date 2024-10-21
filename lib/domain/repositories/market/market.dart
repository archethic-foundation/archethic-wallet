/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

abstract class MarketRepositoryInterface {
  MarketRepositoryInterface();

  bool canHandleCurrency(AvailableCurrencyEnum currency);

  Future<Result<MarketPrice, Failure>> getUCOMarketPrice(
    AvailableCurrencyEnum currency,
    archethic.OracleService oracleService,
  );
}

abstract class MarketLocalRepositoryInterface {
  Future<Result<MarketPrice?, Failure>> getPrice({
    required AvailableCurrencyEnum currency,
  });

  Future<Result<void, Failure>> setPrice({
    required AvailableCurrencyEnum currency,
    required MarketPrice price,
  });
}
