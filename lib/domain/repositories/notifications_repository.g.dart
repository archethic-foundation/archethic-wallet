// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TxSentEventImpl _$$TxSentEventImplFromJson(Map<String, dynamic> json) =>
    _$TxSentEventImpl(
      txAddress: json['txAddress'] as String,
      txChainGenesisAddress: json['txChainGenesisAddress'] as String,
    );

Map<String, dynamic> _$$TxSentEventImplToJson(_$TxSentEventImpl instance) =>
    <String, dynamic>{
      'txAddress': instance.txAddress,
      'txChainGenesisAddress': instance.txChainGenesisAddress,
    };
