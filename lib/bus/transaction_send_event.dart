import 'package:event_taxi/event_taxi.dart';

class TransactionSendEvent implements Event {
  TransactionSendEvent({this.response});

  final String? response;
}
