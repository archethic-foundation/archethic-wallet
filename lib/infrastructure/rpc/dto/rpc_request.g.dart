// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RpcRequestOriginImpl _$$RpcRequestOriginImplFromJson(
        Map<String, dynamic> json) =>
    _$RpcRequestOriginImpl(
      name: json['name'] as String,
      url: json['url'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$$RpcRequestOriginImplToJson(
        _$RpcRequestOriginImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'logo': instance.logo,
    };

_$RpcRequestImpl _$$RpcRequestImplFromJson(Map<String, dynamic> json) =>
    _$RpcRequestImpl(
      origin:
          RpcRequestOriginDTO.fromJson(json['origin'] as Map<String, dynamic>),
      version: json['version'] as int,
      payload: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$RpcRequestImplToJson(_$RpcRequestImpl instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'version': instance.version,
      'payload': instance.payload,
    };
