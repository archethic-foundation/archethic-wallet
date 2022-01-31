// Package imports:
import 'dart:typed_data';

import 'package:event_taxi/event_taxi.dart';

class APDUReceiveEvent implements Event {
  APDUReceiveEvent({this.apdu, this.method});

  final Uint8List? apdu;
  final String? method;
}
