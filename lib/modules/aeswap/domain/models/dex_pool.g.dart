// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexPoolImpl _$$DexPoolImplFromJson(Map<String, dynamic> json) =>
    _$DexPoolImpl(
      poolAddress: json['poolAddress'] as String,
      lpToken: DexToken.fromJson(json['lpToken'] as Map<String, dynamic>),
      pair: DexPair.fromJson(json['pair'] as Map<String, dynamic>),
      lpTokenInUserBalance: json['lpTokenInUserBalance'] as bool,
      isFavorite: json['isFavorite'] as bool,
      infos: json['infos'] == null
          ? null
          : DexPoolInfos.fromJson(json['infos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DexPoolImplToJson(_$DexPoolImpl instance) =>
    <String, dynamic>{
      'poolAddress': instance.poolAddress,
      'lpToken': instance.lpToken,
      'pair': instance.pair,
      'lpTokenInUserBalance': instance.lpTokenInUserBalance,
      'isFavorite': instance.isFavorite,
      'infos': instance.infos,
    };
