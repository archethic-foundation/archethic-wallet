// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_sign_transaction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RpcSignTransactionResult _$$_RpcSignTransactionResultFromJson(
        Map<String, dynamic> json) =>
    _$_RpcSignTransactionResult(
      transactionAddress: json['transactionAddress'] as String,
      nbConfirmations: json['nbConfirmations'] as int,
      maxConfirmations: json['maxConfirmations'] as int,
    );

Map<String, dynamic> _$$_RpcSignTransactionResultToJson(
        _$_RpcSignTransactionResult instance) =>
    <String, dynamic>{
      'transactionAddress': instance.transactionAddress,
      'nbConfirmations': instance.nbConfirmations,
      'maxConfirmations': instance.maxConfirmations,
    };
