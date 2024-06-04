// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArchethicOracleUCOImpl _$$ArchethicOracleUCOImplFromJson(
        Map<String, dynamic> json) =>
    _$ArchethicOracleUCOImpl(
      timestamp: (json['timestamp'] as num?)?.toInt() ?? 0,
      eur: (json['eur'] as num?)?.toDouble() ?? 0,
      usd: (json['usd'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$ArchethicOracleUCOImplToJson(
        _$ArchethicOracleUCOImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'eur': instance.eur,
      'usd': instance.usd,
    };
