/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/balance_infos.dart';
import 'package:aewallet/ui/widgets/components/history_chart.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';

class ChartSheet extends StatefulWidget {
  const ChartSheet(
      {super.key, required this.optionChartList, required this.optionChart});

  final List<OptionChart> optionChartList;
  final OptionChart? optionChart;
  @override
  State<ChartSheet> createState() => _ChartSheetState();
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
                    color: StateContainer.of(context).curTheme.text10,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ],
            ),

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
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: AutoSizeText(
                AppLocalization.of(context)!.chart,
                style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
              ),
            ),
          ],
        ),
        FadeIn(
          duration: const Duration(milliseconds: 1000),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            padding: const EdgeInsets.only(top: 20.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0, left: 5.0),
              child: StateContainer.of(context).chartInfos != null
                  ? HistoryChart(
                      intervals: StateContainer.of(context).chartInfos!.data!,
                      gradientColors: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.text20!,
                          StateContainer.of(context).curTheme.text!,
                        ],
                      ),
                      gradientColorsBar: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context)
                              .curTheme
                              .text!
                              .withOpacity(0.9),
                          StateContainer.of(context)
                              .curTheme
                              .text!
                              .withOpacity(0.0),
                        ],
                        begin: const Alignment(0.0, 0.0),
                        end: const Alignment(0.0, 1.0),
                      ),
                      tooltipBg:
                          StateContainer.of(context).curTheme.backgroundDark!,
                      tooltipText:
                          AppStyles.textStyleSize12W100Primary(context),
                      optionChartSelected:
                          StateContainer.of(context).idChartOption!,
                      currency:
                          StateContainer.of(context).curCurrency.currency.name,
                      completeChart: true,
                    )
                  : const SizedBox(),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        if (StateContainer.of(context).chartInfos != null)
          BalanceInfosWidget().buildKPI(context)
        else
          const SizedBox(),
        Expanded(
          child: Center(
            child: SizedBox(
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
                                .backgroundDark),
                        child: DropdownButton<OptionChart>(
                          elevation: 2,
                          focusColor: Colors.white,
                          isExpanded: false,
                          value: optionChartSelected,
                          style: TextStyle(
                            color: StateContainer.of(context).curTheme.text,
                          ),
                          underline: const SizedBox(),
                          iconEnabledColor: StateContainer.of(context)
                              .curTheme
                              .backgroundDark!,
                          isDense: true,
                          items: widget.optionChartList
                              .map((OptionChart optionChart) {
                            return DropdownMenuItem<OptionChart>(
                              value: optionChart,
                              child: Text(
                                optionChart.label,
                                style: AppStyles.textStyleSize20W700Primary(
                                    context),
                              ),
                            );
                          }).toList(),
                          onChanged: (OptionChart? optionChart) async {
                            sl.get<HapticUtil>().feedback(FeedbackType.light,
                                StateContainer.of(context).activeVibrations);
                            await StateContainer.of(context)
                                .chartInfos!
                                .updateCoinsChart(
                                    StateContainer.of(context)
                                        .curCurrency
                                        .currency
                                        .name,
                                    option: optionChart!.id);

                            setState(() {
                              optionChartSelected = optionChart;
                              StateContainer.of(context).idChartOption =
                                  optionChart.id;
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
}

class OptionChart {
  const OptionChart(this.id, this.label);

  final String label;
  final String id;
}
