/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/primary_currency.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BalanceInfosPopup {
  static Future getPopup(
    BuildContext context,
    WidgetRef ref,
    TapDownDetails details,
    AccountBalance accountSelectedBalance,
  ) async {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

    return showMenu(
      color: theme.backgroundDark,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).copyWith(topRight: Radius.zero),
      ),
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items:
          primaryCurrency.primaryCurrency == AvailablePrimaryCurrencyEnum.native
              ? [
                  _popupMenuItem(
                    accountSelectedBalance,
                    context,
                    ref,
                    '1',
                    accountSelectedBalance.nativeTokenValueToString(),
                  ),
                  _popupMenuItem(
                    accountSelectedBalance,
                    context,
                    ref,
                    '2',
                    accountSelectedBalance.fiatCurrencyValue!.toString(),
                  ),
                ]
              : [
                  _popupMenuItem(
                    accountSelectedBalance,
                    context,
                    ref,
                    '2',
                    accountSelectedBalance.fiatCurrencyValue!.toString(),
                  ),
                  _popupMenuItem(
                    accountSelectedBalance,
                    context,
                    ref,
                    '1',
                    accountSelectedBalance.fiatCurrencyValue!.toString(),
                  ),
                ],
    );
  }

  static PopupMenuItem _popupMenuItem(
    AccountBalance accountSelectedBalance,
    BuildContext context,
    WidgetRef ref,
    String id,
    String value,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return PopupMenuItem(
      value: id,
      onTap: () {
        _copyAmount(
          context,
          ref,
          value,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.copy,
                size: 20,
                color: theme.text,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                value,
                style: theme.textStyleSize12W100Primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static void _copyAmount(BuildContext context, WidgetRef ref, String amount) {
    Clipboard.setData(ClipboardData(text: amount));
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    UIUtil.showSnackbar(
      localizations.amountCopied,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
    );
  }
}
