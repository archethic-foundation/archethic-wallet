/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:developer';
import 'dart:ui';

import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class HivePreferencesDatasource {
  HivePreferencesDatasource._(this._box);

  static const String _preferencesBox = '_preferencesBox';
  final Box<dynamic> _box;

  static const String firstLaunch = 'archethic_wallet_first_launch';
  static const String authMethod = 'archethic_wallet_auth_method';
  static const String curCurrency = 'archethic_wallet_cur_currency';
  static const String curLanguage = 'archethic_wallet_cur_language';
  static const String curPrimarySetting =
      'archethic_wallet_cur_primary_setting';
  static const String curNetwork = 'archethic_wallet_cur_network';
  static const String curNetworkDevEndpoint = '_cur_network_dev_endpoint';
  static const String curTheme = 'archethic_wallet_cur_theme';
  static const String lock = 'archethic_wallet_lock';
  static const String lockTimeout = 'archethic_wallet_lock_timeout';
  static const String lastInteractionDate =
      'archethic_wallet_last_interaction_date';
  static const String hasShownRootWarning =
      'archethic_wallet_has_shown_root_warning';
  static const String pinAttempts = 'archethic_wallet_pin_attempts';
  static const String pinLockUntil = 'archethic_wallet_pin_lock_until';
  static const String pinPadShuffle = 'archethic_wallet_pinPadShuffle';
  static const String showBalances = 'archethic_wallet_showBalances';
  static const String showBlog = 'archethic_wallet_showBlog';
  static const String showPriceChart = 'archethic_wallet_showPriceChart';
  static const String priceChartScale = 'archethic_wallet_priceChartScale';
  static const String activeVibrations = 'archethic_wallet_activeVibrations';
  static const String activeRPCServer = 'archethic_wallet_activeRPCServer';
  static const String recoveryPhraseSaved =
      'archethic_wallet_recoveryPhraseSaved';

  static const String activeNotifications =
      'archethic_wallet_activeNotifications';
  static const String languageSeed = 'archethic_wallet_language_seed';
  static const String mainScreenCurrentPage =
      'archethic_wallet_main_screen_current_page';
  static const String currentVersion = 'archethic_wallet_currentVersion';

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<HivePreferencesDatasource> getInstance() async {
    final box = await Hive.openBox<dynamic>(_preferencesBox);
    return HivePreferencesDatasource._(box);
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> migrateStringToIntData(String key) async {
    log('Migrate local data for $key', name: 'migrateStringToIntData');
    final value = _box.get(key);
    if (value is String) {
      final intValue = int.tryParse(value);
      if (intValue != null) {
        await _box.put(key, intValue);
      }
    }
  }

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  Future<void> _removeValue<T>(dynamic key) => _box.delete(key);

  Future<void> setHasShownRootWarning(bool hasShown) =>
      _setValue(hasShownRootWarning, hasShown);

  bool getHasSeenRootWarning() =>
      _getValue(hasShownRootWarning, defaultValue: false);

  Future<void> setCurrentDataVersion(int version) =>
      _setValue(currentVersion, version);

  Future<int> getCurrentDataVersion() async {
    try {
      return _getValue(currentVersion, defaultValue: 0);
    } catch (e) {
      log('Error type: $e', name: 'getCurrentDataVersion');
      final value = _box.get(currentVersion);
      if (value is String) {
        await migrateStringToIntData(currentVersion);
        return int.tryParse(value) ?? 0;
      } else {
        return value;
      }
    }
  }

  Future<void> setAuthMethod(AuthenticationMethod method) =>
      _setValue(authMethod, method.getIndex());

  AuthenticationMethod getAuthMethod() => AuthenticationMethod(
        AuthMethod
            .values[_getValue(authMethod, defaultValue: AuthMethod.pin.index)],
      );

  Future<void> setCurrency(AvailableCurrency currency) =>
      _setValue(curCurrency, currency.getIndex());

  AvailableCurrency getCurrency(Locale deviceLocale) => AvailableCurrency(
        AvailableCurrencyEnum.values[_getValue(
          curCurrency,
          defaultValue:
              AvailableCurrency.getBestForLocale(deviceLocale).currency.index,
        )],
      );

  Future<void> setLanguage(LanguageSetting language) =>
      _setValue(curLanguage, language.getIndex());

  LanguageSetting getLanguage() => LanguageSetting(
        AvailableLanguage.values[_getValue(
          curLanguage,
          defaultValue: AvailableLanguage.english.index,
        )],
      );

  Future<void> setPrimaryCurrency(AvailablePrimaryCurrency primaryCurrency) =>
      _setValue(curPrimarySetting, primaryCurrency.getIndex());

  AvailablePrimaryCurrency getPrimaryCurrency() => AvailablePrimaryCurrency(
        AvailablePrimaryCurrencyEnum.values[_getValue(
          curPrimarySetting,
          defaultValue: AvailablePrimaryCurrencyEnum.native.index,
        )],
      );

  Future<void> setNetwork(NetworksSetting network) async {
    await _setValue(curNetwork, network.getIndex());
    await _setValue(curNetworkDevEndpoint, network.networkDevEndpoint);
  }

  NetworksSetting getNetwork() => NetworksSetting(
        network: AvailableNetworks.values[_getValue(
          curNetwork,
          defaultValue: AvailableNetworks.archethicMainNet.index,
        )],
        networkDevEndpoint: _getValue(
          curNetworkDevEndpoint,
          defaultValue: '',
        ),
      );

  // Future<void> setNetworkDevEndpoint(String s) {
  //   return _setValue(curNetworkDevEndpoint, s);
  // }

  // String getNetworkDevEndpoint() => _getValue(
  //       curNetworkDevEndpoint,
  //       defaultValue: 'http://localhost:4000',
  //     );

  Future<void> setLanguageSeed(String v) => _setValue(languageSeed, v);

  String getLanguageSeed() => _getValue(languageSeed, defaultValue: '');

  Future<void> setLock(bool value) => _setValue(lock, value);

  bool getLock() => _getValue(lock, defaultValue: true);

  Future<void> setFirstLaunch(bool value) => _setValue(firstLaunch, value);

  bool getFirstLaunch() => _getValue(firstLaunch, defaultValue: true);

  Future<void> setPinPadShuffle(bool value) => _setValue(pinPadShuffle, value);

  bool getPinPadShuffle() => _getValue(pinPadShuffle, defaultValue: false);

  Future<void> setShowBalances(bool value) => _setValue(showBalances, value);

  bool getShowBalances() => _getValue(showBalances, defaultValue: true);

  Future<void> setShowBlog(bool value) => _setValue(showBlog, value);

  bool getShowBlog() => _getValue(showBlog, defaultValue: true);

  Future<void> setActiveVibrations(bool value) =>
      _setValue(activeVibrations, value);

  bool getActiveVibrations() => _getValue(activeVibrations, defaultValue: true);

  Future<void> setActiveNotifications(bool value) =>
      _setValue(activeNotifications, value);

  bool getActiveNotifications() =>
      _getValue(activeNotifications, defaultValue: true);

  Future<void> setActiveRPCServer(bool value) =>
      _setValue(activeRPCServer, value);

  bool getActiveRPCServer() => _getValue(activeRPCServer, defaultValue: true);

  Future<void> setRecoveryPhraseSaved(bool value) =>
      _setValue(recoveryPhraseSaved, value);

  bool getRecoveryPhraseSaved() =>
      _getValue(recoveryPhraseSaved, defaultValue: false);

  Future<void> setMainScreenCurrentPage(int value) =>
      _setValue(mainScreenCurrentPage, value);

  int getMainScreenCurrentPage() =>
      _getValue(mainScreenCurrentPage, defaultValue: 2);

  Future<void> setShowPriceChart(bool value) =>
      _setValue(showPriceChart, value);

  bool getShowPriceChart() => _getValue(showPriceChart, defaultValue: true);

  Future<void> setPriceChartIntervalOption(
    MarketPriceHistoryInterval scaleOption,
  ) =>
      _setValue(
        priceChartScale,
        scaleOption.index,
      );

  MarketPriceHistoryInterval getPriceChartIntervalOption() =>
      MarketPriceHistoryInterval.values[_getValue(
        priceChartScale,
        defaultValue: MarketPriceHistoryInterval.hour.index,
      )];

  Future<void> setLockTimeout(LockTimeoutOption lockTimeoutOption) =>
      _setValue(lockTimeout, lockTimeoutOption.index);

  LockTimeoutOption getLockTimeout() => LockTimeoutOption.values[_getValue(
        lockTimeout,
        defaultValue: LockTimeoutOption.oneMin.index,
      )];

  int getLockAttempts() => _getValue(pinAttempts, defaultValue: 0);

  Future<void> incrementLockAttempts() => _setValue(
        pinAttempts,
        getLockAttempts() + 1,
      );

  Future<void> resetLockAttempts() async {
    _removeValue(pinAttempts);
  }

  void removeLockDate() {
    _removeValue(pinLockUntil);
  }

  void setLockDate(DateTime lockDate) {
    final lockDateStr = DateFormat.yMd().add_jms().format(lockDate.toUtc());
    _setValue(pinLockUntil, lockDateStr);
  }

  DateTime? getLockDate() {
    final lockDateStr = _getValue(pinLockUntil);

    if (lockDateStr != null) {
      return DateFormat.yMd().add_jms().parseUtc(lockDateStr);
    } else {
      return null;
    }
  }

  Future<void> clearAll() async {
    await _box.clear();
  }

  Future<DateTime?> getLastInteractionDate() async {
    return _getValue(lastInteractionDate, defaultValue: null);
  }

  Future<void> setLastInteractionDate(DateTime date) async {
    return _setValue(lastInteractionDate, date);
  }

  Future<void> clearLastInteractionDate() async {
    await _removeValue(lastInteractionDate);
  }
}
