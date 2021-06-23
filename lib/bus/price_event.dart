// Package imports:
import 'package:archethic_lib_dart/model/response/simple_price_response.dart';
import 'package:event_taxi/event_taxi.dart';

class PriceEvent implements Event {
  PriceEvent({this.response});

  final SimplePriceResponse? response;
}
