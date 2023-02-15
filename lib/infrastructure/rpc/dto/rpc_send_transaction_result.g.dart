// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_send_transaction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RpcSendTransactionResult _$$_RpcSendTransactionResultFromJson(
        Map<String, dynamic> json) =>
    _$_RpcSendTransactionResult(
      transactionAddress: json['transactionAddress'] as String,
      nbConfirmations: json['nbConfirmations'] as int,
      maxConfirmations: json['maxConfirmations'] as int,
    );

Map<String, dynamic> _$$_RpcSendTransactionResultToJson(
        _$_RpcSendTransactionResult instance) =>
    <String, dynamic>{
      'transactionAddress': instance.transactionAddress,
      'nbConfirmations': instance.nbConfirmations,
      'maxConfirmations': instance.maxConfirmations,
    };
