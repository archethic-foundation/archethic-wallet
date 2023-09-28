// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RPCUnsubscribeCommandDTOImpl _$$RPCUnsubscribeCommandDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$RPCUnsubscribeCommandDTOImpl(
      subscriptionId: json['subscriptionId'] as String,
    );

Map<String, dynamic> _$$RPCUnsubscribeCommandDTOImplToJson(
        _$RPCUnsubscribeCommandDTOImpl instance) =>
    <String, dynamic>{
      'subscriptionId': instance.subscriptionId,
    };

_$RPCSubscriptionUpdateDTOImpl _$$RPCSubscriptionUpdateDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$RPCSubscriptionUpdateDTOImpl(
      subscriptionId: json['subscriptionId'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$RPCSubscriptionUpdateDTOImplToJson(
        _$RPCSubscriptionUpdateDTOImpl instance) =>
    <String, dynamic>{
      'subscriptionId': instance.subscriptionId,
      'data': instance.data,
    };
