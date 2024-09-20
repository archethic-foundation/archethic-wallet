// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_farm_lock_user_infos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetFarmLockUserInfosResponseImpl _$$GetFarmLockUserInfosResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetFarmLockUserInfosResponseImpl(
      userInfos: (json['userInfos'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(int.parse(k),
                    UserInfos.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
    );

Map<String, dynamic> _$$GetFarmLockUserInfosResponseImplToJson(
        _$GetFarmLockUserInfosResponseImpl instance) =>
    <String, dynamic>{
      'userInfos': instance.userInfos
          .map((e) => e.map((k, e) => MapEntry(k.toString(), e)))
          .toList(),
    };

_$UserInfosImpl _$$UserInfosImplFromJson(Map<String, dynamic> json) =>
    _$UserInfosImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      rewardAmount: (json['reward_amount'] as num).toDouble(),
      start: (json['start'] as num?)?.toInt(),
      end: (json['end'] as num?)?.toInt(),
      level: json['level'] as String,
    );

Map<String, dynamic> _$$UserInfosImplToJson(_$UserInfosImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'reward_amount': instance.rewardAmount,
      'start': instance.start,
      'end': instance.end,
      'level': instance.level,
    };
