// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_input_with_tx_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransactionInputWithTxAddress _$$_TransactionInputWithTxAddressFromJson(
        Map<String, dynamic> json) =>
    _$_TransactionInputWithTxAddress(
      txAddress: json['txAddress'] as String? ?? '',
      amount: json['amount'] as int? ?? 0,
      from: json['from'] as String? ?? '',
      tokenAddress: json['tokenAddress'] as String?,
      spent: json['spent'] as bool? ?? true,
      timestamp: json['timestamp'] as int? ?? 0,
      type: json['type'] as String?,
      tokenId: json['tokenId'] as int?,
    );

Map<String, dynamic> _$$_TransactionInputWithTxAddressToJson(
        _$_TransactionInputWithTxAddress instance) =>
    <String, dynamic>{
      'txAddress': instance.txAddress,
      'amount': instance.amount,
      'from': instance.from,
      'tokenAddress': instance.tokenAddress,
      'spent': instance.spent,
      'timestamp': instance.timestamp,
      'type': instance.type,
      'tokenId': instance.tokenId,
    };
