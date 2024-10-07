/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_pair.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_pool.freezed.dart';
part 'dex_pool.g.dart';

/// Immutable Pool data which can be stored in cache forever
@freezed
class DexPool with _$DexPool {
  const factory DexPool({
    required String poolAddress,
    required DexToken lpToken,
    required DexPair pair,
    required bool lpTokenInUserBalance,
  }) = _DexPool;
  const DexPool._();

  factory DexPool.fromJson(Map<String, dynamic> json) =>
      _$DexPoolFromJson(json);

  bool get isVerified => pair.token1.isVerified && pair.token2.isVerified;
}
