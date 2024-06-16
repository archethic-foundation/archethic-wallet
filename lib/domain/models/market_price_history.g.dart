// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_price_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriceHistoryValueImpl _$$PriceHistoryValueImplFromJson(
        Map<String, dynamic> json) =>
    _$PriceHistoryValueImpl(
      price: json['price'] as num,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$$PriceHistoryValueImplToJson(
        _$PriceHistoryValueImpl instance) =>
    <String, dynamic>{
      'price': instance.price,
      'time': instance.time.toIso8601String(),
    };
