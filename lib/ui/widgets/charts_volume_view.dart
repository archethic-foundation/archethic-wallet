// @dart=2.9
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as charts_common;
import 'package:uniris_mobile_wallet/model/available_currency.dart';
import 'package:uniris_mobile_wallet/network/model/response/coins_price_response.dart';
import 'package:uniris_mobile_wallet/service/api_coins_service.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';

class ChartsVolumeView extends StatefulWidget {
  final AvailableCurrency localCurrency;
  final int nbDays;

  const ChartsVolumeView({Key key, this.localCurrency, this.nbDays})
      : super(key: key);

  @override
  _ChartsVolumeViewState createState() => _ChartsVolumeViewState();
}

class _ChartsVolumeViewState extends State<ChartsVolumeView> {
  List<charts.Series<Volume, DateTime>> _seriesLineData = [];
  List<Volume> chartDataList = [];
  Widget lineChart = Center(child: CircularProgressIndicator());
  int nbDaysSave;

  void initState() {
    super.initState();
    nbDaysSave = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (nbDaysSave != widget.nbDays) {
      chartDataList = [];
      _seriesLineData = [];
      Config.reinit();
      lineChart = Center(child: CircularProgressIndicator());
    }
    if (!Config.isLoaded())
      Config.loadChartDataList(
              widget.localCurrency.getIso4217Code(), widget.nbDays)
          .then((value) => setState(() {
                chartDataList = Config.getChartDataList(
                    widget.localCurrency.getIso4217Code(), widget.nbDays);

                _seriesLineData.add(
                  charts.Series<Volume, DateTime>(
                    colorFn: (__, _) =>
                        charts.ColorUtil.fromDartColor(Color(0xff5D7F99)),
                    id: 'Volume',
                    data: chartDataList,
                    domainFn: (Volume volume, _) => volume.date,
                    measureFn: (Volume volume, _) => volume.value,
                  ),
                );

                nbDaysSave = widget.nbDays;
                
                lineChart = charts.TimeSeriesChart(_seriesLineData,
                    primaryMeasureAxis: new charts.NumericAxisSpec(
                      tickProviderSpec:
                          new charts.StaticNumericTickProviderSpec(
                        <charts.TickSpec<num>>[
                          charts.TickSpec<num>(0),
                          charts.TickSpec<num>((Config.max ~/ 2).toInt()),
                          charts.TickSpec<num>(Config.max.toInt()),
                        ],
                      ),
                    ),
                    defaultRenderer: new charts.BarRendererConfig(),
                    defaultInteractions: false,
                    animate: false,
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                    behaviors: [
                      new charts.SelectNearest(),
                      new charts.DomainHighlighter(),
                      new charts.ChartTitle(
                          "",
                          titleStyleSpec: charts_common.TextStyleSpec(
                            fontSize: 12,
                          ),
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      new charts.ChartTitle(
                          "",
                          titleStyleSpec: charts_common.TextStyleSpec(
                            fontSize: 12,
                          ),
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.end),
                    ]);
              }));

    return Container(
        height: 200,
        width: double.infinity,
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.0750,
          right: MediaQuery.of(context).size.width * 0.0750,
        ),
        child: Center(
            child: Column(children: <Widget>[Expanded(child: lineChart)])));
  }
}

class Volume {
  DateTime date;
  double value;

  Volume(this.date, this.value);
}

class Config {
  static List<Volume> _chartDataList = [];
  static bool _loaded = false;
  static double min = 10000000;
  static double max = 0;

  static isLoaded() {
    return _loaded;
  }

  static reinit() {
    _loaded = false;
    _chartDataList = [];
    min = 10000000;
    max = 0;
  }

  static loadChartDataList(String iso4217Code, int nbDays) async {
    CoinsPriceResponse coinsPriceResponse =
        await sl.get<ApiCoinsService>().getCoinsChart(iso4217Code, nbDays);

    for (int i = 0; i < coinsPriceResponse.totalVolumes.length; i++) {
      if (min > coinsPriceResponse.totalVolumes[i][1].toDouble()) {
        min = coinsPriceResponse.totalVolumes[i][1].toDouble();
      }
      if (max < coinsPriceResponse.totalVolumes[i][1].toDouble()) {
        max = coinsPriceResponse.totalVolumes[i][1].toDouble();
      }
      Volume volume = new Volume(
          DateTime.fromMillisecondsSinceEpoch(
              coinsPriceResponse.totalVolumes[i][0].toInt()),
          coinsPriceResponse.totalVolumes[i][1].toDouble());
      _chartDataList.add(volume);
    }

    _loaded = true;
  }

  static getChartDataList(String iso4217Code, int nbDays) {
    if (!_loaded) loadChartDataList(iso4217Code, nbDays);
    return _chartDataList;
  }
}
