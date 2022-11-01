/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';
part 'market_price.freezed.dart';

/// Represents a token, blockchain agnostic.
@freezed
class MarketPrice with _$MarketPrice {
  const factory MarketPrice({
    required double amount,
    required int lastLoading,
    required bool useOracle,
  }) = _MarketPrice;
  const MarketPrice._();
}
