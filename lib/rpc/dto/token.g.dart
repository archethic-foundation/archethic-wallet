// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TokenDTO _$$_TokenDTOFromJson(Map<String, dynamic> json) => _$_TokenDTO(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      initialSupply: (json['initialSupply'] as num).toDouble(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$_TokenDTOToJson(_$_TokenDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'initialSupply': instance.initialSupply,
      'type': instance.type,
    };
