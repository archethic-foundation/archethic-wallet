import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock_stats_rewards_allocated.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_farm_lock_stats.freezed.dart';
part 'dex_farm_lock_stats.g.dart';

@freezed
class DexFarmLockStats with _$DexFarmLockStats {
  const factory DexFarmLockStats({
    @Default(0) int depositsCount,
    @Default(0.0) double lpTokensDeposited,
    @Default([]) List<DexFarmLockStatsRemainingRewards> remainingRewards,
    @Default(0.0) double weight,
    @Default(0.0) double aprEstimation,
  }) = _DexFarmLockStats;
  const DexFarmLockStats._();

  factory DexFarmLockStats.fromJson(Map<String, dynamic> json) =>
      _$DexFarmLockStatsFromJson(json);
}
