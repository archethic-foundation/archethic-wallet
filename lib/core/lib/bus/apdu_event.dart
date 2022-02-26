// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:event_taxi/event_taxi.dart';

class APDUReceiveEvent implements Event {
  APDUReceiveEvent({this.apdu});

  final Uint8List? apdu;
}
