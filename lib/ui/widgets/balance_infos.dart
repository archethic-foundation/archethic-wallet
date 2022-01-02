// Flutter imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/styles.dart';

class BalanceInfosWidget {
  static Widget buildInfos(BuildContext context) {
    if (StateContainer.of(context).chartInfos != null &&
        StateContainer.of(context).chartInfos!.data != null) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.11,
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
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 0.0, top: 0.0, bottom: 0.0),
                  child: Text(
                    'UCO',
                    style: AppStyles.textStyleSize60W700Primary15(context),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
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
                  style: AppStyles.textStyleSize28W900Primary(context),
                  maxLines: 1,
                  stepGranularity: 0.1,
                  minFontSize: 1,
                  maxFontSize: 24,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(
                    right: 0.0, left: 10.0, top: 0.0, bottom: 0.0),
                child: StateContainer.of(context)
                            .chartInfos!
                            .priceChangePercentage24h! >=
                        0
                    ? Row(
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
                            style:
                                AppStyles.textStyleSize12W100Primary(context),
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
                            style: AppStyles.textStyleSize12W100PositiveValue(
                                context),
                          ),
                          FaIcon(FontAwesomeIcons.caretUp,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .positiveValue),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '(1d)',
                            style:
                                AppStyles.textStyleSize12W100Primary(context),
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
                            style:
                                AppStyles.textStyleSize12W100Primary(context),
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
                            style: AppStyles.textStyleSize12W100NegativeValue(
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
                            style:
                                AppStyles.textStyleSize12W100Primary(context),
                          ),
                        ],
                      ),
              ),
            ],
          ));
    } else {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.11,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 0.0, top: 0.0, bottom: 0.0),
                  child: Text(
                    'UCO',
                    style: AppStyles.textStyleSize60W700Primary15(context),
                  ),
                ),
              ),
            ],
          ));
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
