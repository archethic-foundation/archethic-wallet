// Package imports:

// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_mobile_wallet/model/chart_infos.dart';

class ChartEvent implements Event {
  ChartEvent({this.chartInfos});

  final ChartInfos? chartInfos;
}
