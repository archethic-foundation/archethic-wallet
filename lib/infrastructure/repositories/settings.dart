import 'dart:ui';

import 'package:aewallet/domain/models/settings.dart';
import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_themes.dart';

class SettingsRepository implements SettingsRepositoryInterface {
  HivePreferencesDatasource? _preferences;
  Future<HivePreferencesDatasource> get preferences async =>
      _preferences ??= await HivePreferencesDatasource.getInstance();

  @override
  Future<Settings> getSettings(Locale currentLocale) async {
    final loadedPreferences = await preferences;

    return Settings(
      activeNotifications: loadedPreferences.getActiveNotifications(),
      activeVibrations: loadedPreferences.getActiveVibrations(),
      currency: loadedPreferences.getCurrency(currentLocale).currency,
      firstLaunch: loadedPreferences.getFirstLaunch(),
      language: loadedPreferences.getLanguage().language,
      languageSeed: loadedPreferences.getLanguageSeed(),
      mainScreenCurrentPage: loadedPreferences.getMainScreenCurrentPage(),
      network: loadedPreferences.getNetwork(),
      primaryCurrency: loadedPreferences.getPrimaryCurrency(),
      showBalances: loadedPreferences.getShowBalances(),
      showBlog: loadedPreferences.getShowBlog(),
      showPriceChart: loadedPreferences.getShowPriceChart(),
      priceChartIntervalOption: loadedPreferences.getPriceChartIntervalOption(),
      theme: loadedPreferences.getTheme().theme,
    );
  }

  @override
  Future<void> setSettings(Settings settings) async {
    final loadedPreferences = await preferences;
    await loadedPreferences
        .setActiveNotifications(settings.activeNotifications);
    await loadedPreferences.setActiveVibrations(settings.activeVibrations);
    await loadedPreferences.setCurrency(AvailableCurrency(settings.currency));
    await loadedPreferences.setFirstLaunch(settings.firstLaunch);
    await loadedPreferences.setLanguage(LanguageSetting(settings.language));
    await loadedPreferences.setLanguageSeed(settings.languageSeed);
    await loadedPreferences
        .setMainScreenCurrentPage(settings.mainScreenCurrentPage);
    await loadedPreferences.setNetwork(settings.network);
    await loadedPreferences.setPrimaryCurrency(settings.primaryCurrency);
    await loadedPreferences.setShowBalances(settings.showBalances);
    await loadedPreferences.setShowBlog(settings.showBlog);
    await loadedPreferences.setShowPriceChart(settings.showPriceChart);
    await loadedPreferences
        .setPriceChartIntervalOption(settings.priceChartIntervalOption);
    await loadedPreferences.setTheme(ThemeSetting(settings.theme));
  }
}
