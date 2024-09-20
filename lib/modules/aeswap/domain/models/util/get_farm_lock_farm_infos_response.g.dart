// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_farm_lock_farm_infos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetFarmLockFarmInfosResponseImpl _$$GetFarmLockFarmInfosResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetFarmLockFarmInfosResponseImpl(
      availableLevels: Map<String, int>.from(json['available_levels'] as Map),
      startDate: (json['start_date'] as num).toInt(),
      endDate: (json['end_date'] as num).toInt(),
      lpTokenAddress: json['lp_token_address'] as String,
      remainingRewards: (json['remaining_rewards'] as num).toDouble(),
      rewardToken: json['reward_token'] as String,
      rewardsDistributed: (json['rewards_distributed'] as num).toDouble(),
      lpTokensDeposited: (json['lp_tokens_deposited'] as num).toDouble(),
      stats: (json['stats'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Stats.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$GetFarmLockFarmInfosResponseImplToJson(
        _$GetFarmLockFarmInfosResponseImpl instance) =>
    <String, dynamic>{
      'available_levels': instance.availableLevels,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'lp_token_address': instance.lpTokenAddress,
      'remaining_rewards': instance.remainingRewards,
      'reward_token': instance.rewardToken,
      'rewards_distributed': instance.rewardsDistributed,
      'lp_tokens_deposited': instance.lpTokensDeposited,
      'stats': instance.stats,
    };

_$StatsImpl _$$StatsImplFromJson(Map<String, dynamic> json) => _$StatsImpl(
      depositsCount: (json['deposits_count'] as num).toInt(),
      lpTokensDeposited: (json['lp_tokens_deposited'] as num).toDouble(),
      remainingRewards: (json['remaining_rewards'] as List<dynamic>)
          .map((e) => RemainingRewards.fromJson(e as Map<String, dynamic>))
          .toList(),
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$$StatsImplToJson(_$StatsImpl instance) =>
    <String, dynamic>{
      'deposits_count': instance.depositsCount,
      'lp_tokens_deposited': instance.lpTokensDeposited,
      'remaining_rewards': instance.remainingRewards,
      'weight': instance.weight,
    };

_$RemainingRewardsImpl _$$RemainingRewardsImplFromJson(
        Map<String, dynamic> json) =>
    _$RemainingRewardsImpl(
      rewards: (json['remaining_rewards'] as num).toDouble(),
      start: (json['start'] as num).toInt(),
      end: (json['end'] as num).toInt(),
    );

Map<String, dynamic> _$$RemainingRewardsImplToJson(
        _$RemainingRewardsImpl instance) =>
    <String, dynamic>{
      'remaining_rewards': instance.rewards,
      'start': instance.start,
      'end': instance.end,
    };
