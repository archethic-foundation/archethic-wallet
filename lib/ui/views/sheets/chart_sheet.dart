/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/chart_infos.dart';
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

  int bottomBarCurrentPage = 0;
  @override
  void initState() {
    optionChartSelected = widget.optionChart;
    switch (optionChartSelected!.id) {
      case '1h':
        bottomBarCurrentPage = 0;
        break;
      case '24h':
        bottomBarCurrentPage = 1;
        break;
      case '7d':
        bottomBarCurrentPage = 2;
        break;
      case '14d':
        bottomBarCurrentPage = 3;
        break;
      case '30d':
        bottomBarCurrentPage = 4;
        break;
      case '60d':
        bottomBarCurrentPage = 5;
        break;
      case '200d':
        bottomBarCurrentPage = 6;
        break;
      case '1y':
        bottomBarCurrentPage = 7;
        break;
      case 'all':
        bottomBarCurrentPage = 8;
        break;
      default:
        bottomBarCurrentPage = 0;
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SheetHeader(
          title: AppLocalization.of(context)!.chart,
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
                      axisTextStyle:
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
        Wrap(children: [
          BottomBar(
              selectedIndex: bottomBarCurrentPage,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 500),
              itemPadding: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(right: 10, left: 10),
              onTap: (int index) async {
                sl.get<HapticUtil>().feedback(FeedbackType.light,
                    StateContainer.of(context).activeVibrations);
                await StateContainer.of(context).chartInfos!.updateCoinsChart(
                    StateContainer.of(context).curCurrency.currency.name,
                    option: widget.optionChartList[index].id);

                setState(() {
                  optionChartSelected = widget.optionChartList[index];
                  StateContainer.of(context).idChartOption =
                      widget.optionChartList[index].id;

                  bottomBarCurrentPage = index;
                });
                await StateContainer.of(context)
                    .requestUpdate(forceUpdateChart: true);
              },
              items: widget.optionChartList.map((OptionChart optionChart) {
                return BottomBarItem(
                    icon: Text(
                      ChartInfos.getChartOptionLabel(context, optionChart.id),
                      style: AppStyles.textStyleSize12W100Primary(context),
                    ),
                    backgroundColorOpacity: StateContainer.of(context)
                        .curTheme
                        .bottomBarBackgroundColorOpacity!,
                    activeIconColor: StateContainer.of(context)
                        .curTheme
                        .bottomBarActiveIconColor!,
                    activeTitleColor: StateContainer.of(context)
                        .curTheme
                        .bottomBarActiveTitleColor!,
                    activeColor: StateContainer.of(context)
                        .curTheme
                        .bottomBarActiveColor!,
                    inactiveColor: StateContainer.of(context)
                        .curTheme
                        .bottomBarInactiveIcon!);
              }).toList()),
        ]),
        if (StateContainer.of(context).chartInfos != null)
          BalanceInfosWidget().buildKPI(context)
        else
          const SizedBox(),
      ],
    );
  }
}

class OptionChart {
  const OptionChart(this.id, this.label);

  final String label;
  final String id;
}
