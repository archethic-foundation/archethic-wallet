/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: constant_identifier_names

// Dart imports:
import 'dart:io';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/model/primary_currency.dart';

class Preferences {
  Preferences._(this._box);

  static const String _preferencesBox = '_preferencesBox';
  final Box<dynamic> _box;

  //
  static const String _first_launch = 'archethic_wallet_first_launch';
  static const String _auth_method = 'archethic_wallet_auth_method';
  static const String _cur_currency = 'archethic_wallet_cur_currency';
  static const String _cur_language = 'archethic_wallet_cur_language';
  static const String _cur_primary_setting =
      'archethic_wallet_cur_primary_setting';
  static const String _cur_network = 'archethic_wallet_cur_network';
  static const String _cur_network_dev_endpoint = '_cur_network_dev_endpoint';
  static const String _cur_theme = 'archethic_wallet_cur_theme';
  static const String _lock = 'archethic_wallet_lock';
  static const String _lock_timeout = 'archethic_wallet_lock_timeout';
  static const String _has_shown_root_warning =
      'archethic_wallet_has_shown_root_warning';
  static const String _pin_attempts = 'archethic_wallet_pin_attempts';
  static const String _pin_lock_until = 'archethic_wallet_pin_lock_until';
  static const String _pinPadShuffle = 'archethic_wallet_pinPadShuffle';
  static const String _showBalances = 'archethic_wallet_showBalances';
  static const String _showBlog = 'archethic_wallet_showBlog';
  static const String _showPriceChart = 'archethic_wallet_showPriceChart';
  static const String _activeVibrations = 'archethic_wallet_activeVibrations';
  static const String _activeNotifications =
      'archethic_wallet_activeNotifications';
  static const String _language_seed = 'archethic_wallet_language_seed';
  static const String _main_screen_current_page =
      'archethic_wallet_main_screen_current_page';

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<Preferences> getInstance() async {
    final Box<dynamic> box = await Hive.openBox<dynamic>(_preferencesBox);
    return Preferences._(box);
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  Future<void> _removeValue<T>(dynamic key) => _box.delete(key);

  Future<void> setHasSeenRootWarning() =>
      _setValue(_has_shown_root_warning, true);

  bool getHasSeenRootWarning() =>
      _getValue(_has_shown_root_warning, defaultValue: false);

  Future<void> setAuthMethod(AuthenticationMethod method) =>
      _setValue(_auth_method, method.getIndex());

  AuthenticationMethod getAuthMethod() => AuthenticationMethod(AuthMethod
      .values[_getValue(_auth_method, defaultValue: AuthMethod.pin.index)]);

  Future<void> setCurrency(AvailableCurrency currency) =>
      _setValue(_cur_currency, currency.getIndex());

  AvailableCurrency getCurrency(Locale deviceLocale) =>
      AvailableCurrency(AvailableCurrencyEnum.values[_getValue(_cur_currency,
          defaultValue: AvailableCurrency.getBestForLocale(deviceLocale)
              .currency
              .index)]);

  Future<void> setLanguage(LanguageSetting language) =>
      _setValue(_cur_language, language.getIndex());

  LanguageSetting getLanguage() => LanguageSetting(AvailableLanguage.values[
      _getValue(_cur_language, defaultValue: AvailableLanguage.DEFAULT.index)]);

  Future<void> setPrimaryCurrency(PrimaryCurrencySetting primarySetting) =>
      _setValue(_cur_primary_setting, primarySetting.getIndex());

  PrimaryCurrencySetting getPrimaryCurrency() => PrimaryCurrencySetting(
      AvailablePrimaryCurrency.values[_getValue(_cur_primary_setting,
          defaultValue: AvailablePrimaryCurrency.native.index)]);

  Future<void> setNetwork(NetworksSetting network) =>
      _setValue(_cur_network, network.getIndex());

  NetworksSetting getNetwork() =>
      NetworksSetting(AvailableNetworks.values[_getValue(_cur_network,
          defaultValue: AvailableNetworks.archethicMainNet.index)]);

  Future<void> setNetworkDevEndpoint(String s) =>
      _setValue(_cur_network_dev_endpoint, s);

  String getNetworkDevEndpoint() => _getValue(_cur_network_dev_endpoint,
      defaultValue: 'http://localhost:4000');

  Future<void> setLanguageSeed(String v) => _setValue(_language_seed, v);

  String getLanguageSeed() => _getValue(_language_seed, defaultValue: '');

  Future<void> setLock(bool value) => _setValue(_lock, value);

  bool getLock() => _getValue(_lock, defaultValue: false);

  Future<void> setFirstLaunch(bool value) => _setValue(_first_launch, value);

  bool getFirstLaunch() => _getValue(_first_launch, defaultValue: true);

  Future<void> setPinPadShuffle(bool value) => _setValue(_pinPadShuffle, value);

  bool getPinPadShuffle() => _getValue(_pinPadShuffle, defaultValue: false);

  Future<void> setShowBalances(bool value) => _setValue(_showBalances, value);

  bool getShowBalances() => _getValue(_showBalances, defaultValue: true);

  Future<void> setShowBlog(bool value) => _setValue(_showBlog, value);

  bool getShowBlog() => _getValue(_showBlog, defaultValue: true);

  Future<void> setActiveVibrations(bool value) =>
      _setValue(_activeVibrations, value);

  bool getActiveVibrations() =>
      _getValue(_activeVibrations, defaultValue: true);

  Future<void> setActiveNotifications(bool value) =>
      _setValue(_activeNotifications, value);

  bool getActiveNotifications() =>
      _getValue(_activeNotifications, defaultValue: true);

  Future<void> setMainScreenCurrentPage(int value) =>
      _setValue(_main_screen_current_page, value);

  int getMainScreenCurrentPage() =>
      _getValue(_main_screen_current_page, defaultValue: 1);

  Future<void> setShowPriceChart(bool value) =>
      _setValue(_showPriceChart, value);

  bool getShowPriceChart() => _getValue(_showPriceChart, defaultValue: true);

  Future<void> setLockTimeout(LockTimeoutSetting setting) =>
      _setValue(_lock_timeout, setting.getIndex());

  LockTimeoutSetting getLockTimeout() =>
      LockTimeoutSetting(LockTimeoutOption.values[
          _getValue(_lock_timeout, defaultValue: LockTimeoutOption.one.index)]);

  int getLockAttempts() => _getValue(_pin_attempts, defaultValue: 0);

  Future<void> incrementLockAttempts() =>
      _setValue(_pin_attempts, getLockAttempts() + 1);

  Future<void> resetLockAttempts() async {
    _removeValue(_pin_attempts);
    _removeValue(_pin_lock_until);
  }

  bool shouldLock() {
    if (_getValue(_pin_lock_until) != null || getLockAttempts() >= 5) {
      return true;
    }
    return false;
  }

  Future<void> updateLockDate() async {
    final int attempts = getLockAttempts();
    if (attempts >= 20) {
      // 4+ failed attempts
      _setValue(
          _pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(const Duration(hours: 24))));
    } else if (attempts >= 15) {
      // 3 failed attempts
      _setValue(
          _pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(const Duration(minutes: 15))));
    } else if (attempts >= 10) {
      // 2 failed attempts
      _setValue(
          _pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(const Duration(minutes: 5))));
    } else if (attempts >= 5) {
      _setValue(
          _pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(const Duration(minutes: 1))));
    }
  }

  DateTime? getLockDate() {
    final String? lockDateStr = _getValue(_pin_lock_until);
    if (lockDateStr != null) {
      return DateFormat.yMd().add_jms().parseUtc(lockDateStr);
    } else {
      return null;
    }
  }

  Future<void> setTheme(ThemeSetting theme) =>
      _setValue(_cur_theme, theme.getIndex());

  ThemeSetting getTheme() => ThemeSetting(ThemeOptions
      .values[_getValue(_cur_theme, defaultValue: ThemeOptions.dark.index)]);

  Future<void> clearAll() async {
    await _box.clear();
  }

  static Future<void> initWallet(
      AuthenticationMethod authenticationMethod) async {
    final Preferences preferences = await Preferences.getInstance();
    preferences.setLock(true);
    preferences.setShowBalances(true);
    preferences.setShowBlog(true);
    preferences.setActiveVibrations(true);
    if (!kIsWeb &&
        (Platform.isIOS == true ||
            Platform.isAndroid == true ||
            Platform.isMacOS == true)) {
      preferences.setActiveNotifications(true);
    } else {
      preferences.setActiveNotifications(false);
    }
    preferences.setPinPadShuffle(false);
    preferences.setShowPriceChart(true);
    preferences.setPrimaryCurrency(
        PrimaryCurrencySetting(AvailablePrimaryCurrency.native));
    preferences.setLockTimeout(LockTimeoutSetting(LockTimeoutOption.one));
    preferences.setAuthMethod(authenticationMethod);
    preferences.setMainScreenCurrentPage(1);
  }
}
