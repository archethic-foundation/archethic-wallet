// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:uniris_mobile_wallet/network/model/response/error_response.dart';

class ErrorEvent implements Event {
  ErrorEvent({this.response});

  final ErrorResponse? response;
}
