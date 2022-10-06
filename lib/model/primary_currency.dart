/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';

enum AvailablePrimaryCurrency { native, fiat }

/// Represent the available languages our app supports
@immutable
class PrimaryCurrencySetting extends SettingSelectionItem {
  const PrimaryCurrencySetting(this.primaryCurrency);

  final AvailablePrimaryCurrency primaryCurrency;

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
