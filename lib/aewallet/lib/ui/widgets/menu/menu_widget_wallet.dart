// Flutter imports:
// ignore_for_file: avoid_unnecessary_containers

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/sheets/chart_sheet.dart';
import 'package:aewallet/ui/views/sheets/ledger_sheet.dart';
import 'package:aewallet/ui/views/sheets/receive_sheet.dart';
import 'package:aewallet/ui/views/sheets/transaction_chain_explorer_sheet.dart';
import 'package:aewallet/ui/views/transfer/transfer_uco_sheet.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/appstate_container.dart';
import 'package:core/localization.dart';
import 'package:core/model/ae_apps.dart';
import 'package:core/model/chart_infos.dart';
import 'package:core/ui/util/styles.dart';
import 'package:core/ui/widgets/components/icon_widget.dart';
import 'package:core/ui/widgets/components/sheet_util.dart';
import 'package:core/ui/widgets/menu/abstract_menu_widget.dart';

// Project imports:
import 'settings_drawer_wallet.dart';

class MenuWidgetWallet extends AbstractMenuWidget {
  List<OptionChart> optionChartList = List<OptionChart>.empty(growable: true);

  @override
  Widget buildMainMenuIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (StateContainer.of(context).wallet != null &&
                    StateContainer.of(context).wallet!.accountBalance.uco !=
                        null &&
                    StateContainer.of(context).wallet!.accountBalance.uco! >
                        0) ||
                (StateContainer.of(context).localWallet != null &&
                    StateContainer.of(context)
                            .localWallet!
                            .accountBalance
                            .uco !=
                        null &&
                    StateContainer.of(context)
                            .localWallet!
                            .accountBalance
                            .uco! >
                        0)
            ? Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: InkWell(
                    onTap: () {
                      Sheets.showAppHeightNineSheet(
                          context: context,
                          widget: TransferUcoSheet(
                              contactsRef:
                                  StateContainer.of(context).contactsRef,
                              title: AppLocalization.of(context)!.transferUCO,
                              localCurrency:
                                  StateContainer.of(context).curCurrency));
                    },
                    child: Column(
                      children: <Widget>[
                        buildIconDataWidget(
                            context, Icons.arrow_circle_up_outlined, 30, 30),
                        const SizedBox(height: 5),
                        Text(AppLocalization.of(context)!.send,
                            style:
                                AppStyles.textStyleSize14W600Primary(context)),
                      ],
                    )))
            : Container(
                child: Column(
                children: <Widget>[
                  buildIconDataWidget(
                      context, Icons.arrow_circle_up_outlined, 30, 30,
                      enabled: false),
                  const SizedBox(height: 5),
                  Text(AppLocalization.of(context)!.send,
                      style: AppStyles.textStyleSize14W600PrimaryDisabled(
                          context)),
                ],
              )),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: InkWell(
            onTap: () {
              Sheets.showAppHeightNineSheet(
                  context: context, widget: const ReceiveSheet());
            },
            child: Column(
              children: <Widget>[
                buildIconDataWidget(
                    context, Icons.arrow_circle_down_outlined, 30, 30),
                const SizedBox(height: 5),
                Text(AppLocalization.of(context)!.receive,
                    style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: InkWell(
                onTap: () {
                  Sheets.showAppHeightNineSheet(
                      context: context, widget: const BuySheet());
                },
                child: Column(
                  children: <Widget>[
                    buildIconDataWidget(
                        context, Icons.add_circle_outline_outlined, 30, 30),
                    const SizedBox(height: 5),
                    Text(AppLocalization.of(context)!.buy,
                        style: AppStyles.textStyleSize14W600Primary(context)),
                  ],
                ))),
        Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                  final String _idChartOption =
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
                    buildIconDataWidget(context, Icons.show_chart, 30, 30),
                    const SizedBox(height: 5),
                    Text(AppLocalization.of(context)!.chart,
                        style: AppStyles.textStyleSize14W600Primary(context)),
                  ],
                ))),
        if (kIsWeb || Platform.isMacOS)
          Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: InkWell(
                  onTap: () {
                    Sheets.showAppHeightNineSheet(
                        context: context, widget: const LedgerSheet());
                  },
                  child: Column(
                    children: <Widget>[
                      buildIconDataWidget(
                          context, Icons.vpn_key_outlined, 30, 30),
                      const SizedBox(height: 5),
                      Text('Ledger',
                          style: AppStyles.textStyleSize14W600Primary(context)),
                    ],
                  )))
        else
          const SizedBox(),
      ],
    );
  }

  @override
  Widget buildSecondMenuIcons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: InkWell(
              onTap: () {
                StateContainer.of(context).currentAEApp = AEApps.bin;
                Navigator.pop(context);
              },
              child: buildIconDataWidget(context, Icons.home, 20, 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildContextMenu(BuildContext context) {
    return const SettingsSheetWallet();
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                        AppLocalization.of(context)!
                            .transactionChainExplorerHeader,
                        maxLines: 2,
                        style: AppStyles.textStyleSize16W700Primary(context)),
                    AutoSizeText(
                        AppLocalization.of(context)!
                            .transactionChainExplorerDesc,
                        maxLines: 2,
                        style: AppStyles.textStyleSize12W100Primary(context)),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              buildIconDataWidget(
                  context, Icons.arrow_forward_ios_rounded, 25, 25),
            ],
          ),
        ),
      ),
    );
  }
}
