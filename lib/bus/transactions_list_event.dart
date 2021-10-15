// Package imports:
import 'package:archethic_mobile_wallet/model/recent_transaction.dart';
import 'package:event_taxi/event_taxi.dart';

class TransactionsListEvent implements Event {
  TransactionsListEvent({this.transaction});

  final List<RecentTransaction>? transaction;
}
