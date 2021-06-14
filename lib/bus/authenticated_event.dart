// Package imports:
import 'package:event_taxi/event_taxi.dart';

enum AUTH_EVENT_TYPE { SEND, CHANGE_MANUAL, CHANGE }

class AuthenticatedEvent implements Event {
  AuthenticatedEvent(this.authType);

  final AUTH_EVENT_TYPE authType;
}
