// Flutter imports:
import 'package:archethic_wallet/ui/widgets/icon_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/styles.dart';

class ChartSheet extends StatefulWidget {
  const ChartSheet({required this.optionChartList, required this.optionChart})
      : super();

  final List<OptionChart> optionChartList;
  final OptionChart? optionChart;
  @override
  _ChartSheetState createState() => _ChartSheetState();
}

class _ChartSheetState extends State<ChartSheet> {
  OptionChart? optionChartSelected;

  @override
  void initState() {
    optionChartSelected = widget.optionChart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // A row for the address text and close button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Empty SizedBox
            const SizedBox(
              width: 60,
              height: 40,
            ),
            Column(
              children: <Widget>[
                // Sheet handle
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.primary10,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ],
            ),
            if (kIsWeb)
              Stack(
                children: <Widget>[
                  const SizedBox(
                    width: 60,
                    height: 40,
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 10, right: 0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: <Widget>[
                              buildIconDataWidget(
                                  context, Icons.close_outlined, 30, 30),
                            ],
                          ))),
                ],
              )
            else
              const SizedBox(
                width: 60,
                height: 40,
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 10.0, right: 10.0),
              child: AutoSizeText(
                AppLocalization.of(context)!.chart,
                style: AppStyles.textStyleSize24W700Primary(context),
              ),
            ),
          ],
        ),

        FadeIn(
          duration: const Duration(milliseconds: 1000),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 0.0, left: 0.0, right: 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 5.0, left: 5.0, top: 0.0, bottom: 0.0),
              child: StateContainer.of(context).chartInfos != null
                  ? LineChart(
                      mainData(context),
                      swapAnimationCurve: Curves.decelerate,
                      swapAnimationDuration: const Duration(milliseconds: 1000),
                    )
                  : const SizedBox(),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        if (StateContainer.of(context).chartInfos != null)
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: StateContainer.of(context)
                        .chartInfos!
                        .getPriceChangePercentage(
                            StateContainer.of(context).idChartOption!)! >=
                    0
                ? FadeIn(
                    duration: const Duration(milliseconds: 1000),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AutoSizeText(
                          StateContainer.of(context)
                                      .wallet!
                                      .accountBalance
                                      .uco ==
                                  0
                              ? '1 UCO = ' +
                                  StateContainer.of(context)
                                      .localWallet!
                                      .getLocalPrice(
                                          StateContainer.of(context)
                                              .curCurrency,
                                          locale: StateContainer.of(context)
                                              .currencyLocale!)
                              : '1 UCO = ' +
                                  StateContainer.of(context)
                                      .wallet!
                                      .getLocalPrice(
                                          StateContainer.of(context)
                                              .curCurrency,
                                          locale: StateContainer.of(context)
                                              .currencyLocale!),
                          style: AppStyles.textStyleSize16W700Primary(context),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        AutoSizeText(
                          StateContainer.of(context)
                                  .chartInfos!
                                  .getPriceChangePercentage(
                                      StateContainer.of(context)
                                          .idChartOption!)!
                                  .toStringAsFixed(2) +
                              '%',
                          style: AppStyles.textStyleSize16W100PositiveValue(
                              context),
                        ),
                        const SizedBox(width: 5),
                        FaIcon(FontAwesomeIcons.caretUp,
                            color: StateContainer.of(context)
                                .curTheme
                                .positiveValue),
                      ],
                    ),
                  )
                : FadeIn(
                    duration: const Duration(milliseconds: 1000),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AutoSizeText(
                          StateContainer.of(context)
                                      .wallet!
                                      .accountBalance
                                      .uco ==
                                  0
                              ? '1 UCO = ' +
                                  StateContainer.of(context)
                                      .localWallet!
                                      .getLocalPrice(
                                          StateContainer.of(context)
                                              .curCurrency,
                                          locale: StateContainer.of(context)
                                              .currencyLocale!)
                              : '1 UCO = ' +
                                  StateContainer.of(context)
                                      .wallet!
                                      .getLocalPrice(
                                          StateContainer.of(context)
                                              .curCurrency,
                                          locale: StateContainer.of(context)
                                              .currencyLocale!),
                          style: AppStyles.textStyleSize16W700Primary(context),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        AutoSizeText(
                          StateContainer.of(context)
                                  .chartInfos!
                                  .getPriceChangePercentage(
                                      StateContainer.of(context)
                                          .idChartOption!)!
                                  .toStringAsFixed(2) +
                              '%',
                          style: AppStyles.textStyleSize16W100NegativeValue(
                              context),
                        ),
                        const SizedBox(width: 5),
                        FaIcon(FontAwesomeIcons.caretDown,
                            color: StateContainer.of(context)
                                .curTheme
                                .negativeValue),
                      ],
                    ),
                  ),
          )
        else
          const SizedBox(),

        Expanded(
          child: Center(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: SafeArea(
                  minimum: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.035,
                    top: 50,
                  ),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        data: Theme.of(context).copyWith(
                            canvasColor: StateContainer.of(context)
                                .curTheme
                                .backgroundDarkest),
                        child: DropdownButton<OptionChart>(
                          elevation: 2,
                          focusColor: Colors.white,
                          isExpanded: false,
                          value: optionChartSelected,
                          style: TextStyle(
                            color: StateContainer.of(context).curTheme.primary,
                          ),
                          underline: const SizedBox(),
                          iconEnabledColor: StateContainer.of(context)
                              .curTheme
                              .backgroundDarkest!,
                          isDense: true,
                          items: widget.optionChartList
                              .map((OptionChart optionChart) {
                            return DropdownMenuItem<OptionChart>(
                              value: optionChart,
                              child: Container(
                                child: Text(
                                  optionChart.label,
                                  style: AppStyles.textStyleSize20W700Primary(
                                      context),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (OptionChart? optionChart) async {
                            await StateContainer.of(context)
                                .requestUpdateCoinsChart(
                                    option: optionChart!.id);
                            setState(() {
                              optionChartSelected = optionChart;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(BuildContext context) {
    final List<Color> gradientColors = <Color>[
      StateContainer.of(context).curTheme.backgroundDarkest!,
      StateContainer.of(context).curTheme.backgroundDarkest!,
    ];
    final List<Color> gradientColorsBar = <Color>[
      StateContainer.of(context).curTheme.backgroundDarkest!.withOpacity(0.9),
      StateContainer.of(context).curTheme.backgroundDarkest!.withOpacity(0.0),
    ];

    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(
            showTitles: false,
          ),
          topTitles: SideTitles(showTitles: false),
          leftTitles: SideTitles(
            showTitles: false,
          )),
      borderData: FlBorderData(
        show: false,
      ),
      minX: StateContainer.of(context).chartInfos!.minX,
      maxX: StateContainer.of(context).chartInfos!.maxX,
      minY: StateContainer.of(context).chartInfos!.minY,
      maxY: StateContainer.of(context).chartInfos!.maxY,
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding: const EdgeInsets.all(8),
          tooltipBgColor: const Color(0xff2e3747).withOpacity(0.8),
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              return LineTooltipItem(
                '${touchedSpot.y}',
                const TextStyle(color: Colors.white, fontSize: 12.0),
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
        enabled: true,
      ),
      lineBarsData: <LineChartBarData>[
        LineChartBarData(
          spots: StateContainer.of(context).chartInfos!.data,
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradientFrom: const Offset(0, 0),
            gradientTo: const Offset(0, 1),
            colors: gradientColorsBar,
          ),
        ),
      ],
    );
  }
}

class OptionChart {
  const OptionChart(this.id, this.label);

  final String label;
  final String id;
}
