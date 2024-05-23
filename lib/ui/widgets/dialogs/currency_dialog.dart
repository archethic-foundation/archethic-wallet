import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
              ? AppLocalizations.of(context)!.conversionOraclePromotion
              : null,
        ),
      );
    }

    return showDialog<AvailableCurrencyEnum>(
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        final currency = AvailableCurrency(
          ref.watch(
            SettingsProviders.settings.select((settings) => settings.currency),
          ),
        );
        return aedappfm.PopupTemplate(
          popupContent: SingleChildScrollView(
            child: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndexes: [currency.getIndex()],
              onSelected: (value) async {
                final currency =
                    AvailableCurrency(value.value as AvailableCurrencyEnum);
                await ref
                    .read(
                      SettingsProviders.settings.notifier,
                    )
                    .selectCurrency(currency);

                await ref
                    .read(AccountProviders.selectedAccount.notifier)
                    .refreshBalance();
                context.pop(value.value);
              },
            ),
          ),
          popupTitle: AppLocalizations.of(context)!.currency,
        );
      },
    );
  }
}
