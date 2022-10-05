/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/chart_infos.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/balance/balance_infos.dart';
import 'package:aewallet/ui/widgets/components/history_chart.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
// Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ChartSheet extends StatefulWidget {
  const ChartSheet({
    super.key,
    required this.optionChartList,
    required this.optionChart,
  });

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
    final theme = StateContainer.of(context).curTheme;

    return Column(
      children: <Widget>[
        SheetHeader(
          title: AppLocalization.of(context)!.chart,
        ),
        FadeIn(
          duration: const Duration(milliseconds: 1000),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            padding: const EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: StateContainer.of(context).chartInfos != null &&
                      StateContainer.of(context).chartInfos!.data != null
                  ? HistoryChart(
                      intervals: StateContainer.of(context).chartInfos!.data!,
                      gradientColors: LinearGradient(
                        colors: <Color>[
                          theme.text20!,
                          theme.text!,
                        ],
                      ),
                      gradientColorsBar: LinearGradient(
                        colors: <Color>[
                          theme.text!.withOpacity(0.9),
                          theme.text!.withOpacity(0),
                        ],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                      ),
                      tooltipBg: theme.backgroundDark!,
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
        Wrap(
          children: [
            BottomBar(
              selectedIndex: bottomBarCurrentPage,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 500),
              itemPadding: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(right: 10, left: 10),
              onTap: (int index) async {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      StateContainer.of(context).activeVibrations,
                    );
                await StateContainer.of(context).chartInfos!.updateCoinsChart(
                      StateContainer.of(context).curCurrency.currency.name,
                      option: widget.optionChartList[index].id,
                    );

                setState(() {
                  optionChartSelected = widget.optionChartList[index];
                  StateContainer.of(context).idChartOption =
                      widget.optionChartList[index].id;

                  bottomBarCurrentPage = index;
                });
                await StateContainer.of(context).requestUpdate();
              },
              items: widget.optionChartList.map((OptionChart optionChart) {
                return BottomBarItem(
                  icon: Text(
                    ChartInfos.getChartOptionLabel(context, optionChart.id),
                    style: AppStyles.textStyleSize12W100Primary(context),
                  ),
                  backgroundColorOpacity:
                      theme.bottomBarBackgroundColorOpacity!,
                  activeIconColor: theme.bottomBarActiveIconColor,
                  activeTitleColor: theme.bottomBarActiveTitleColor,
                  activeColor: theme.bottomBarActiveColor!,
                  inactiveColor: theme.bottomBarInactiveIcon,
                );
              }).toList(),
            ),
          ],
        ),
        if (StateContainer.of(context).chartInfos != null)
          const BalanceInfosKpi()
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
