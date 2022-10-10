// ignore_for_file: avoid_unnecessary_containers

/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/views/sheets/receive_sheet.dart';
import 'package:aewallet/ui/views/uco/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

// TODO(reddwarf03): This Widget is not part of the Drawer menu. Should we move it in `views/main` directory ?
class MenuWidgetWallet extends ConsumerWidget {
  const MenuWidgetWallet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!;

    return StatefulBuilder(
      builder: (context, setState) {
        final localizations = AppLocalization.of(context)!;
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
                if (accountSelected.balance!.isNativeTokenValuePositive())
                  _ActionButton(
                    text: localizations.send,
                    icon: UiIcons.send,
                    onTap: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            StateContainer.of(context).activeVibrations,
                          );
                      Sheets.showAppHeightNineSheet(
                        context: context,
                        ref: ref,
                        widget: TransferSheet(
                          primaryCurrency: StateContainer.of(context).curPrimaryCurrency,
                          title: localizations.transferTokens.replaceAll(
                            '%1',
                            StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel(),
                          ),
                          localCurrency: StateContainer.of(context).curCurrency,
                        ),
                      );
                    },
                  )
                else
                  _ActionButton(
                    text: localizations.send,
                    icon: UiIcons.send,
                  ),
                _ActionButton(
                  text: localizations.receive,
                  icon: UiIcons.receive,
                  onTap: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          StateContainer.of(context).activeVibrations,
                        );
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      ref: ref,
                      widget: ReceiveSheet(
                        address: accountSelected.lastAddress,
                      ),
                      onDisposed: () {
                        setState(() {
                          StateContainer.of(context).requestUpdate(forceUpdateChart: false);
                        });
                      },
                    );
                  },
                ),
                _ActionButton(
                  text: localizations.buy,
                  icon: UiIcons.buy,
                  onTap: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          StateContainer.of(context).activeVibrations,
                        );
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      ref: ref,
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
                              style: theme.textStyleSize14W600Primary),
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

class _ActionButton extends ConsumerWidget {
  const _ActionButton({
    this.onTap,
    required this.text,
    required this.icon,
  });

  final VoidCallback? onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.theme);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              child: Column(
                children: <Widget>[
                  ShaderMask(
                    child: SizedBox(
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    shaderCallback: (Rect bounds) {
                      const rect = Rect.fromLTRB(0, 0, 40, 40);
                      return theme.gradient!.createShader(rect);
                    },
                  ),
                  const SizedBox(height: 5),
                  Text(
                    text,
                    style: theme.textStyleSize14W600EquinoxPrimary,
                  ),
                ],
              ),
            )
          : Column(
              children: <Widget>[
                ShaderMask(
                  child: SizedBox(
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  shaderCallback: (Rect bounds) {
                    const rect = Rect.fromLTRB(0, 0, 40, 40);
                    return theme.gradient!.createShader(rect);
                  },
                ),
                const SizedBox(height: 5),
                Text(
                  text,
                  style: theme.textStyleSize14W600EquinoxPrimary,
                ),
              ],
            ),
    );
  }
}
