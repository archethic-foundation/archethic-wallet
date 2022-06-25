/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:event_taxi/event_taxi.dart';

class TokenAddEvent implements Event {
  TokenAddEvent({this.response});

  final String? response;
}
