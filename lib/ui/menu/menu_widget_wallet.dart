// ignore_for_file: avoid_unnecessary_containers

/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/sheets/receive_sheet.dart';
import 'package:aewallet/ui/views/uco/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

//TODO(reddwarf03): This Widget is not part of the Drawer menu. Should we move it in `views/main` directory ?
class MenuWidgetWallet extends StatelessWidget {
  const MenuWidgetWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: Colors.transparent,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (StateContainer.of(context)
                    .appWallet!
                    .appKeychain!
                    .getAccountSelected()!
                    .balance!
                    .isNativeTokenValuePositive())
                  _ActionButton(
                    text: AppLocalization.of(context)!.send,
                    icon: Icons.arrow_circle_up_outlined,
                    onTap: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            StateContainer.of(context).activeVibrations,
                          );
                      Sheets.showAppHeightNineSheet(
                        context: context,
                        widget: TransferSheet(
                          primaryCurrency:
                              StateContainer.of(context).curPrimaryCurrency,
                          title: AppLocalization.of(context)!
                              .transferTokens
                              .replaceAll(
                                '%1',
                                StateContainer.of(context)
                                    .curNetwork
                                    .getNetworkCryptoCurrencyLabel(),
                              ),
                          localCurrency: StateContainer.of(context).curCurrency,
                        ),
                      );
                    },
                  )
                else
                  _ActionButton(
                    text: AppLocalization.of(context)!.send,
                    icon: Icons.arrow_circle_up_outlined,
                  ),
                _ActionButton(
                  text: AppLocalization.of(context)!.receive,
                  icon: Icons.arrow_circle_down_outlined,
                  onTap: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          StateContainer.of(context).activeVibrations,
                        );
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      widget: ReceiveSheet(
                        address: StateContainer.of(context)
                            .appWallet!
                            .appKeychain!
                            .getAccountSelected()!
                            .lastAddress,
                      ),
                      onDisposed: () {
                        setState(() {
                          StateContainer.of(context)
                              .requestUpdate(forceUpdateChart: false);
                        });
                      },
                    );
                  },
                ),
                _ActionButton(
                  text: AppLocalization.of(context)!.buy,
                  icon: Icons.add_circle_outline_outlined,
                  onTap: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          StateContainer.of(context).activeVibrations,
                        );
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      widget: const BuySheet(),
                    );
                  },
                ),
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
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    this.onTap,
    super.key,
    required this.text,
    required this.icon,
  });

  final VoidCallback? onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            IconWidget.buildIconDataWidget(
              context,
              icon,
              40,
              40,
              enabled: onTap != null,
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: AppStyles.textStyleSize14W600EquinoxPrimary(
                context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
