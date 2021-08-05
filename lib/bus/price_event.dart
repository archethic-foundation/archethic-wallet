// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show SimplePriceResponse;

// Package imports:
import 'package:event_taxi/event_taxi.dart';

class PriceEvent implements Event {
  PriceEvent({this.response});

  final SimplePriceResponse? response;
}
