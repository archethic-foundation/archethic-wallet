// ignore_for_file: avoid_unnecessary_containers

/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:core/localization.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core_ui/ui/util/responsive.dart';
import 'package:core_ui/ui/widgets/menu/abstract_menu_widget.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aewallet/ui/menu/settings_drawer_wallet_mobile.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/sheets/receive_sheet.dart';
import 'package:aewallet/ui/views/uco/transfer_uco_sheet.dart';

class MenuWidgetWallet extends AbstractMenuWidget {
  @override
  Widget buildMainMenuIcons(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
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
                StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .isNativeTokenValuePositive()
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: InkWell(
                            onTap: () {
                              sl.get<HapticUtil>().feedback(FeedbackType.light,
                                  StateContainer.of(context).activeVibrations);
                              Sheets.showAppHeightNineSheet(
                                context: context,
                                widget: TransferUCOSheet(
                                    primaryCurrency: StateContainer.of(context)
                                        .curPrimaryCurrency,
                                    title: AppLocalization.of(context)!
                                        .transferTokens
                                        .replaceAll(
                                            '%1',
                                            StateContainer.of(context)
                                                .curNetwork
                                                .getNetworkCryptoCurrencyLabel()),
                                    localCurrency:
                                        StateContainer.of(context).curCurrency),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                buildIconDataWidget(context,
                                    Icons.arrow_circle_up_outlined, 40, 40),
                                const SizedBox(height: 5),
                                Text(AppLocalization.of(context)!.send,
                                    style: AppStyles
                                        .textStyleSize14W600EquinoxPrimary(
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
                              style: AppStyles
                                  .textStyleSize14W600EquinoxPrimaryDisabled(
                                      context)),
                        ],
                      )),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: InkWell(
                    onTap: () {
                      sl.get<HapticUtil>().feedback(FeedbackType.light,
                          StateContainer.of(context).activeVibrations);
                      Sheets.showAppHeightNineSheet(
                          context: context,
                          widget: const ReceiveSheet(),
                          onDisposed: () {
                            setState(() {
                              StateContainer.of(context)
                                  .requestUpdate(forceUpdateChart: false);
                            });
                          });
                    },
                    child: Column(
                      children: <Widget>[
                        buildIconDataWidget(
                            context, Icons.arrow_circle_down_outlined, 40, 40),
                        const SizedBox(height: 5),
                        Text(AppLocalization.of(context)!.receive,
                            style: AppStyles.textStyleSize14W600EquinoxPrimary(
                                context)),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 10.0),
                    child: InkWell(
                        onTap: () {
                          sl.get<HapticUtil>().feedback(FeedbackType.light,
                              StateContainer.of(context).activeVibrations);
                          Sheets.showAppHeightNineSheet(
                              context: context, widget: const BuySheet());
                        },
                        child: Column(
                          children: <Widget>[
                            buildIconDataWidget(context,
                                Icons.add_circle_outline_outlined, 40, 40),
                            const SizedBox(height: 5),
                            Text(AppLocalization.of(context)!.buy,
                                style:
                                    AppStyles.textStyleSize14W600EquinoxPrimary(
                                        context)),
                          ],
                        ))),
                /*if (kIsWeb || Platform.isMacOS)
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
                      )))*/
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSecondMenuIcons(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildContextMenu(BuildContext context) {
    return SizedBox(
      width: Responsive.drawerWidth(context),
      child: const Drawer(
        // TODO: dependencies issue
        child: SettingsSheetWalletMobile(),
      ),
    );
  }
}
