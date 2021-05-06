import 'package:event_taxi/event_taxi.dart';

class TransactionSendEvent implements Event {

  final String? response;

  TransactionSendEvent({this.response});
}