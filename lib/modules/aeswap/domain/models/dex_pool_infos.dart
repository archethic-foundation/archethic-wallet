/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_pool_infos.freezed.dart';
part 'dex_pool_infos.g.dart';

@freezed
class DexPoolInfos with _$DexPoolInfos {
  const factory DexPoolInfos({
    double? tvl,
    required double fees,
    required double protocolFees,
    required double ratioToken1Token2,
    required double ratioToken2Token1,
    required double token1TotalFee,
    required double token1TotalVolume,
    required double token2TotalFee,
    required double token2TotalVolume,
    double? token1TotalVolume24h,
    double? token2TotalVolume24h,
    double? token1TotalVolume7d,
    double? token2TotalVolume7d,
    double? token1TotalFee24h,
    double? token2TotalFee24h,
    double? fee24h,
    double? feeAllTime,
    double? volume24h,
    double? volume7d,
    double? volumeAllTime,
  }) = _DexPoolInfos;
  const DexPoolInfos._();

  factory DexPoolInfos.fromJson(Map<String, dynamic> json) =>
      _$DexPoolInfosFromJson(json);
}
