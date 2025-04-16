// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ae_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AEMessageImpl _$$AEMessageImplFromJson(Map<String, dynamic> json) =>
    _$AEMessageImpl(
      address: json['address'] as String? ?? '',
      senderGenesisPublicKey: json['senderGenesisPublicKey'] as String? ?? '',
      content: json['content'] as String? ?? '',
      timestampCreation: (json['timestampCreation'] as num?)?.toInt() ?? 0,
      sender: json['sender'] as String? ?? '',
    );

Map<String, dynamic> _$$AEMessageImplToJson(_$AEMessageImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'senderGenesisPublicKey': instance.senderGenesisPublicKey,
      'content': instance.content,
      'timestampCreation': instance.timestampCreation,
      'sender': instance.sender,
    };
