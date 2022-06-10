/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:core/model/setting_item.dart';

enum AvailablePrimaryCurrency { NATIVE, FIAT }

/// Represent the available languages our app supports
class PrimaryCurrencySetting extends SettingSelectionItem {
  PrimaryCurrencySetting(this.primaryCurrency);

  AvailablePrimaryCurrency primaryCurrency;

  @override
  String getDisplayName(BuildContext context) {
    switch (primaryCurrency) {
      case AvailablePrimaryCurrency.NATIVE:
        return 'Native';
      case AvailablePrimaryCurrency.FIAT:
        return 'Fiat';
      default:
        return 'Fiat';
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return primaryCurrency.index;
  }
}
