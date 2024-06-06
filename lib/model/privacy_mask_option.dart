/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';
// Project imports:
import 'package:flutter_gen/gen_l10n/localizations.dart';

enum PrivacyMaskOption { enabled, disabled }

/// Represent authenticate to open setting
@immutable
class PrivacyMaskSetting extends SettingSelectionItem {
  const PrivacyMaskSetting(this.setting);

  final PrivacyMaskOption setting;

  @override
  String getDisplayName(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (setting) {
      case PrivacyMaskOption.enabled:
        return localizations.yes;
      case PrivacyMaskOption.disabled:
        return localizations.no;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return setting.index;
  }
}
