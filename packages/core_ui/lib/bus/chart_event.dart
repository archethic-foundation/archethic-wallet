/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:core_ui/model/chart_infos.dart';
import 'package:event_taxi/event_taxi.dart';

class ChartEvent implements Event {
  ChartEvent({this.chartInfos});

  final ChartInfos? chartInfos;
}
