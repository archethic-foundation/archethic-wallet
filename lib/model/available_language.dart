/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';

enum AvailableLanguage { systemDefault, english, french }

/// Represent the available languages our app supports
class LanguageSetting extends SettingSelectionItem {
  LanguageSetting(this.language);

  AvailableLanguage language;

  @override
  String getDisplayName(BuildContext context) {
    switch (language) {
      case AvailableLanguage.english:
        return 'English (en)';
      case AvailableLanguage.french:
        return 'Français (fr)';
      //case AvailableLanguage.ARABIC:
      //  return 'Arabic (ar)';
      case AvailableLanguage.systemDefault:
        return AppLocalization.of(context)!.systemDefault;
    }
  }

  String getLocaleString() {
    switch (language) {
      case AvailableLanguage.english:
        return 'en';
      case AvailableLanguage.french:
        return 'fr';
      //case AvailableLanguage.ARABIC:
      //  return 'ar';
      case AvailableLanguage.systemDefault:
        return 'DEFAULT';
    }
  }

  Locale getLocale() {
    final localeStr = getLocaleString();
    if (localeStr == 'DEFAULT') {
      return const Locale('en');
    }
    return Locale(localeStr);
  }

  // For saving to shared prefs
  int getIndex() {
    return language.index;
  }
}
