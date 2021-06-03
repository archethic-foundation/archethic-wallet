// @dart=2.9

import 'package:json_annotation/json_annotation.dart';

part 'price_response.g.dart';

int _toInt(String v) => int.tryParse(v);

double _toDouble(v) {
  return double.tryParse(v.toString());
}

@JsonSerializable()
class PriceResponse {

  PriceResponse();
  
  factory PriceResponse.fromJson(Map<String, dynamic> json) =>
      _$PriceResponseFromJson(json);


  @JsonKey(name: 'currency')
  String currency;

  @JsonKey(name: 'price', fromJson: _toDouble)
  double price;

  @JsonKey(name: 'btc', fromJson: _toDouble)
  double btcPrice;

  Map<String, dynamic> toJson() => _$PriceResponseToJson(this);
}
