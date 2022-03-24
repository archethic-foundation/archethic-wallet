// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/views/transactions/transaction_all_list.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core_ui/model/chart_infos.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BalanceInfosWidget {
  Widget buildInfos(BuildContext context) {
    return InkWell(
      onTap: () {
        Sheets.showAppHeightNineSheet(
            context: context, widget: const TxAllListWidget());
      },
      child: Ink(
        child: FadeIn(
          duration: const Duration(milliseconds: 1000),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: Stack(
              children: <Widget>[
                FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 0.0, top: 0.0, bottom: 0.0),
                    child: StateContainer.of(context).chartInfos != null &&
                            StateContainer.of(context).chartInfos!.data != null
                        ? LineChart(
                            mainData(context),
                            swapAnimationCurve: Curves.easeInOutCubic,
                            swapAnimationDuration:
                                const Duration(milliseconds: 1000),
                          )
                        : const SizedBox(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 0.0, left: 10.0, top: 0.0, bottom: 0.0),
                    child: AutoSizeText(
                      StateContainer.of(context).wallet!.accountBalance.uco == 0
                          ? StateContainer.of(context)
                              .localWallet!
                              .getAccountBalanceUCODisplay()
                          : StateContainer.of(context)
                              .wallet!
                              .getAccountBalanceUCODisplay(),
                      style: AppStyles.textStyleSize40W900Primary(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKPI(BuildContext context) {
    if (StateContainer.of(context).chartInfos != null &&
        StateContainer.of(context).chartInfos!.data != null) {
      return FadeIn(
        duration: const Duration(milliseconds: 1000),
        child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 0.0, left: 10.0, top: 5.0, bottom: 0.0),
            child: StateContainer.of(context)
                        .chartInfos!
                        .getPriceChangePercentage(
                            StateContainer.of(context).idChartOption!)! >=
                    0
                ? Row(
                    children: <Widget>[
                      AutoSizeText(
                          StateContainer.of(context)
                              .wallet!
                              .getLocalCurrencyPrice(
                                  StateContainer.of(context).curCurrency,
                                  locale: StateContainer.of(context)
                                      .currencyLocale!),
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyleSize12W100Primary(context)),
                      const SizedBox(
                        width: 10,
                      ),
                      AutoSizeText(
                        StateContainer.of(context).wallet!.accountBalance.uco ==
                                0
                            ? '1 UCO = ' +
                                StateContainer.of(context)
                                    .localWallet!
                                    .getLocalPrice(
                                        StateContainer.of(context).curCurrency,
                                        locale: StateContainer.of(context)
                                            .currencyLocale!)
                            : '1 UCO = ' +
                                StateContainer.of(context)
                                    .wallet!
                                    .getLocalPrice(
                                        StateContainer.of(context).curCurrency,
                                        locale: StateContainer.of(context)
                                            .currencyLocale!),
                        style: AppStyles.textStyleSize12W100Primary(context),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AutoSizeText(
                        StateContainer.of(context)
                                .chartInfos!
                                .getPriceChangePercentage(
                                    StateContainer.of(context).idChartOption!)!
                                .toStringAsFixed(2) +
                            '%',
                        style:
                            AppStyles.textStyleSize12W100PositiveValue(context),
                      ),
                      const SizedBox(width: 5),
                      FaIcon(FontAwesomeIcons.caretUp,
                          color: StateContainer.of(context)
                              .curTheme
                              .positiveValue),
                      const SizedBox(
                        width: 10,
                      ),
                      AutoSizeText(
                        ChartInfos.getChartOptionLabel(
                            context, StateContainer.of(context).idChartOption!),
                        style: AppStyles.textStyleSize12W100Primary(context),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      StateContainer.of(context).useOracleUcoPrice
                          ? InkWell(
                              onTap: () {
                                AppDialogs.showInfoDialog(
                                  context,
                                  AppLocalization.of(context)!.informations,
                                  AppLocalization.of(context)!
                                      .currencyOracleInfo,
                                );
                              },
                              child: buildIconWidget(
                                context,
                                'packages/aewallet/assets/icons/oracle.png',
                                15,
                                15,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  )
                : Row(
                    children: <Widget>[
                      Text(
                        StateContainer.of(context).wallet!.accountBalance.uco ==
                                0
                            ? '1 UCO = ' +
                                StateContainer.of(context)
                                    .localWallet!
                                    .getLocalPrice(
                                        StateContainer.of(context).curCurrency,
                                        locale: StateContainer.of(context)
                                            .currencyLocale!)
                            : '1 UCO = ' +
                                StateContainer.of(context)
                                    .wallet!
                                    .getLocalPrice(
                                        StateContainer.of(context).curCurrency,
                                        locale: StateContainer.of(context)
                                            .currencyLocale!),
                        style: AppStyles.textStyleSize12W100Primary(context),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        StateContainer.of(context)
                                .chartInfos!
                                .getPriceChangePercentage(
                                    StateContainer.of(context).idChartOption!)!
                                .toStringAsFixed(2) +
                            '%',
                        style:
                            AppStyles.textStyleSize12W100NegativeValue(context),
                      ),
                      const SizedBox(width: 5),
                      FaIcon(FontAwesomeIcons.caretDown,
                          color: StateContainer.of(context)
                              .curTheme
                              .negativeValue),
                      const SizedBox(
                        width: 10,
                      ),
                      AutoSizeText(
                        ChartInfos.getChartOptionLabel(
                            context, StateContainer.of(context).idChartOption!),
                        style: AppStyles.textStyleSize12W100Primary(context),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      StateContainer.of(context).useOracleUcoPrice
                          ? InkWell(
                              onTap: () {
                                AppDialogs.showInfoDialog(
                                  context,
                                  AppLocalization.of(context)!.informations,
                                  AppLocalization.of(context)!
                                      .currencyOracleInfo,
                                );
                              },
                              child: buildIconWidget(
                                context,
                                'packages/aewallet/assets/icons/oracle.png',
                                15,
                                15,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 30,
      );
    }
  }

  static LineChartData mainData(BuildContext context) {
    final List<Color> gradientColors = <Color>[
      StateContainer.of(context).curTheme.backgroundDark!,
      StateContainer.of(context).curTheme.backgroundDarkest!,
    ];
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: false,
        bottomTitles: SideTitles(showTitles: false),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
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
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }
}
