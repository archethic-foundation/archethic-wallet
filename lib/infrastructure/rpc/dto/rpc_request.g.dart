// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RpcRequestOrigin _$$_RpcRequestOriginFromJson(Map<String, dynamic> json) =>
    _$_RpcRequestOrigin(
      name: json['name'] as String,
      url: json['url'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$$_RpcRequestOriginToJson(_$_RpcRequestOrigin instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'logo': instance.logo,
    };

_$_RpcRequest _$$_RpcRequestFromJson(Map<String, dynamic> json) =>
    _$_RpcRequest(
      origin:
          RpcRequestOriginDTO.fromJson(json['origin'] as Map<String, dynamic>),
      version: json['version'] as int,
      payload: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_RpcRequestToJson(_$_RpcRequest instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'version': instance.version,
      'payload': instance.payload,
    };
