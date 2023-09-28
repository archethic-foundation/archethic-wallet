// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keychain_secured_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeychainSecuredInfosImpl _$$KeychainSecuredInfosImplFromJson(
        Map<String, dynamic> json) =>
    _$KeychainSecuredInfosImpl(
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

Map<String, dynamic> _$$KeychainSecuredInfosImplToJson(
        _$KeychainSecuredInfosImpl instance) =>
    <String, dynamic>{
      'seed': instance.seed,
      'version': instance.version,
      'services': instance.services,
    };
