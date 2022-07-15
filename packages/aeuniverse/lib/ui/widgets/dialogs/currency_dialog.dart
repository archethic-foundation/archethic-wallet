/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:core/localization.dart';
import 'package:core/model/available_currency.dart';
import 'package:core/model/data/price.dart';
import 'package:flutter/material.dart';

class CurrencyDialog {
  static Future<AvailableCurrencyEnum?> getDialog(BuildContext context) async {
    final Preferences preferences = await Preferences.getInstance();
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    // Provide a way to get the last value of an oracle #451
    /* for (var value in AvailableCurrencyEnum.values) {
      pickerItemsList.add(PickerItem(
        AvailableCurrency(value).getDisplayName(context),
        null,
        'packages/aeuniverse/assets/icons/currency/${AvailableCurrency(value).currency.name.toLowerCase()}.png',
        null,
        value,
        true,
        subLabel: value.name == 'USD' || value.name == 'EUR'
            ? '(Conversion provided by Archethic Oracles)'
            : null,
      ));
    }*/
    for (var value in AvailableCurrencyEnum.values) {
      pickerItemsList.add(PickerItem(
        AvailableCurrency(value).getDisplayName(context),
        null,
        'packages/aeuniverse/assets/icons/currency/${AvailableCurrency(value).currency.name.toLowerCase()}.png',
        null,
        value,
        true,
        subLabel: null,
      ));
    }
    return await showDialog<AvailableCurrencyEnum>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.text45!)),
            content: SingleChildScrollView(
              child: PickerWidget(
                pickerItems: pickerItemsList,
                selectedIndex:
                    StateContainer.of(context).curCurrency.getIndex(),
                onSelected: (value) async {
                  preferences.setCurrency(
                      AvailableCurrency(value.value as AvailableCurrencyEnum));
                  StateContainer.of(context).curCurrency =
                      AvailableCurrency(value.value as AvailableCurrencyEnum);

                  Price tokenPrice = await Price.getCurrency(
                      StateContainer.of(context).curCurrency.currency.name);
                  await StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .updateBalance(
                          StateContainer.of(context)
                              .curNetwork
                              .getNetworkCryptoCurrencyLabel(),
                          StateContainer.of(context).curCurrency.currency.name,
                          tokenPrice);

                  StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .balance!
                          .fiatCurrencyCode =
                      (AvailableCurrency(value.value as AvailableCurrencyEnum))
                          .currency
                          .name;
                  await StateContainer.of(context).updateCurrency(
                      AvailableCurrency(value.value as AvailableCurrencyEnum));
                  Navigator.pop(context, value.value);
                },
              ),
            ),
          );
        });
  }
}
