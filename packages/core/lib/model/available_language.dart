/// SPDX-License-Identifier: AGPL-3.0-or-later

// ignore_for_file: constant_identifier_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:core/localization.dart';
import 'package:core/model/setting_item.dart';

enum AvailableLanguage { DEFAULT, ENGLISH, FRENCH }

/// Represent the available languages our app supports
class LanguageSetting extends SettingSelectionItem {
  LanguageSetting(this.language);

  AvailableLanguage language;

  @override
  String getDisplayName(BuildContext context) {
    switch (language) {
      case AvailableLanguage.ENGLISH:
        return 'English (en)';
      case AvailableLanguage.FRENCH:
        return 'Français (fr)';
      //case AvailableLanguage.ARABIC:
      //  return 'Arabic (ar)';
      default:
        return AppLocalization.of(context)!.systemDefault;
    }
  }

  String getLocaleString() {
    switch (language) {
      case AvailableLanguage.ENGLISH:
        return 'en';
      case AvailableLanguage.FRENCH:
        return 'fr';
      //case AvailableLanguage.ARABIC:
      //  return 'ar';
      default:
        return 'DEFAULT';
    }
  }

  Locale getLocale() {
    final String localeStr = getLocaleString();
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
