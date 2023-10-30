/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';

enum AvailableLanguage { systemDefault, english, french }

extension AvailableLanguageExt on AvailableLanguage {
  Locale? getLocale() {
    switch (this) {
      case AvailableLanguage.english:
        return const Locale('en', 'US');
      case AvailableLanguage.french:
        return const Locale('fr', 'FR');
      case AvailableLanguage.systemDefault:
        return const Locale('en', 'US');
    }
  }

  String getLocaleString() {
    switch (this) {
      case AvailableLanguage.english:
        return 'en';
      case AvailableLanguage.french:
        return 'fr';
      case AvailableLanguage.systemDefault:
        return 'en';
    }
  }

  String getLocaleStringWithoutDefault() {
    switch (this) {
      case AvailableLanguage.english:
        return 'en';
      case AvailableLanguage.french:
        return 'fr';
      case AvailableLanguage.systemDefault:
        return 'en';
    }
  }
}

/// Represent the available languages our app supports
@immutable
class LanguageSetting extends SettingSelectionItem {
  const LanguageSetting(this.language);

  final AvailableLanguage language;

  @override
  String getDisplayName(BuildContext context) {
    switch (language) {
      case AvailableLanguage.english:
        return 'English (en)';
      case AvailableLanguage.french:
        return 'Français (fr)';
      case AvailableLanguage.systemDefault:
        return 'English (en)';
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return language.index;
  }
}
