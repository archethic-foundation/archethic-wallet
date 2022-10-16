/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/primary_currency.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryCurrencyDialog {
  static Future<AvailablePrimaryCurrencyEnum?> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final pickerItemsList = List<PickerItem>.empty(growable: true);

    for (final value in AvailablePrimaryCurrencyEnum.values) {
      pickerItemsList.add(
        PickerItem(
          AvailablePrimaryCurrency(value).getDisplayName(context),
          null,
          null,
          null,
          value,
          true,
        ),
      );
    }

    return showDialog<AvailablePrimaryCurrencyEnum>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final theme = ref.watch(ThemeProviders.selectedTheme);
        final primaryCurrency =
            ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              AppLocalization.of(context)!.primaryCurrency,
              style: theme.textStyleSize24W700EquinoxPrimary,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: theme.text45!,
            ),
          ),
          content: PickerWidget(
            pickerItems: pickerItemsList,
            selectedIndex: primaryCurrency.getIndex(),
            onSelected: (value) async {
              final primaryCurrency = AvailablePrimaryCurrency(
                  value.value as AvailablePrimaryCurrencyEnum,);

              await ref.read(
                PrimaryCurrencyProviders.selectPrimaryCurrency(
                  primaryCurrency: primaryCurrency,
                ).future,
              );
              Navigator.pop(context, value.value);
            },
          ),
        );
      },
    );
  }
}
