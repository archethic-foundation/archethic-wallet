// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/chart_infos.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/views/sheets/buy_sheet.dart';
import 'package:archethic_wallet/ui/views/sheets/chart_sheet.dart';
import 'package:archethic_wallet/ui/views/sheets/receive_sheet.dart';
import 'package:archethic_wallet/ui/views/sheets/transaction_chain_explorer_sheet.dart';
import 'package:archethic_wallet/ui/views/transfer/transfer_uco_sheet.dart';
import 'package:archethic_wallet/ui/widgets/components/icon_widget.dart';
import 'package:archethic_wallet/ui/widgets/components/sheet_util.dart';

class MenuWidget {
  List<OptionChart> optionChartList = List<OptionChart>.empty(growable: true);

  Widget buildMenuIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            child: InkWell(
                onTap: () {
                  Sheets.showAppHeightNineSheet(
                      context: context,
                      widget: TransferUcoSheet(
                          contactsRef: StateContainer.of(context).contactsRef,
                          title: AppLocalization.of(context)!.transferUCO,
                          localCurrency:
                              StateContainer.of(context).curCurrency));
                },
                child: Column(
                  children: <Widget>[
                    buildIconDataWidget(
                        context, Icons.arrow_circle_up_outlined, 50, 50),
                    const SizedBox(height: 5),
                    Text(AppLocalization.of(context)!.send,
                        style: AppStyles.textStyleSize14W600Primary(context)),
                  ],
                ))),
        Container(
          child: InkWell(
            onTap: () {
              Sheets.showAppHeightNineSheet(
                  context: context, widget: const ReceiveSheet());
            },
            child: Column(
              children: <Widget>[
                buildIconDataWidget(
                    context, Icons.arrow_circle_down_outlined, 50, 50),
                const SizedBox(height: 5),
                Text(AppLocalization.of(context)!.receive,
                    style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
          ),
        ),
        Container(
            child: InkWell(
                onTap: () {
                  Sheets.showAppHeightNineSheet(
                      context: context, widget: const BuySheet());
                },
                child: Column(
                  children: <Widget>[
                    buildIconDataWidget(
                        context, Icons.add_circle_outline_outlined, 50, 50),
                    const SizedBox(height: 5),
                    Text(AppLocalization.of(context)!.buy,
                        style: AppStyles.textStyleSize14W600Primary(context)),
                  ],
                ))),
        Container(
            child: InkWell(
                onTap: () {
                  optionChartList = <OptionChart>[
                    OptionChart(
                        '24h', ChartInfos.getChartOptionLabel(context, '24h')),
                    OptionChart(
                        '7d', ChartInfos.getChartOptionLabel(context, '7d')),
                    OptionChart(
                        '14d', ChartInfos.getChartOptionLabel(context, '14d')),
                    OptionChart(
                        '30d', ChartInfos.getChartOptionLabel(context, '30d')),
                    OptionChart(
                        '60d', ChartInfos.getChartOptionLabel(context, '60d')),
                    OptionChart('200d',
                        ChartInfos.getChartOptionLabel(context, '200d')),
                    OptionChart(
                        '1y', ChartInfos.getChartOptionLabel(context, '1y')),
                  ];
                  final OptionChart? optionChart;
                  String _idChartOption =
                      StateContainer.of(context).idChartOption!;
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
                child: Column(
                  children: <Widget>[
                    buildIconDataWidget(context, Icons.show_chart, 50, 50),
                    const SizedBox(height: 5),
                    Text(AppLocalization.of(context)!.chart,
                        style: AppStyles.textStyleSize14W600Primary(context)),
                  ],
                ))),
        /* if (!kIsWeb && Platform.isMacOS)
                              Container(
                                  child: InkWell(
                                      onTap: () {
                                        Sheets.showAppHeightNineSheet(
                                            context: context,
                                            widget: const LedgerSheet());
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          buildIconDataWidget(context,
                                              Icons.vpn_key_outlined, 50, 50),
                                          const SizedBox(height: 5),
                                          Text('Ledger',
                                              style: AppStyles
                                                  .textStyleSize14W600Primary(
                                                      context)),
                                        ],
                                      )))
                            else
                              const SizedBox(),*/
      ],
    );
  }

  Widget buildMenuTxExplorer(BuildContext context) {
    return InkWell(
      onTap: () {
        Sheets.showAppHeightNineSheet(
            context: context, widget: const TransactionChainExplorerSheet());
      },
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalization.of(context)!
                          .transactionChainExplorerHeader,
                      style: AppStyles.textStyleSize16W700Primary(context)),
                  Text(
                      AppLocalization.of(context)!.transactionChainExplorerDesc,
                      style: AppStyles.textStyleSize12W100Primary(context)),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
