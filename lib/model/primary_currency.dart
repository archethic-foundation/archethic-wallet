/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/model/setting_item.dart';

enum AvailablePrimaryCurrency { native, fiat }

/// Represent the available languages our app supports
class PrimaryCurrencySetting extends SettingSelectionItem {
  PrimaryCurrencySetting(this.primaryCurrency);

  AvailablePrimaryCurrency primaryCurrency;

  @override
  String getDisplayName(BuildContext context) {
    switch (primaryCurrency) {
      case AvailablePrimaryCurrency.native:
        return 'Native';
      case AvailablePrimaryCurrency.fiat:
        return 'Fiat';
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return primaryCurrency.index;
  }
}
