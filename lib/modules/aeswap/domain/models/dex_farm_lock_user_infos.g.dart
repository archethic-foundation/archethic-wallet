// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_farm_lock_user_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexFarmLockUserInfosImpl _$$DexFarmLockUserInfosImplFromJson(
        Map<String, dynamic> json) =>
    _$DexFarmLockUserInfosImpl(
      id: json['id'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      rewardAmount: (json['rewardAmount'] as num?)?.toDouble() ?? 0.0,
      start: (json['start'] as num?)?.toInt(),
      end: (json['end'] as num?)?.toInt(),
      level: json['level'] as String? ?? '',
      apr: (json['apr'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$DexFarmLockUserInfosImplToJson(
        _$DexFarmLockUserInfosImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'rewardAmount': instance.rewardAmount,
      'start': instance.start,
      'end': instance.end,
      'level': instance.level,
      'apr': instance.apr,
    };
