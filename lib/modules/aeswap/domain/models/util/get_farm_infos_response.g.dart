// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_farm_infos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetFarmInfosResponseImpl _$$GetFarmInfosResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetFarmInfosResponseImpl(
      lpTokenAddress: json['lp_token_address'] as String,
      rewardToken: json['reward_token'] as String,
      startDate: (json['start_date'] as num).toInt(),
      endDate: (json['end_date'] as num).toInt(),
      remainingReward: (json['remaining_reward'] as num?)?.toDouble(),
      lpTokenDeposited: (json['lp_token_deposited'] as num).toDouble(),
      nbDeposit: (json['nb_deposit'] as num).toInt(),
      stats: Stats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetFarmInfosResponseImplToJson(
        _$GetFarmInfosResponseImpl instance) =>
    <String, dynamic>{
      'lp_token_address': instance.lpTokenAddress,
      'reward_token': instance.rewardToken,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'remaining_reward': instance.remainingReward,
      'lp_token_deposited': instance.lpTokenDeposited,
      'nb_deposit': instance.nbDeposit,
      'stats': instance.stats,
    };

_$StatsImpl _$$StatsImplFromJson(Map<String, dynamic> json) => _$StatsImpl(
      rewardDistributed: (json['reward_distributed'] as num).toDouble(),
    );

Map<String, dynamic> _$$StatsImplToJson(_$StatsImpl instance) =>
    <String, dynamic>{
      'reward_distributed': instance.rewardDistributed,
    };
