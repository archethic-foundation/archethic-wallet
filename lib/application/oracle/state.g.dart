// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ArchethicOracleUCO _$$_ArchethicOracleUCOFromJson(
        Map<String, dynamic> json) =>
    _$_ArchethicOracleUCO(
      timestamp: json['timestamp'] as int? ?? 0,
      eur: (json['eur'] as num?)?.toDouble() ?? 0,
      usd: (json['usd'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_ArchethicOracleUCOToJson(
        _$_ArchethicOracleUCO instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'eur': instance.eur,
      'usd': instance.usd,
    };
