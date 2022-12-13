// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keychain_service_keypair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_KeychainServiceKeyPair _$$_KeychainServiceKeyPairFromJson(
        Map<String, dynamic> json) =>
    _$_KeychainServiceKeyPair(
      privateKey:
          (json['privateKey'] as List<dynamic>).map((e) => e as int).toList(),
      publicKey:
          (json['publicKey'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$_KeychainServiceKeyPairToJson(
        _$_KeychainServiceKeyPair instance) =>
    <String, dynamic>{
      'privateKey': instance.privateKey,
      'publicKey': instance.publicKey,
    };
