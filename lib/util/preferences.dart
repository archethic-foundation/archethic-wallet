// Dart imports:
// ignore_for_file: constant_identifier_names

import 'dart:ui';

// Package imports:
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_wallet/util/global_var.dart';
import 'package:archethic_wallet/model/authentication_method.dart';
import 'package:archethic_wallet/model/available_currency.dart';
import 'package:archethic_wallet/model/available_language.dart';
import 'package:archethic_wallet/model/available_themes.dart';
import 'package:archethic_wallet/model/device_lock_timeout.dart';

class Preferences {
  Preferences._(this._box);

  static const String _preferencesBox = '_preferencesBox';
  final Box<dynamic> _box;

  //
  static const String _auth_method = 'archethic_auth_method';
  static const String _cur_currency = 'archethic_cur_currency';
  static const String _cur_language = 'archethic_cur_language';
  static const String _cur_theme = 'archethic_cur_theme';
  static const String _lock = 'archethic_lock';
  static const String _lock_timeout = 'archethic_lock_timeout';
  static const String _has_shown_root_warning =
      'archethic_has_shown_root_warning';
  static const String _pin_attempts = 'archethic_pin_attempts';
  static const String _pin_lock_until = 'archethic_pin_lock_until';
  static const String _version_app = 'archethic_version_app';

  static const String _endpoint = 'archethic_endpoint';
  static const String _pinPadShuffle = 'archethic_pinPadShuffle';

  // Yubikey
  static const String _yubikeyClientID = 'archethic_yubikeyClientID';
  static const String _yubikeyClientAPIKey = 'archethic_yubikeyClientAPIKey';

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

  Future<void> setVersionApp(String v) => _setValue(_version_app, v);

  String getVersionApp() => _getValue(_version_app, defaultValue: '');

  Future<void> setEndpoint(String v) => _setValue(_endpoint, v);

  String getEndpoint() =>
      _getValue(_endpoint, defaultValue: globalVarEndPointDev);

  Future<void> setYubikeyClientAPIKey(String v) =>
      _setValue(_yubikeyClientAPIKey, v);

  String getYubikeyClientAPIKey() =>
      _getValue(_yubikeyClientAPIKey, defaultValue: '');

  Future<void> setYubikeyClientID(String v) => _setValue(_yubikeyClientID, v);

  String getYubikeyClientID() => _getValue(_yubikeyClientID, defaultValue: '');

  Future<void> setLock(bool value) => _setValue(_lock, value);

  bool getLock() => _getValue(_lock, defaultValue: false);

  Future<void> setPinPadShuffle(bool value) => _setValue(_pinPadShuffle, value);

  bool getPinPadShuffle() => _getValue(_pinPadShuffle, defaultValue: false);

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

  Future<void> deleteAll() => _box.deleteFromDisk();
}
