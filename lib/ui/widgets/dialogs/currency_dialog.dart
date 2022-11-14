/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyDialog {
  static Future<AvailableCurrencyEnum?> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
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
        final theme = ref.watch(ThemeProviders.selectedTheme);
        final currency = AvailableCurrency(
          ref.watch(
            SettingsProviders.settings.select((settings) => settings.currency),
          ),
        );
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalization.of(context)!.currency,
                  style: theme.textStyleSize24W700EquinoxPrimary,
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
              selectedIndex: currency.getIndex(),
              onSelected: (value) async {
                final currency =
                    AvailableCurrency(value.value as AvailableCurrencyEnum);

                await ref
                    .read(
                      SettingsProviders.settings.notifier,
                    )
                    .selectCurrency(currency);

                ref
                    .read(AccountProviders.selectedAccount.notifier)
                    .refreshBalance();
                Navigator.pop(context, value.value);
              },
            ),
          ),
        );
      },
    );
  }
}
