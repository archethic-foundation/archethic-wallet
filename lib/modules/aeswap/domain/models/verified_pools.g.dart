// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verified_pools.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerifiedPoolsImpl _$$VerifiedPoolsImplFromJson(Map<String, dynamic> json) =>
    _$VerifiedPoolsImpl(
      mainnet:
          (json['mainnet'] as List<dynamic>).map((e) => e as String).toList(),
      testnet:
          (json['testnet'] as List<dynamic>).map((e) => e as String).toList(),
      devnet:
          (json['devnet'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$VerifiedPoolsImplToJson(_$VerifiedPoolsImpl instance) =>
    <String, dynamic>{
      'mainnet': instance.mainnet,
      'testnet': instance.testnet,
      'devnet': instance.devnet,
    };
