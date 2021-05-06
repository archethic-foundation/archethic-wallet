import 'package:event_taxi/event_taxi.dart';

class TransactionsListEvent implements Event {

  final List? response;

  TransactionsListEvent({this.response});
}