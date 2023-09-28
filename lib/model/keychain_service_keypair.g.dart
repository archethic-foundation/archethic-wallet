// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keychain_service_keypair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeychainServiceKeyPairImpl _$$KeychainServiceKeyPairImplFromJson(
        Map<String, dynamic> json) =>
    _$KeychainServiceKeyPairImpl(
      privateKey:
          (json['privateKey'] as List<dynamic>).map((e) => e as int).toList(),
      publicKey:
          (json['publicKey'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$KeychainServiceKeyPairImplToJson(
        _$KeychainServiceKeyPairImpl instance) =>
    <String, dynamic>{
      'privateKey': instance.privateKey,
      'publicKey': instance.publicKey,
    };
