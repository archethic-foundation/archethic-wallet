// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RPCRequest _$$_RPCRequestFromJson(Map<String, dynamic> json) =>
    _$_RPCRequest(
      method: json['method'] as String,
      jsonParams: json['jsonParams'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_RPCRequestToJson(_$_RPCRequest instance) =>
    <String, dynamic>{
      'method': instance.method,
      'jsonParams': instance.jsonParams,
    };
