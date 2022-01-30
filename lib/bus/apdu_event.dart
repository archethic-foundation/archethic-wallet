// Package imports:
import 'package:event_taxi/event_taxi.dart';

class APDUReceiveEvent implements Event {
  APDUReceiveEvent({this.apdu});

  final String? apdu;
}
