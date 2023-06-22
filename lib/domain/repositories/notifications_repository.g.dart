// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TxSentEvent _$$_TxSentEventFromJson(Map<String, dynamic> json) =>
    _$_TxSentEvent(
      txAddress: json['txAddress'] as String,
      txChainGenesisAddress: json['txChainGenesisAddress'] as String,
    );

Map<String, dynamic> _$$_TxSentEventToJson(_$_TxSentEvent instance) =>
    <String, dynamic>{
      'txAddress': instance.txAddress,
      'txChainGenesisAddress': instance.txChainGenesisAddress,
    };
