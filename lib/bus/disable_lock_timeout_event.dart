import 'package:event_taxi/event_taxi.dart';

class DisableLockTimeoutEvent implements Event {
  DisableLockTimeoutEvent({this.disable});

  final bool? disable;
}
