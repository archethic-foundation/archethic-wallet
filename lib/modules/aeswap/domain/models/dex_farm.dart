/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_pair.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_farm.freezed.dart';
part 'dex_farm.g.dart';

const int kFarmTypeLegacy = 1;

@freezed
class DexFarm with _$DexFarm {
  const factory DexFarm({
    @Default('') String farmAddress,
    @Default('') String poolAddress,
    @Default(0) double apr,
    DexToken? lpToken,
    DexPair? lpTokenPair,
    DateTime? startDate,
    DateTime? endDate,
    DexToken? rewardToken,
    @Default(0) double remainingReward,
    @Default(0) double remainingRewardInFiat,
    @Default(0) double lpTokenDeposited,
    @Default(0) int nbDeposit,
    @Default(0) double estimateLPTokenInFiat,
    @Default(0.0) double statsRewardDistributed,

    // User info
    double? depositedAmount,
    double? rewardAmount,
  }) = _DexFarm;
  const DexFarm._();

  factory DexFarm.fromJson(Map<String, dynamic> json) =>
      _$DexFarmFromJson(json);
}

extension TimestampExt on int {
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(
        this * 1000,
        isUtc: true,
      );
}
