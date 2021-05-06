import 'package:event_taxi/event_taxi.dart';

class AliasListEvent implements Event {

  final List? response;

  AliasListEvent({this.response});
}