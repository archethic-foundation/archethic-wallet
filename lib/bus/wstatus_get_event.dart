import 'package:event_taxi/event_taxi.dart';
import 'package:uniris_mobile_wallet/network/model/response/wstatusget_response.dart';

class WStatusGetEvent implements Event {
  final WStatusGetResponse? response;

  WStatusGetEvent({this.response});
}