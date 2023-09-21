// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TxSentEvent _$$_TxSentEventFromJson(Map<String, dynamic> json) =>
    _$_TxSentEvent(
      notificationRecipientAddress: json['txAddress'] as String,
      listenAddress: json['txChainGenesisAddress'] as String,
    );

Map<String, dynamic> _$$_TxSentEventToJson(_$_TxSentEvent instance) =>
    <String, dynamic>{
      'txAddress': instance.notificationRecipientAddress,
      'txChainGenesisAddress': instance.listenAddress,
    };
