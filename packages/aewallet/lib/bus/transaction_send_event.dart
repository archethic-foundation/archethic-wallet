/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:event_taxi/event_taxi.dart';

class TransactionSendEvent implements Event {
  TransactionSendEvent({this.response});

  final String? response;
}
