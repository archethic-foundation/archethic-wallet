import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_farm_lock_stats_rewards_allocated.freezed.dart';
part 'dex_farm_lock_stats_rewards_allocated.g.dart';

@freezed
class DexFarmLockStatsRemainingRewards with _$DexFarmLockStatsRemainingRewards {
  const factory DexFarmLockStatsRemainingRewards({
    @Default(0.0) double rewardsAllocated,
    @Default(0) int startPeriod,
    @Default(0) int endPeriod,
  }) = _DexFarmLockStatsRemainingRewards;
  const DexFarmLockStatsRemainingRewards._();

  factory DexFarmLockStatsRemainingRewards.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DexFarmLockStatsRemainingRewardsFromJson(json);
}
