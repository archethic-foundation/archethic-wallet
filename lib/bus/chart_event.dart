import 'package:event_taxi/event_taxi.dart';
import 'package:uniris_mobile_wallet/model/chart_infos.dart';

class ChartEvent implements Event {
  ChartEvent({this.chartInfos});

  final ChartInfos? chartInfos;
}
