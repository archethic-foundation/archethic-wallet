/// SPDX-License-Identifier: AGPL-3.0-or-later

// Project imports:
import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';

enum AvailablePrimaryCurrencyEnum { native, fiat }

/// Represent the available languages our app supports
@immutable
class AvailablePrimaryCurrency extends SettingSelectionItem {
  const AvailablePrimaryCurrency(this.primaryCurrency);

  final AvailablePrimaryCurrencyEnum primaryCurrency;

  @override
  String getDisplayName(BuildContext context) {
    switch (primaryCurrency) {
      case AvailablePrimaryCurrencyEnum.native:
        return 'Native';
      case AvailablePrimaryCurrencyEnum.fiat:
        return 'Fiat';
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return primaryCurrency.index;
  }
}
