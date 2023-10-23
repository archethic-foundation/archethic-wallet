/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';

import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
        final primaryCurrency =
            ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
        return AlertDialog(
          backgroundColor: ArchethicTheme.backgroundPopupColor,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              AppLocalizations.of(context)!.primaryCurrency,
              style: ArchethicThemeStyles.textStyleSize24W700Primary,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          content: PickerWidget(
            pickerItems: pickerItemsList,
            selectedIndexes: [primaryCurrency.getIndex()],
            onSelected: (value) async {
              final primaryCurrency = AvailablePrimaryCurrency(
                value.value as AvailablePrimaryCurrencyEnum,
              );

              await ref
                  .read(SettingsProviders.settings.notifier)
                  .selectPrimaryCurrency(primaryCurrency);
              Navigator.pop(context, value.value);
            },
          ),
        );
      },
    );
  }
}
