/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:event_taxi/event_taxi.dart';

enum AUTH_EVENT_TYPE { send, changeManual, change }

class AuthenticatedEvent implements Event {
  AuthenticatedEvent(this.authType);

  final AUTH_EVENT_TYPE authType;
}
