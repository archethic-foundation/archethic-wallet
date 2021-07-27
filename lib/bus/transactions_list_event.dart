// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show Transaction;
import 'package:event_taxi/event_taxi.dart';

class TransactionsListEvent implements Event {
  TransactionsListEvent({this.transaction});

  final List<Transaction>? transaction;
}
