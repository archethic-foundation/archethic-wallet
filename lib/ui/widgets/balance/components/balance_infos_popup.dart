/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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

    final fiatBalance = ref
        .watch(
          MarketPriceProviders.convertedToSelectedCurrency(
            nativeAmount: accountSelectedBalance.nativeTokenValue,
          ),
        )
        .valueOrNull;
    if (fiatBalance == null) return const SizedBox();

    return showMenu(
      color: theme.backgroundDark,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
        side: BorderSide(
          color: theme.text60!,
        ),
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
                    fiatBalance.toString(),
                  ),
                ]
              : [
                  _popupMenuItem(
                    accountSelectedBalance,
                    context,
                    ref,
                    '2',
                    fiatBalance.toString(),
                  ),
                  _popupMenuItem(
                    accountSelectedBalance,
                    context,
                    ref,
                    '1',
                    accountSelectedBalance.nativeTokenValueToString(),
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
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.read(ThemeProviders.selectedTheme);
    UIUtil.showSnackbar(
      localizations.amountCopied,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
    );
  }
}
