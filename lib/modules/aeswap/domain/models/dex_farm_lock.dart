/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock_stats.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock_user_infos.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pair.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_farm_lock.freezed.dart';
part 'dex_farm_lock.g.dart';

const int kFarmTypeLock = 2;

@freezed
class DexFarmLock with _$DexFarmLock {
  const factory DexFarmLock({
    @Default('') String farmAddress,
    @Default('') String poolAddress,
    @Default(0.0) double remainingReward,
    @Default(0.0) double remainingRewardInFiat,
    @Default(0.0) double rewardDistributed,
    @Default(0.0) double lpTokensDeposited,
    DexToken? lpToken,
    DexPair? lpTokenPair,
    DateTime? startDate,
    DateTime? endDate,
    DexToken? rewardToken,
    @Default(0) double apr,
    @Default(0) double estimateLPTokenInFiat,
    @Default({}) Map<String, int> availableLevels,
    @Default({}) Map<String, DexFarmLockStats> stats,
    @Default({}) Map<String, DexFarmLockUserInfos> userInfos,
  }) = _DexFarmLock;
  const DexFarmLock._();

  factory DexFarmLock.fromJson(Map<String, dynamic> json) =>
      _$DexFarmLockFromJson(json);

  double get apr3years {
    return stats['7']?.aprEstimation ?? 0.0;
  }

  bool get isOpen =>
      startDate != null &&
      endDate != null &&
      startDate!.isBefore(endDate!) &&
      endDate!.isAfter(DateTime.now().toUtc());
}

extension TimestampExt on int {
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(
        this * 1000,
        isUtc: true,
      );
}
