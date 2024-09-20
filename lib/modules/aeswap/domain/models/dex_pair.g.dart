// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexPairImpl _$$DexPairImplFromJson(Map<String, dynamic> json) =>
    _$DexPairImpl(
      token1: DexToken.fromJson(json['token1'] as Map<String, dynamic>),
      token2: DexToken.fromJson(json['token2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DexPairImplToJson(_$DexPairImpl instance) =>
    <String, dynamic>{
      'token1': instance.token1,
      'token2': instance.token2,
    };
