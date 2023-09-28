// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keychain_secured_infos_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeychainSecuredInfosServiceImpl _$$KeychainSecuredInfosServiceImplFromJson(
        Map<String, dynamic> json) =>
    _$KeychainSecuredInfosServiceImpl(
      derivationPath: json['derivationPath'] as String,
      name: json['name'] as String,
      keyPair: json['keyPair'] == null
          ? null
          : KeychainServiceKeyPair.fromJson(
              json['keyPair'] as Map<String, dynamic>),
      curve: json['curve'] as String,
      hashAlgo: json['hashAlgo'] as String,
    );

Map<String, dynamic> _$$KeychainSecuredInfosServiceImplToJson(
        _$KeychainSecuredInfosServiceImpl instance) =>
    <String, dynamic>{
      'derivationPath': instance.derivationPath,
      'name': instance.name,
      'keyPair': instance.keyPair,
      'curve': instance.curve,
      'hashAlgo': instance.hashAlgo,
    };
