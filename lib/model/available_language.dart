// @dart=2.9

import 'package:flutter/material.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/model/setting_item.dart';

enum AvailableLanguage { DEFAULT, ENGLISH, FRENCH, GERMAN, INDONESIAN, DUTCH, SPANISH, ITALIAN}

/// Represent the available languages our app supports
class LanguageSetting extends SettingSelectionItem {
  AvailableLanguage language;

  LanguageSetting(this.language);

  String getDisplayName(BuildContext context) {
    switch (language) {
      case AvailableLanguage.ENGLISH:
        return "English (en)";
      case AvailableLanguage.FRENCH:
        return "Français (fr)";
      case AvailableLanguage.GERMAN:
        return "Deutsch (de)";
      case AvailableLanguage.INDONESIAN:
        return "Bahasa Indonesia (id)";
      case AvailableLanguage.DUTCH:
        return "Nederlands (nl)";
      case AvailableLanguage.SPANISH:
        return "Español (es)";
      case AvailableLanguage.ITALIAN:
        return "Italiano (it)";
      default:
        return AppLocalization.of(context).systemDefault;
    }
  }

  String getLocaleString() {
    switch (language) {
      case AvailableLanguage.ENGLISH:
        return "en";
      case AvailableLanguage.FRENCH:
        return "fr";
      case AvailableLanguage.GERMAN:
        return "de";
      case AvailableLanguage.INDONESIAN:
        return "id";
      case AvailableLanguage.DUTCH:
        return "nl";
      case AvailableLanguage.SPANISH:
        return "es";
      case AvailableLanguage.ITALIAN:
        return "it";
      default:
        return "DEFAULT";
    }
  }

  Locale getLocale() {
    String localeStr = getLocaleString();
    if (localeStr == 'DEFAULT') {
      return Locale('en');
    }
    return Locale(localeStr);
  }

  // For saving to shared prefs
  int getIndex() {
    return language.index;
  }
}
