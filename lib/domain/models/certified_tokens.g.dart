// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certified_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CertifiedTokensImpl _$$CertifiedTokensImplFromJson(
        Map<String, dynamic> json) =>
    _$CertifiedTokensImpl(
      mainnet:
          (json['mainnet'] as List<dynamic>).map((e) => e as String).toList(),
      testnet:
          (json['testnet'] as List<dynamic>).map((e) => e as String).toList(),
      devnet:
          (json['devnet'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$CertifiedTokensImplToJson(
        _$CertifiedTokensImpl instance) =>
    <String, dynamic>{
      'mainnet': instance.mainnet,
      'testnet': instance.testnet,
      'devnet': instance.devnet,
    };
