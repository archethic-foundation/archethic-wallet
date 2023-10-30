/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class BalanceInfosPopup {
  static Future getPopup(
    BuildContext context,
    WidgetRef ref,
    TapDownDetails details,
    AccountBalance accountSelectedBalance,
  ) async {
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final language = ref.watch(
      LanguageProviders.selectedLanguage,
    );
    final fiatBalance = ref
        .watch(
          MarketPriceProviders.convertedToSelectedCurrency(
            nativeAmount: accountSelectedBalance.nativeTokenValue,
          ),
        )
        .valueOrNull;
    if (fiatBalance == null) return const SizedBox();

    return showMenu(
      color: ArchethicTheme.backgroundDark,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
        side: BorderSide(
          color: ArchethicTheme.text60,
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
                    accountSelectedBalance.nativeTokenValueToString(
                      language.getLocaleStringWithoutDefault(),
                    ),
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
                    accountSelectedBalance.nativeTokenValueToString(
                      language.getLocaleStringWithoutDefault(),
                    ),
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
                Symbols.content_copy,
                size: 20,
                color: ArchethicTheme.text,
                weight: IconSize.weightM,
                opticalSize: IconSize.opticalSizeM,
                grade: IconSize.gradeM,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                value,
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
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

    UIUtil.showSnackbar(
      localizations.amountCopied,
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      icon: Symbols.info,
    );
  }
}
