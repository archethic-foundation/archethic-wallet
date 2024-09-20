// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pool_infos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPoolInfosResponseImpl _$$GetPoolInfosResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetPoolInfosResponseImpl(
      token1: Token.fromJson(json['token1'] as Map<String, dynamic>),
      token2: Token.fromJson(json['token2'] as Map<String, dynamic>),
      lpToken: LPToken.fromJson(json['lp_token'] as Map<String, dynamic>),
      fee: (json['fee'] as num).toDouble(),
      protocolFee: (json['protocol_fee'] as num).toDouble(),
      stats: Stats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetPoolInfosResponseImplToJson(
        _$GetPoolInfosResponseImpl instance) =>
    <String, dynamic>{
      'token1': instance.token1,
      'token2': instance.token2,
      'lp_token': instance.lpToken,
      'fee': instance.fee,
      'protocol_fee': instance.protocolFee,
      'stats': instance.stats,
    };

_$TokenImpl _$$TokenImplFromJson(Map<String, dynamic> json) => _$TokenImpl(
      address: json['address'] as String,
      reserve: (json['reserve'] as num).toDouble(),
    );

Map<String, dynamic> _$$TokenImplToJson(_$TokenImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'reserve': instance.reserve,
    };

_$LPTokenImpl _$$LPTokenImplFromJson(Map<String, dynamic> json) =>
    _$LPTokenImpl(
      address: json['address'] as String,
      supply: (json['supply'] as num).toDouble(),
    );

Map<String, dynamic> _$$LPTokenImplToJson(_$LPTokenImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'supply': instance.supply,
    };

_$StatsImpl _$$StatsImplFromJson(Map<String, dynamic> json) => _$StatsImpl(
      token1TotalFee: (json['token1_total_fee'] as num).toDouble(),
      token1TotalProtocolFee:
          (json['token1_total_protocol_fee'] as num).toDouble(),
      token1TotalVolume: (json['token1_total_volume'] as num).toDouble(),
      token2TotalFee: (json['token2_total_fee'] as num).toDouble(),
      token2TotalProtocolFee:
          (json['token2_total_protocol_fee'] as num).toDouble(),
      token2TotalVolume: (json['token2_total_volume'] as num).toDouble(),
    );

Map<String, dynamic> _$$StatsImplToJson(_$StatsImpl instance) =>
    <String, dynamic>{
      'token1_total_fee': instance.token1TotalFee,
      'token1_total_protocol_fee': instance.token1TotalProtocolFee,
      'token1_total_volume': instance.token1TotalVolume,
      'token2_total_fee': instance.token2TotalFee,
      'token2_total_protocol_fee': instance.token2TotalProtocolFee,
      'token2_total_volume': instance.token2TotalVolume,
    };
