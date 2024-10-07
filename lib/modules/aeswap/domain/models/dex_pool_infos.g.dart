// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pool_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexPoolInfosImpl _$$DexPoolInfosImplFromJson(Map<String, dynamic> json) =>
    _$DexPoolInfosImpl(
      poolAddress: json['poolAddress'] as String,
      token1Address: json['token1Address'] as String,
      token2Address: json['token2Address'] as String,
      token1Reserve: (json['token1Reserve'] as num).toDouble(),
      token2Reserve: (json['token2Reserve'] as num).toDouble(),
      lpTokenSupply: (json['lpTokenSupply'] as num).toDouble(),
      fees: (json['fees'] as num).toDouble(),
      protocolFees: (json['protocolFees'] as num).toDouble(),
      ratioToken1Token2: (json['ratioToken1Token2'] as num).toDouble(),
      ratioToken2Token1: (json['ratioToken2Token1'] as num).toDouble(),
      token1TotalFee: (json['token1TotalFee'] as num).toDouble(),
      token1TotalVolume: (json['token1TotalVolume'] as num).toDouble(),
      token2TotalFee: (json['token2TotalFee'] as num).toDouble(),
      token2TotalVolume: (json['token2TotalVolume'] as num).toDouble(),
    );

Map<String, dynamic> _$$DexPoolInfosImplToJson(_$DexPoolInfosImpl instance) =>
    <String, dynamic>{
      'poolAddress': instance.poolAddress,
      'token1Address': instance.token1Address,
      'token2Address': instance.token2Address,
      'token1Reserve': instance.token1Reserve,
      'token2Reserve': instance.token2Reserve,
      'lpTokenSupply': instance.lpTokenSupply,
      'fees': instance.fees,
      'protocolFees': instance.protocolFees,
      'ratioToken1Token2': instance.ratioToken1Token2,
      'ratioToken2Token1': instance.ratioToken2Token1,
      'token1TotalFee': instance.token1TotalFee,
      'token1TotalVolume': instance.token1TotalVolume,
      'token2TotalFee': instance.token2TotalFee,
      'token2TotalVolume': instance.token2TotalVolume,
    };

_$DexPoolStatsImpl _$$DexPoolStatsImplFromJson(Map<String, dynamic> json) =>
    _$DexPoolStatsImpl(
      token1TotalVolume24h: (json['token1TotalVolume24h'] as num).toDouble(),
      token2TotalVolume24h: (json['token2TotalVolume24h'] as num).toDouble(),
      token1TotalVolume7d: (json['token1TotalVolume7d'] as num).toDouble(),
      token2TotalVolume7d: (json['token2TotalVolume7d'] as num).toDouble(),
      token1TotalFee24h: (json['token1TotalFee24h'] as num).toDouble(),
      token2TotalFee24h: (json['token2TotalFee24h'] as num).toDouble(),
      fee24h: (json['fee24h'] as num).toDouble(),
      feeAllTime: (json['feeAllTime'] as num).toDouble(),
      volume24h: (json['volume24h'] as num).toDouble(),
      volume7d: (json['volume7d'] as num).toDouble(),
      volumeAllTime: (json['volumeAllTime'] as num).toDouble(),
    );

Map<String, dynamic> _$$DexPoolStatsImplToJson(_$DexPoolStatsImpl instance) =>
    <String, dynamic>{
      'token1TotalVolume24h': instance.token1TotalVolume24h,
      'token2TotalVolume24h': instance.token2TotalVolume24h,
      'token1TotalVolume7d': instance.token1TotalVolume7d,
      'token2TotalVolume7d': instance.token2TotalVolume7d,
      'token1TotalFee24h': instance.token1TotalFee24h,
      'token2TotalFee24h': instance.token2TotalFee24h,
      'fee24h': instance.fee24h,
      'feeAllTime': instance.feeAllTime,
      'volume24h': instance.volume24h,
      'volume7d': instance.volume7d,
      'volumeAllTime': instance.volumeAllTime,
    };
