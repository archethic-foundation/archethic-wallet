// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DeeplinkRpcRequest _$$_DeeplinkRpcRequestFromJson(
        Map<String, dynamic> json) =>
    _$_DeeplinkRpcRequest(
      id: json['id'] as String,
      replyUrl: json['replyUrl'] as String,
      params: json['params'],
    );

Map<String, dynamic> _$$_DeeplinkRpcRequestToJson(
        _$_DeeplinkRpcRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'replyUrl': instance.replyUrl,
      'params': instance.params,
    };
