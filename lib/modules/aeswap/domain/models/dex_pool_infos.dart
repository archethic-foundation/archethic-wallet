/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_pool_infos.freezed.dart';
part 'dex_pool_infos.g.dart';

@freezed
class DexPoolInfos with _$DexPoolInfos {
  const factory DexPoolInfos({
    required String poolAddress,
    required String token1Address,
    required String token2Address,
    required double token1Reserve,
    required double token2Reserve,
    required double lpTokenSupply,
    required double fees,
    required double protocolFees,
    required double ratioToken1Token2,
    required double ratioToken2Token1,
    required double token1TotalFee,
    required double token1TotalVolume,
    required double token2TotalFee,
    required double token2TotalVolume,
  }) = _DexPoolInfos;

  factory DexPoolInfos.empty({
    required DexPool pool,
  }) =>
      DexPoolInfos(
        poolAddress: pool.poolAddress,
        token1Address: pool.pair.token1.address,
        token2Address: pool.pair.token2.address,
        token1Reserve: 0,
        token2Reserve: 0,
        lpTokenSupply: 0,
        fees: 0,
        protocolFees: 0,
        ratioToken1Token2: 0,
        ratioToken2Token1: 0,
        token1TotalFee: 0,
        token1TotalVolume: 0,
        token2TotalFee: 0,
        token2TotalVolume: 0,
      );

  const DexPoolInfos._();

  factory DexPoolInfos.fromJson(Map<String, dynamic> json) =>
      _$DexPoolInfosFromJson(json);
}

@freezed
class DexPoolStats with _$DexPoolStats {
  const factory DexPoolStats({
    required double token1TotalVolume24h,
    required double token2TotalVolume24h,
    required double token1TotalVolume7d,
    required double token2TotalVolume7d,
    required double token1TotalFee24h,
    required double token2TotalFee24h,
    required double fee24h,
    required double feeAllTime,
    required double volume24h,
    required double volume7d,
    required double volumeAllTime,
  }) = _DexPoolStats;

  factory DexPoolStats.empty() => const DexPoolStats(
        token1TotalVolume24h: 0,
        token2TotalVolume24h: 0,
        token1TotalVolume7d: 0,
        token2TotalVolume7d: 0,
        token1TotalFee24h: 0,
        token2TotalFee24h: 0,
        fee24h: 0,
        feeAllTime: 0,
        volume24h: 0,
        volume7d: 0,
        volumeAllTime: 0,
      );
  const DexPoolStats._();

  factory DexPoolStats.fromJson(Map<String, dynamic> json) =>
      _$DexPoolStatsFromJson(json);
}
