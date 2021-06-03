import 'package:event_taxi/event_taxi.dart';

class TransactionsListEvent implements Event {
  TransactionsListEvent({this.response});

  final List<TransactionsListEvent>? response;
}
