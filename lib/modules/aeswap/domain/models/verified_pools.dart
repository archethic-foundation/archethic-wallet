/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verified_pools.freezed.dart';
part 'verified_pools.g.dart';

@freezed
class VerifiedPools with _$VerifiedPools {
  const factory VerifiedPools({
    required List<String> mainnet,
    required List<String> testnet,
    required List<String> devnet,
  }) = _VerifiedPools;

  factory VerifiedPools.fromJson(Map<String, dynamic> json) =>
      _$VerifiedPoolsFromJson(json);
}
