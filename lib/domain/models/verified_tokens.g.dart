// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verified_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerifiedTokensImpl _$$VerifiedTokensImplFromJson(Map<String, dynamic> json) =>
    _$VerifiedTokensImpl(
      mainnet:
          (json['mainnet'] as List<dynamic>).map((e) => e as String).toList(),
      testnet:
          (json['testnet'] as List<dynamic>).map((e) => e as String).toList(),
      devnet:
          (json['devnet'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$VerifiedTokensImplToJson(
        _$VerifiedTokensImpl instance) =>
    <String, dynamic>{
      'mainnet': instance.mainnet,
      'testnet': instance.testnet,
      'devnet': instance.devnet,
    };
