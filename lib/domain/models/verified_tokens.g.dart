// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verified_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VerifiedTokens _$$_VerifiedTokensFromJson(Map<String, dynamic> json) =>
    _$_VerifiedTokens(
      mainnet:
          (json['mainnet'] as List<dynamic>).map((e) => e as String).toList(),
      testnet:
          (json['testnet'] as List<dynamic>).map((e) => e as String).toList(),
      devnet:
          (json['devnet'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_VerifiedTokensToJson(_$_VerifiedTokens instance) =>
    <String, dynamic>{
      'mainnet': instance.mainnet,
      'testnet': instance.testnet,
      'devnet': instance.devnet,
    };
