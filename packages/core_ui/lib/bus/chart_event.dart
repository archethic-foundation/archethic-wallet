// Package imports:

// Package imports:
import 'package:core_ui/model/chart_infos.dart';
import 'package:event_taxi/event_taxi.dart';

// Project imports:

class ChartEvent implements Event {
  ChartEvent({this.chartInfos});

  final ChartInfos? chartInfos;
}
