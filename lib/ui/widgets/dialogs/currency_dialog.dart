/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:flutter/material.dart';

class CurrencyDialog {
  static Future<AvailableCurrencyEnum?> getDialog(BuildContext context) async {
    final preferences = await Preferences.getInstance();
    final pickerItemsList = List<PickerItem>.empty(growable: true);

    for (final value in AvailableCurrencyEnum.values) {
      pickerItemsList.add(
        PickerItem(
          AvailableCurrency(value).getDisplayName(context),
          null,
          'assets/icons/currency/${AvailableCurrency(value).currency.name.toLowerCase()}.png',
          null,
          value,
          true,
          subLabel: value.name == 'usd' || value.name == 'eur'
              ? AppLocalization.of(context)!.conversionOraclePromotion
              : null,
        ),
      );
    }

    return showDialog<AvailableCurrencyEnum>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final theme = StateContainer.of(context).curTheme;
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalization.of(context)!.currency,
                  style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: theme.text45!,
            ),
          ),
          content: SingleChildScrollView(
            child: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndex: StateContainer.of(context).curCurrency.getIndex(),
              onSelected: (value) async {
                preferences.setCurrency(
                  AvailableCurrency(value.value as AvailableCurrencyEnum),
                );
                StateContainer.of(context).curCurrency =
                    AvailableCurrency(value.value as AvailableCurrencyEnum);

                final tokenPrice = await Price.getCurrency(
                  StateContainer.of(context).curCurrency.currency.name,
                );
                await StateContainer.of(context)
                    .appWallet!
                    .appKeychain!
                    .getAccountSelected()!
                    .updateBalance(
                      StateContainer.of(context)
                          .curNetwork
                          .getNetworkCryptoCurrencyLabel(),
                      StateContainer.of(context).curCurrency.currency.name,
                      tokenPrice,
                    );

                StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .fiatCurrencyCode =
                    AvailableCurrency(value.value as AvailableCurrencyEnum)
                        .currency
                        .name;
                await StateContainer.of(context).updateCurrency(
                  AvailableCurrency(value.value as AvailableCurrencyEnum),
                );
                Navigator.pop(context, value.value);
              },
            ),
          ),
        );
      },
    );
  }
}
