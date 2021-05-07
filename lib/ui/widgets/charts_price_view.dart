// @dart=2.9
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as charts_common;
import 'package:uniris_lib_dart/model/response/coins_price_response.dart';
import 'package:uniris_lib_dart/services/api_coins_service.dart';
import 'package:uniris_mobile_wallet/model/available_currency.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';

class ChartsPriceView extends StatefulWidget {
  final AvailableCurrency localCurrency;
  final int nbDays;

  const ChartsPriceView({Key key, this.localCurrency, this.nbDays})
      : super(key: key);

  @override
  _ChartsPriceViewState createState() => _ChartsPriceViewState();
}

class _ChartsPriceViewState extends State<ChartsPriceView> {
  List<charts.Series<Price, DateTime>> _seriesLineData = [];
  List<Price> chartDataList = [];
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
                  charts.Series<Price, DateTime>(
                    colorFn: (__, _) =>
                        charts.ColorUtil.fromDartColor(Color(0xff990099)),
                    id: 'Price',
                    data: chartDataList,
                    domainFn: (Price price, _) => price.dateVal,
                    measureFn: (Price price, _) => price.priceVal,
                  ),
                );

                nbDaysSave = widget.nbDays;

                lineChart = charts.TimeSeriesChart(_seriesLineData,
                    primaryMeasureAxis: new charts.NumericAxisSpec(
                      tickProviderSpec:
                          new charts.StaticNumericTickProviderSpec(
                        <charts.TickSpec<num>>[
                          charts.TickSpec<num>(Config.min),
                          charts.TickSpec<num>(
                              Config.min + ((Config.max - Config.min) / 4)),
                          charts.TickSpec<num>(
                              Config.min + ((Config.max - Config.min) / 4) * 2),
                          charts.TickSpec<num>(
                              Config.min + ((Config.max - Config.min) / 4) * 3),
                          charts.TickSpec<num>(Config.max),
                        ],
                      ),
                    ),
                    defaultRenderer: new charts.LineRendererConfig(
                        includeArea: true, stacked: true),
                    animate: false,
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                    behaviors: [
                      new charts.ChartTitle("",
                          titleStyleSpec: charts_common.TextStyleSpec(
                            fontSize: 12,
                          ),
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      new charts.ChartTitle("",
                          titleStyleSpec: charts_common.TextStyleSpec(
                            fontSize: 12,
                          ),
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                    ]);
              }));

    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 185,
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.0750,
        right: MediaQuery.of(context).size.width * 0.0750,
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(child: lineChart),
          ],
        ),
      ),
    );
  }
}

class Price {
  DateTime dateVal;
  double priceVal;

  Price(this.dateVal, this.priceVal);
}

class Config {
  static List<Price> _chartDataList = [];
  static bool _loaded = false;
  static double min = 10;
  static double max = 0;

  static isLoaded() {
    return _loaded;
  }

  static reinit() {
    _loaded = false;
    _chartDataList = [];
    min = 10;
    max = 0;
  }

  static loadChartDataList(String iso4217Code, int nbDays) async {
    CoinsPriceResponse coinsPriceResponse =
        await sl.get<ApiCoinsService>().getCoinsChart(iso4217Code, nbDays);

    for (int i = 0; i < coinsPriceResponse.prices.length; i++) {
      if (min > coinsPriceResponse.prices[i][1].toDouble()) {
        min = coinsPriceResponse.prices[i][1].toDouble();
      }
      if (max < coinsPriceResponse.prices[i][1].toDouble()) {
        max = coinsPriceResponse.prices[i][1].toDouble();
      }
      Price price = new Price(
          DateTime.fromMillisecondsSinceEpoch(
              coinsPriceResponse.prices[i][0].toInt()),
          coinsPriceResponse.prices[i][1].toDouble());
      _chartDataList.add(price);
    }

    _loaded = true;
  }

  static getChartDataList(String iso4217Code, int nbDays) {
    if (!_loaded) loadChartDataList(iso4217Code, nbDays);
    return _chartDataList;
  }
}
