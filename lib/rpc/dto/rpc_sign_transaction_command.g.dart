// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_sign_transaction_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RpcSignTransactionCommand _$$_RpcSignTransactionCommandFromJson(
        Map<String, dynamic> json) =>
    _$_RpcSignTransactionCommand(
      accountName: json['accountName'] as String,
      data: json['data'] as Map<String, dynamic>,
      type: json['type'] as String,
      version: json['version'] as int,
    );

Map<String, dynamic> _$$_RpcSignTransactionCommandToJson(
        _$_RpcSignTransactionCommand instance) =>
    <String, dynamic>{
      'accountName': instance.accountName,
      'data': instance.data,
      'type': instance.type,
      'version': instance.version,
    };
