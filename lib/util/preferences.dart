/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';
import 'dart:ui';

// Project imports:
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/data/settings.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/model/device_unlock_option.dart';
import 'package:aewallet/model/primary_currency.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
// Package imports:
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Preferences {
  Preferences._(this._box);

  static const String _preferencesBox = '_preferencesBox';
  final Box<dynamic> _box;

  //
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
  static const String hasShownRootWarning =
      'archethic_wallet_has_shown_root_warning';
  static const String pinAttempts = 'archethic_wallet_pin_attempts';
  static const String pinLockUntil = 'archethic_wallet_pin_lock_until';
  static const String pinPadShuffle = 'archethic_wallet_pinPadShuffle';
  static const String showBalances = 'archethic_wallet_showBalances';
  static const String showBlog = 'archethic_wallet_showBlog';
  static const String showPriceChart = 'archethic_wallet_showPriceChart';
  static const String activeVibrations = 'archethic_wallet_activeVibrations';
  static const String activeNotifications =
      'archethic_wallet_activeNotifications';
  static const String languageSeed = 'archethic_wallet_language_seed';
  static const String mainScreenCurrentPage =
      'archethic_wallet_main_screen_current_page';

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<Preferences> getInstance() async {
    final box = await Hive.openBox<dynamic>(_preferencesBox);
    return Preferences._(box);
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  Future<void> _removeValue<T>(dynamic key) => _box.delete(key);

  Future<void> setHasSeenRootWarning() => _setValue(hasShownRootWarning, true);

  bool getHasSeenRootWarning() =>
      _getValue(hasShownRootWarning, defaultValue: false);

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
          defaultValue: AvailableLanguage.systemDefault.index,
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

  Future<void> setNetwork(NetworksSetting network) =>
      _setValue(curNetwork, network.getIndex());

  NetworksSetting getNetwork() => NetworksSetting(
        AvailableNetworks.values[_getValue(
          curNetwork,
          defaultValue: AvailableNetworks.archethicMainNet.index,
        )],
      );

  Future<void> setNetworkDevEndpoint(String s) =>
      _setValue(curNetworkDevEndpoint, s);

  String getNetworkDevEndpoint() => _getValue(
        curNetworkDevEndpoint,
        defaultValue: 'http://localhost:4000',
      );

  Future<void> setLanguageSeed(String v) => _setValue(languageSeed, v);

  String getLanguageSeed() => _getValue(languageSeed, defaultValue: '');

  Future<void> setLock(bool value) => _setValue(lock, value);

  bool getLock() => _getValue(lock, defaultValue: false);

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

  Future<void> setMainScreenCurrentPage(int value) =>
      _setValue(mainScreenCurrentPage, value);

  int getMainScreenCurrentPage() =>
      _getValue(mainScreenCurrentPage, defaultValue: 1);

  Future<void> setShowPriceChart(bool value) =>
      _setValue(showPriceChart, value);

  bool getShowPriceChart() => _getValue(showPriceChart, defaultValue: true);

  Future<void> setLockTimeout(LockTimeoutSetting setting) =>
      _setValue(lockTimeout, setting.getIndex());

  LockTimeoutSetting getLockTimeout() => LockTimeoutSetting(
        LockTimeoutOption.values[_getValue(
          lockTimeout,
          defaultValue: LockTimeoutOption.one.index,
        )],
      );

  int getLockAttempts() => _getValue(pinAttempts, defaultValue: 0);

  Future<void> incrementLockAttempts() =>
      _setValue(pinAttempts, getLockAttempts() + 1);

  Future<void> resetLockAttempts() async {
    _removeValue(pinAttempts);
    _removeValue(pinLockUntil);
  }

  bool shouldLock() {
    if (_getValue(pinLockUntil) != null || getLockAttempts() >= 5) {
      return true;
    }
    return false;
  }

  Future<void> updateLockDate() async {
    final attempts = getLockAttempts();
    if (attempts >= 20) {
      // 4+ failed attempts
      _setValue(
        pinLockUntil,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(hours: 24))),
      );
    } else if (attempts >= 15) {
      // 3 failed attempts
      _setValue(
        pinLockUntil,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(minutes: 15))),
      );
    } else if (attempts >= 10) {
      // 2 failed attempts
      _setValue(
        pinLockUntil,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(minutes: 5))),
      );
    } else if (attempts >= 5) {
      _setValue(
        pinLockUntil,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(minutes: 1))),
      );
    }
  }

  DateTime? getLockDate() {
    final lockDateStr = _getValue(pinLockUntil);
    if (lockDateStr != null) {
      return DateFormat.yMd().add_jms().parseUtc(lockDateStr);
    } else {
      return null;
    }
  }

  Future<void> setTheme(ThemeSetting theme) =>
      _setValue(curTheme, theme.getIndex());

  ThemeSetting getTheme() => ThemeSetting(
        ThemeOptions
            .values[_getValue(curTheme, defaultValue: ThemeOptions.dark.index)],
      );

  Future<void> clearAll() async {
    await _box.clear();
  }

  static Future<void> initWallet(
    AuthenticationMethod authenticationMethod,
  ) async {
    final preferences = await Preferences.getInstance();
    preferences
      ..setLock(true)
      ..setShowBalances(true)
      ..setShowBlog(true)
      ..setActiveVibrations(true)
      ..setActiveNotifications(
        !kIsWeb &&
            (Platform.isIOS == true ||
                Platform.isAndroid == true ||
                Platform.isMacOS == true),
      )
      ..setPinPadShuffle(false)
      ..setShowPriceChart(true)
      ..setPrimaryCurrency(
        const AvailablePrimaryCurrency(AvailablePrimaryCurrencyEnum.native),
      )
      ..setLockTimeout(const LockTimeoutSetting(LockTimeoutOption.one))
      ..setAuthMethod(authenticationMethod)
      ..setMainScreenCurrentPage(1);
  }

  Settings toModel() => Settings(
        activeNotifications: getActiveNotifications(),
        activeVibrations: getActiveVibrations(),
        authenticationMethod: getAuthMethod().method,
        currency: getCurrency(const Locale('us', 'US'))
            .currency, // TODO(Chralu): utiliser la locale du telephone (mettre en place un provider dédié)
        firstLaunch: getFirstLaunch(),
        language: getLanguage().language,
        languageSeed: getLanguageSeed(),
        lock: getLock() ? UnlockOption.yes : UnlockOption.no,
        lockAttempts: getLockAttempts(),
        lockTimeout: getLockTimeout().setting,
        mainScreenCurrentPage: getMainScreenCurrentPage(),
        networks: getNetwork().network,
        pinPadShuffle: getPinPadShuffle(),
        primaryCurrency: getPrimaryCurrency(),
        showBalances: getShowBalances(),
        showBlog: getShowBlog(),
        showPriceChart: getShowPriceChart(),
        theme: getTheme().theme,
        pinLockUntil: getLockDate(),
      );
}
