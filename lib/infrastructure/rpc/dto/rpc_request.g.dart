// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RpcRequestSource _$$_RpcRequestSourceFromJson(Map<String, dynamic> json) =>
    _$_RpcRequestSource(
      name: json['name'] as String,
      url: json['url'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$$_RpcRequestSourceToJson(_$_RpcRequestSource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'logo': instance.logo,
    };

_$_RpcRequest _$$_RpcRequestFromJson(Map<String, dynamic> json) =>
    _$_RpcRequest(
      source: RpcRequestSource.fromJson(json['source'] as Map<String, dynamic>),
      version: json['version'] as int,
      payload: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_RpcRequestToJson(_$_RpcRequest instance) =>
    <String, dynamic>{
      'source': instance.source,
      'version': instance.version,
      'payload': instance.payload,
    };
