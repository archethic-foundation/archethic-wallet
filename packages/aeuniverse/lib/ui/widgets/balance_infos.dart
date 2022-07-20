/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aewallet/ui/views/sheets/chart_sheet.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/primary_currency.dart';
import 'package:core/util/currency_util.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core_ui/model/chart_infos.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/history_chart.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';

class BalanceInfosWidget {
  List<OptionChart> optionChartList = List<OptionChart>.empty(growable: true);

  Widget getBalance(BuildContext context) {
    return Container(
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Card(
          color: Colors.transparent,
          child: Container(
            decoration:
                StateContainer.of(context).curTheme.getDecorationBalance(),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: StateContainer.of(context)
                            .curPrimaryCurrency
                            .primaryCurrency
                            .name ==
                        PrimaryCurrencySetting(AvailablePrimaryCurrency.NATIVE)
                            .primaryCurrency
                            .name
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: AutoSizeText(
                              StateContainer.of(context)
                                  .curNetwork
                                  .getNetworkCryptoCurrencyLabel(),
                              style:
                                  AppStyles.textStyleSize35W900EquinoxPrimary(
                                      context),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AutoSizeText(
                                StateContainer.of(context)
                                    .appWallet!
                                    .appKeychain!
                                    .getAccountSelected()!
                                    .balance!
                                    .nativeTokenValueToString(),
                                style:
                                    AppStyles.textStyleSize25W900EquinoxPrimary(
                                        context),
                              ),
                              AutoSizeText(
                                CurrencyUtil.getConvertedAmount(
                                    StateContainer.of(context)
                                        .curCurrency
                                        .currency
                                        .name,
                                    StateContainer.of(context)
                                        .appWallet!
                                        .appKeychain!
                                        .getAccountSelected()!
                                        .balance!
                                        .fiatCurrencyValue!),
                                textAlign: TextAlign.center,
                                style: AppStyles.textStyleSize12W600Primary(
                                    context),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: AutoSizeText(
                              StateContainer.of(context)
                                  .appWallet!
                                  .appKeychain!
                                  .getAccountSelected()!
                                  .balance!
                                  .fiatCurrencyCode!,
                              style:
                                  AppStyles.textStyleSize35W900EquinoxPrimary(
                                      context),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AutoSizeText(
                                CurrencyUtil.getConvertedAmount(
                                    StateContainer.of(context)
                                        .curCurrency
                                        .currency
                                        .name,
                                    StateContainer.of(context)
                                        .appWallet!
                                        .appKeychain!
                                        .getAccountSelected()!
                                        .balance!
                                        .fiatCurrencyValue!),
                                textAlign: TextAlign.center,
                                style:
                                    AppStyles.textStyleSize25W900EquinoxPrimary(
                                        context),
                              ),
                              AutoSizeText(
                                StateContainer.of(context)
                                        .appWallet!
                                        .appKeychain!
                                        .getAccountSelected()!
                                        .balance!
                                        .nativeTokenValueToString() +
                                    ' ' +
                                    StateContainer.of(context)
                                        .appWallet!
                                        .appKeychain!
                                        .getAccountSelected()!
                                        .balance!
                                        .nativeTokenName!,
                                style: AppStyles.textStyleSize12W600Primary(
                                    context),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfos(BuildContext context) {
    return InkWell(
      onTap: () async {
        await sl.get<HapticUtil>().feedback(
            FeedbackType.light, StateContainer.of(context).activeVibrations);
        optionChartList = <OptionChart>[
          OptionChart('24h', ChartInfos.getChartOptionLabel(context, '24h')),
          OptionChart('7d', ChartInfos.getChartOptionLabel(context, '7d')),
          OptionChart('14d', ChartInfos.getChartOptionLabel(context, '14d')),
          OptionChart('30d', ChartInfos.getChartOptionLabel(context, '30d')),
          OptionChart('60d', ChartInfos.getChartOptionLabel(context, '60d')),
          OptionChart('200d', ChartInfos.getChartOptionLabel(context, '200d')),
          OptionChart('1y', ChartInfos.getChartOptionLabel(context, '1y')),
        ];
        final OptionChart? optionChart;
        final String _idChartOption = StateContainer.of(context).idChartOption!;
        switch (_idChartOption) {
          case '7d':
            optionChart = optionChartList[1];
            break;
          case '14d':
            optionChart = optionChartList[2];
            break;
          case '30d':
            optionChart = optionChartList[3];
            break;
          case '60d':
            optionChart = optionChartList[4];
            break;
          case '200d':
            optionChart = optionChartList[5];
            break;
          case '1y':
            optionChart = optionChartList[6];
            break;
          case '24h':
          default:
            optionChart = optionChartList[0];
            break;
        }
        Sheets.showAppHeightNineSheet(
            context: context,
            widget: ChartSheet(
              optionChartList: optionChartList,
              optionChart: optionChart,
            ));
      },
      child: Ink(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Stack(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalization.of(context)!.priceChartHeader,
                        style: AppStyles.textStyleSize14W600EquinoxPrimary(
                            context),
                      ),
                      buildIconDataWidget(
                          context, Icons.arrow_circle_right_outlined, 20, 20),
                    ],
                  )),
              FadeIn(
                duration: const Duration(milliseconds: 1000),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30.0, top: 10),
                  child: StateContainer.of(context).chartInfos != null &&
                          StateContainer.of(context).chartInfos!.data != null
                      ? HistoryChart(
                          intervals:
                              StateContainer.of(context).chartInfos!.data!,
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
                          tooltipBg: StateContainer.of(context)
                              .curTheme
                              .backgroundDark!,
                          tooltipText:
                              AppStyles.textStyleSize12W100Primary(context),
                          optionChartSelected:
                              StateContainer.of(context).idChartOption!,
                          currency: StateContainer.of(context)
                              .curCurrency
                              .currency
                              .name,
                          completeChart: false,
                        )
                      : const SizedBox(),
                ),
              ),
            ],
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
            padding: const EdgeInsets.only(left: 10.0, top: 5.0),
            child: Row(
              children: <Widget>[
                AutoSizeText(
                  '1 ' +
                      StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .balance!
                          .nativeTokenName! +
                      ' = ' +
                      CurrencyUtil.getAmountPlusSymbol(
                          StateContainer.of(context)
                              .appWallet!
                              .appKeychain!
                              .getAccountSelected()!
                              .balance!
                              .fiatCurrencyCode!,
                          StateContainer.of(context)
                              .appWallet!
                              .appKeychain!
                              .getAccountSelected()!
                              .balance!
                              .tokenPrice!
                              .amount!),
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
                  style: StateContainer.of(context)
                              .chartInfos!
                              .getPriceChangePercentage(
                                  StateContainer.of(context).idChartOption!)! >=
                          0
                      ? AppStyles.textStyleSize12W100PositiveValue(context)
                      : AppStyles.textStyleSize12W100NegativeValue(context),
                ),
                const SizedBox(width: 5),
                StateContainer.of(context).chartInfos!.getPriceChangePercentage(
                            StateContainer.of(context).idChartOption!)! >=
                        0
                    ? FaIcon(FontAwesomeIcons.caretUp,
                        color:
                            StateContainer.of(context).curTheme.positiveValue)
                    : FaIcon(FontAwesomeIcons.caretDown,
                        color:
                            StateContainer.of(context).curTheme.negativeValue),
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
                StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .tokenPrice!
                        .useOracleUcoPrice!
                    ? InkWell(
                        onTap: () {
                          sl.get<HapticUtil>().feedback(FeedbackType.light,
                              StateContainer.of(context).activeVibrations);
                          AppDialogs.showInfoDialog(
                            context,
                            AppLocalization.of(context)!.informations,
                            AppLocalization.of(context)!.currencyOracleInfo,
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
}
