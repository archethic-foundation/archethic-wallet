// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keychain_secured_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_KeychainSecuredInfos _$$_KeychainSecuredInfosFromJson(
        Map<String, dynamic> json) =>
    _$_KeychainSecuredInfos(
      seed: (json['seed'] as List<dynamic>).map((e) => e as int).toList(),
      version: json['version'] as int,
      services: (json['services'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k,
                KeychainSecuredInfosService.fromJson(
                    e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$_KeychainSecuredInfosToJson(
        _$_KeychainSecuredInfos instance) =>
    <String, dynamic>{
      'seed': instance.seed,
      'version': instance.version,
      'services': instance.services,
    };
