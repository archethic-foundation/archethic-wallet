// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_farm_lock_stats_rewards_allocated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexFarmLockStatsRemainingRewardsImpl
    _$$DexFarmLockStatsRemainingRewardsImplFromJson(
            Map<String, dynamic> json) =>
        _$DexFarmLockStatsRemainingRewardsImpl(
          rewardsAllocated:
              (json['rewardsAllocated'] as num?)?.toDouble() ?? 0.0,
          startPeriod: (json['startPeriod'] as num?)?.toInt() ?? 0,
          endPeriod: (json['endPeriod'] as num?)?.toInt() ?? 0,
        );

Map<String, dynamic> _$$DexFarmLockStatsRemainingRewardsImplToJson(
        _$DexFarmLockStatsRemainingRewardsImpl instance) =>
    <String, dynamic>{
      'rewardsAllocated': instance.rewardsAllocated,
      'startPeriod': instance.startPeriod,
      'endPeriod': instance.endPeriod,
    };
