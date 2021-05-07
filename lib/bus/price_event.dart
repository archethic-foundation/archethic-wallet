import 'package:event_taxi/event_taxi.dart';
import 'package:uniris_lib_dart/model/response/simple_price_response.dart';

class PriceEvent implements Event {
  final SimplePriceResponse? response;

  PriceEvent({this.response});
}
