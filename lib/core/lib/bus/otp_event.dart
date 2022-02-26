// Package imports:
import 'package:event_taxi/event_taxi.dart';

class OTPReceiveEvent implements Event {
  OTPReceiveEvent({this.otp});

  final String? otp;
}
