// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeeplinkRpcResponse _$DeeplinkRpcResponseFromJson(Map<String, dynamic> json) =>
    DeeplinkRpcResponse(
      id: json['id'] as String,
      failure: json['failure'],
      result: json['result'],
    );

Map<String, dynamic> _$DeeplinkRpcResponseToJson(DeeplinkRpcResponse instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('failure', instance.failure);
  writeNotNull('result', instance.result);
  return val;
}
