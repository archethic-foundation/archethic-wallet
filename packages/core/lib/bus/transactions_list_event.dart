/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:core/model/recent_transaction.dart';
import 'package:event_taxi/event_taxi.dart';

class TransactionsListEvent implements Event {
  TransactionsListEvent({this.transaction});

  final List<RecentTransaction>? transaction;
}
