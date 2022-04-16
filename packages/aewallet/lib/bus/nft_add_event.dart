/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:event_taxi/event_taxi.dart';

class NFTAddEvent implements Event {
  NFTAddEvent({this.response});

  final String? response;
}
