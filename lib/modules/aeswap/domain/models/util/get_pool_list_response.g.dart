// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pool_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPoolListResponseImpl _$$GetPoolListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetPoolListResponseImpl(
      address: json['address'] as String,
      lpTokenAddress: json['lp_token_address'] as String,
      tokens: json['tokens'] as String,
    );

Map<String, dynamic> _$$GetPoolListResponseImplToJson(
        _$GetPoolListResponseImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'lp_token_address': instance.lpTokenAddress,
      'tokens': instance.tokens,
    };
