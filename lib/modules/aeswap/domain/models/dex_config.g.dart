// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexConfigImpl _$$DexConfigImplFromJson(Map<String, dynamic> json) =>
    _$DexConfigImpl(
      name: json['name'] as String? ?? '',
      routerGenesisAddress: json['routerGenesisAddress'] as String? ?? '',
      factoryGenesisAddress: json['factoryGenesisAddress'] as String? ?? '',
    );

Map<String, dynamic> _$$DexConfigImplToJson(_$DexConfigImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'routerGenesisAddress': instance.routerGenesisAddress,
      'factoryGenesisAddress': instance.factoryGenesisAddress,
    };
