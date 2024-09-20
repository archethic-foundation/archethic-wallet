// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_farm_lock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexFarmLockImpl _$$DexFarmLockImplFromJson(Map<String, dynamic> json) =>
    _$DexFarmLockImpl(
      farmAddress: json['farmAddress'] as String? ?? '',
      poolAddress: json['poolAddress'] as String? ?? '',
      remainingReward: (json['remainingReward'] as num?)?.toDouble() ?? 0.0,
      remainingRewardInFiat:
          (json['remainingRewardInFiat'] as num?)?.toDouble() ?? 0.0,
      rewardDistributed: (json['rewardDistributed'] as num?)?.toDouble() ?? 0.0,
      lpTokensDeposited: (json['lpTokensDeposited'] as num?)?.toDouble() ?? 0.0,
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
      apr: (json['apr'] as num?)?.toDouble() ?? 0,
      estimateLPTokenInFiat:
          (json['estimateLPTokenInFiat'] as num?)?.toDouble() ?? 0,
      availableLevels: (json['availableLevels'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      stats: (json['stats'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, DexFarmLockStats.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      userInfos: (json['userInfos'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, DexFarmLockUserInfos.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$DexFarmLockImplToJson(_$DexFarmLockImpl instance) =>
    <String, dynamic>{
      'farmAddress': instance.farmAddress,
      'poolAddress': instance.poolAddress,
      'remainingReward': instance.remainingReward,
      'remainingRewardInFiat': instance.remainingRewardInFiat,
      'rewardDistributed': instance.rewardDistributed,
      'lpTokensDeposited': instance.lpTokensDeposited,
      'lpToken': instance.lpToken,
      'lpTokenPair': instance.lpTokenPair,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'rewardToken': instance.rewardToken,
      'apr': instance.apr,
      'estimateLPTokenInFiat': instance.estimateLPTokenInFiat,
      'availableLevels': instance.availableLevels,
      'stats': instance.stats,
      'userInfos': instance.userInfos,
    };
