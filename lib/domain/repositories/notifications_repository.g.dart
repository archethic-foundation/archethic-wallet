// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TxSentEventImpl _$$TxSentEventImplFromJson(Map<String, dynamic> json) =>
    _$TxSentEventImpl(
      notificationRecipientAddress: json['txAddress'] as String,
      listenAddress: json['txChainGenesisAddress'] as String,
      type: json['type'] as String,
      extra: json['extra'],
    );

Map<String, dynamic> _$$TxSentEventImplToJson(_$TxSentEventImpl instance) =>
    <String, dynamic>{
      'txAddress': instance.notificationRecipientAddress,
      'txChainGenesisAddress': instance.listenAddress,
      'type': instance.type,
      'extra': instance.extra,
    };
