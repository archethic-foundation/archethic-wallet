// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DeeplinkRpcFailure _$$_DeeplinkRpcFailureFromJson(
        Map<String, dynamic> json) =>
    _$_DeeplinkRpcFailure(
      code: json['code'] as int,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$$_DeeplinkRpcFailureToJson(
        _$_DeeplinkRpcFailure instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
