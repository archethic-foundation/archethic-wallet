// Flutter imports:
// ignore_for_file: avoid_unnecessary_containers

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/menu/settings_drawer_wallet.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/sheets/ledger_sheet.dart';
import 'package:aewallet/ui/views/sheets/receive_sheet.dart';
import 'package:aewallet/ui/views/tokens/transfer_tokens_sheet.dart';
import 'package:aewallet/ui/views/transactions/transaction_chain_explorer_sheet.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/ae_apps.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core_ui/ui/widgets/menu/abstract_menu_widget.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class MenuWidgetWallet extends AbstractMenuWidget {
  @override
  Widget buildMainMenuIcons(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          sl.get<HapticUtil>().feedback(FeedbackType.light);
                          Sheets.showAppHeightNineSheet(
                              context: context,
                              widget: TransferTokensSheet(
                                  title: AppLocalization.of(context)!
                                      .transferTokens
                                      .replaceAll(
                                          '%1',
                                          StateContainer.of(context)
                                              .curNetwork
                                              .getNetworkCryptoCurrencyLabel()),
                                  localCurrency:
                                      StateContainer.of(context).curCurrency));
                        },
                        child: Column(
                          children: <Widget>[
                            buildIconDataWidget(context,
                                Icons.arrow_circle_up_outlined, 40, 40),
                            const SizedBox(height: 5),
                            Text(AppLocalization.of(context)!.send,
                                style: AppStyles.textStyleSize14W600Primary(
                                    context)),
                          ],
                        )))
                : Container(
                    child: Column(
                    children: <Widget>[
                      buildIconDataWidget(
                          context, Icons.arrow_circle_up_outlined, 40, 40,
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
                  sl.get<HapticUtil>().feedback(FeedbackType.light);
                  Sheets.showAppHeightNineSheet(
                      context: context, widget: const ReceiveSheet());
                },
                child: Column(
                  children: <Widget>[
                    buildIconDataWidget(
                        context, Icons.arrow_circle_down_outlined, 40, 40),
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
                      sl.get<HapticUtil>().feedback(FeedbackType.light);
                      Sheets.showAppHeightNineSheet(
                          context: context, widget: const BuySheet());
                    },
                    child: Column(
                      children: <Widget>[
                        buildIconDataWidget(
                            context, Icons.add_circle_outline_outlined, 40, 40),
                        const SizedBox(height: 5),
                        Text(AppLocalization.of(context)!.buy,
                            style:
                                AppStyles.textStyleSize14W600Primary(context)),
                      ],
                    ))),
            if (kIsWeb || Platform.isMacOS)
              Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: InkWell(
                      onTap: () {
                        sl.get<HapticUtil>().feedback(FeedbackType.light);
                        Sheets.showAppHeightNineSheet(
                            context: context, widget: const LedgerSheet());
                      },
                      child: Column(
                        children: <Widget>[
                          buildIconDataWidget(
                              context, Icons.vpn_key_outlined, 40, 40),
                          const SizedBox(height: 5),
                          Text('Ledger',
                              style: AppStyles.textStyleSize14W600Primary(
                                  context)),
                        ],
                      )))
          ],
        ),
      ),
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
                sl.get<HapticUtil>().feedback(FeedbackType.light);
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
        sl.get<HapticUtil>().feedback(FeedbackType.light);
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
