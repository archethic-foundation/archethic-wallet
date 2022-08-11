/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:event_taxi/event_taxi.dart';

class NotificationsEvent implements Event {
  NotificationsEvent({this.payload});

  final String? payload;
}
