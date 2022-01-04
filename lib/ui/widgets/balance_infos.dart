// Flutter imports:
import 'package:archethic_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/tx_all_list.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/styles.dart';

class BalanceInfosWidget {
  static Widget buildInfos(BuildContext context) {
    if (StateContainer.of(context).chartInfos != null &&
        StateContainer.of(context).chartInfos!.data != null) {
      return InkWell(
        onTap: () {
          Sheets.showAppHeightNineSheet(
              context: context, widget: TxAllListWidget());
        },
        child: Ink(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Stack(
              children: <Widget>[
                Container(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 0.0, top: 0.0, bottom: 0.0),
                      child: LineChart(
                        mainData(context),
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0, left: 0.0, top: 0.0, bottom: 0.0),
                    child: AutoSizeText(
                      'UCO',
                      style: AppStyles.textStyleSize80W700Primary15(context),
                    ),
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 0.0, left: 10.0, top: 0.0, bottom: 0.0),
                    child: StateContainer.of(context)
                                .chartInfos!
                                .priceChangePercentage24h! >=
                            0
                        ? Row(
                            children: <Widget>[
                              AutoSizeText(
                                  StateContainer.of(context)
                                      .wallet!
                                      .getLocalCurrencyPrice(
                                          StateContainer.of(context)
                                              .curCurrency,
                                          locale: StateContainer.of(context)
                                              .currencyLocale!),
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyleSize12W100Primary(
                                      context)),
                              const SizedBox(
                                width: 10,
                              ),
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
                                                locale:
                                                    StateContainer.of(context)
                                                        .currencyLocale!)
                                    : '1 UCO = ' +
                                        StateContainer.of(context)
                                            .wallet!
                                            .getLocalPrice(
                                                StateContainer.of(context)
                                                    .curCurrency,
                                                locale:
                                                    StateContainer.of(context)
                                                        .currencyLocale!),
                                style: AppStyles.textStyleSize12W100Primary(
                                    context),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              AutoSizeText(
                                StateContainer.of(context)
                                        .chartInfos!
                                        .priceChangePercentage24h!
                                        .toStringAsFixed(2) +
                                    '%',
                                style:
                                    AppStyles.textStyleSize12W100PositiveValue(
                                        context),
                              ),
                              FaIcon(FontAwesomeIcons.caretUp,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .positiveValue),
                              const SizedBox(
                                width: 10,
                              ),
                              AutoSizeText(
                                '(1d)',
                                style: AppStyles.textStyleSize12W100Primary(
                                    context),
                              ),
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Text(
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
                                                locale:
                                                    StateContainer.of(context)
                                                        .currencyLocale!)
                                    : '1 UCO = ' +
                                        StateContainer.of(context)
                                            .wallet!
                                            .getLocalPrice(
                                                StateContainer.of(context)
                                                    .curCurrency,
                                                locale:
                                                    StateContainer.of(context)
                                                        .currencyLocale!),
                                style: AppStyles.textStyleSize12W100Primary(
                                    context),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                StateContainer.of(context)
                                        .chartInfos!
                                        .priceChangePercentage24h!
                                        .toStringAsFixed(2) +
                                    '%',
                                style:
                                    AppStyles.textStyleSize12W100NegativeValue(
                                        context),
                              ),
                              FaIcon(FontAwesomeIcons.caretDown,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .negativeValue),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '(1d)',
                                style: AppStyles.textStyleSize12W100Primary(
                                    context),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 10.0, left: 0.0, top: 0.0, bottom: 0.0),
              child: AutoSizeText(
                'UCO',
                style: AppStyles.textStyleSize80W700Primary15(context),
              ),
            ),
          ),
        ],
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
