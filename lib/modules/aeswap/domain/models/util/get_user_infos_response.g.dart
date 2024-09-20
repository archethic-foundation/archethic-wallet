// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_infos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetUserInfosResponseImpl _$$GetUserInfosResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetUserInfosResponseImpl(
      depositedAmount: (json['deposited_amount'] as num).toDouble(),
      rewardAmount: (json['reward_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$GetUserInfosResponseImplToJson(
        _$GetUserInfosResponseImpl instance) =>
    <String, dynamic>{
      'deposited_amount': instance.depositedAmount,
      'reward_amount': instance.rewardAmount,
    };
