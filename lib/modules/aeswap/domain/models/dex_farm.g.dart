// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_farm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexFarmImpl _$$DexFarmImplFromJson(Map<String, dynamic> json) =>
    _$DexFarmImpl(
      farmAddress: json['farmAddress'] as String? ?? '',
      poolAddress: json['poolAddress'] as String? ?? '',
      apr: (json['apr'] as num?)?.toDouble() ?? 0,
      lpToken: json['lpToken'] == null
          ? null
          : DexToken.fromJson(json['lpToken'] as Map<String, dynamic>),
      lpTokenPair: json['lpTokenPair'] == null
          ? null
          : DexPair.fromJson(json['lpTokenPair'] as Map<String, dynamic>),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      rewardToken: json['rewardToken'] == null
          ? null
          : DexToken.fromJson(json['rewardToken'] as Map<String, dynamic>),
      remainingReward: (json['remainingReward'] as num?)?.toDouble() ?? 0,
      remainingRewardInFiat:
          (json['remainingRewardInFiat'] as num?)?.toDouble() ?? 0,
      lpTokenDeposited: (json['lpTokenDeposited'] as num?)?.toDouble() ?? 0,
      nbDeposit: (json['nbDeposit'] as num?)?.toInt() ?? 0,
      estimateLPTokenInFiat:
          (json['estimateLPTokenInFiat'] as num?)?.toDouble() ?? 0,
      statsRewardDistributed:
          (json['statsRewardDistributed'] as num?)?.toDouble() ?? 0.0,
      depositedAmount: (json['depositedAmount'] as num?)?.toDouble(),
      rewardAmount: (json['rewardAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$DexFarmImplToJson(_$DexFarmImpl instance) =>
    <String, dynamic>{
      'farmAddress': instance.farmAddress,
      'poolAddress': instance.poolAddress,
      'apr': instance.apr,
      'lpToken': instance.lpToken,
      'lpTokenPair': instance.lpTokenPair,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'rewardToken': instance.rewardToken,
      'remainingReward': instance.remainingReward,
      'remainingRewardInFiat': instance.remainingRewardInFiat,
      'lpTokenDeposited': instance.lpTokenDeposited,
      'nbDeposit': instance.nbDeposit,
      'estimateLPTokenInFiat': instance.estimateLPTokenInFiat,
      'statsRewardDistributed': instance.statsRewardDistributed,
      'depositedAmount': instance.depositedAmount,
      'rewardAmount': instance.rewardAmount,
    };
