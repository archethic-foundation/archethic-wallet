// Dart imports:
import 'dart:async';
import 'dart:ui';

// Package imports:
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:archethic_mobile_wallet/global_var.dart';
import 'package:archethic_mobile_wallet/model/authentication_method.dart';
import 'package:archethic_mobile_wallet/model/available_currency.dart';
import 'package:archethic_mobile_wallet/model/available_language.dart';
import 'package:archethic_mobile_wallet/model/device_lock_timeout.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/util/encrypt.dart';
import 'package:archethic_mobile_wallet/util/random_util.dart';

/// Singleton wrapper for shared preferences
class SharedPrefsUtil {
  // Keys
  static const String first_launch_key = 'farchethic_first_launch';
  static const String price_conversion = 'farchethic_price_conversion_pref';
  static const String auth_method = 'farchethic_auth_method';
  static const String cur_currency = 'farchethic_currency_pref';
  static const String cur_language = 'farchethic_language_pref';
  static const String cur_theme = 'farchethic_theme_pref';
  static const String firstcontact_added = 'farchethic_first_c_added';
  static const String lock = 'farchethic_lock_dev';
  static const String lock_timeout = 'farchethic_lock_timeout';
  static const String has_shown_root_warning =
      'farchethic_root_warn'; // If user has seen the root/jailbreak warning yet
  // For maximum pin attempts
  static const String pin_attempts = 'farchethic_pin_attempts';
  static const String pin_lock_until = 'farchethic_lock_duraton';
  // For certain keystore incompatible androids
  static const String use_legacy_storage = 'farchethic_legacy_storage';

  static const String version_app = 'farchethic_version_app';

  static const String endpoint = 'farchethic_endpoint';
  static const String pinPadShuffle = 'farchethic_pinPadShuffle';

  // Yubikey
  static const String yubikeyClientID = 'farchethic_yubikeyClientID';
  static const String yubikeyClientAPIKey = 'farchethic_yubikeyClientAPIKey';

  // For plain-text data
  // ignore: always_specify_types
  Future<void> set(String key, value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    }
  }

  Future<dynamic> get(String key, {dynamic defaultValue}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.get(key) ?? defaultValue;
  }

  // For encrypted data
  Future<void> setEncrypted(String key, String value) async {
    // Retrieve/Generate encryption password
    String? secret = await sl.get<Vault>().getEncryptionPhrase();
    if (secret == null) {
      secret = RandomUtil.generateEncryptionSecret(16) +
          ':' +
          RandomUtil.generateEncryptionSecret(8);
      await sl.get<Vault>().writeEncryptionPhrase(secret);
    }
    // Encrypt and save
    final Salsa20Encryptor encrypter =
        Salsa20Encryptor(secret.split(':')[0], secret.split(':')[1]);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, encrypter.encrypt(value));
  }

  Future<String?> getEncrypted(String key) async {
    final String? secret = await sl.get<Vault>().getEncryptionPhrase();
    if (secret == null) {
      return null;
    }
    // Decrypt and return
    final Salsa20Encryptor encrypter =
        Salsa20Encryptor(secret.split(':')[0], secret.split(':')[1]);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? encrypted = prefs.get(key).toString();
    if (encrypted == null) {
      return null;
    }
    return encrypter.decrypt(encrypted);
  }

  Future<void> setHasSeenRootWarning() async {
    return await set(has_shown_root_warning, true);
  }

  Future<bool> getHasSeenRootWarning() async {
    return await get(has_shown_root_warning, defaultValue: false);
  }

  Future<void> setFirstLaunch() async {
    return await set(first_launch_key, false);
  }

  Future<bool> getFirstLaunch() async {
    return await get(first_launch_key, defaultValue: true);
  }

  Future<void> setFirstContactAdded(bool value) async {
    return await set(firstcontact_added, value);
  }

  Future<bool> getFirstContactAdded() async {
    return await get(firstcontact_added, defaultValue: false);
  }

  Future<void> setAuthMethod(AuthenticationMethod method) async {
    return await set(auth_method, method.getIndex());
  }

  Future<AuthenticationMethod> getAuthMethod() async {
    return AuthenticationMethod(AuthMethod.values[
        await get(auth_method, defaultValue: AuthMethod.BIOMETRICS.index)]);
  }

  Future<void> setCurrency(AvailableCurrency currency) async {
    return await set(cur_currency, currency.getIndex());
  }

  Future<AvailableCurrency> getCurrency(Locale deviceLocale) async {
    return AvailableCurrency(AvailableCurrencyEnum.values[await get(
        cur_currency,
        defaultValue:
            AvailableCurrency.getBestForLocale(deviceLocale).currency.index)]);
  }

  Future<void> setLanguage(LanguageSetting language) async {
    return await set(cur_language, language.getIndex());
  }

  Future<LanguageSetting> getLanguage() async {
    return LanguageSetting(AvailableLanguage.values[await get(cur_language,
        defaultValue: AvailableLanguage.DEFAULT.index)]);
  }

  Future<void> setVersionApp(String v) async {
    return await set(version_app, v);
  }

  Future<String> getVersionApp() async {
    return await get(version_app, defaultValue: '');
  }

  Future<void> setEndpoint(String v) async {
    return await set(endpoint, v);
  }

  Future<String> getEndpoint() async {
    return await get(endpoint, defaultValue: glovalVarEndPointDev);
  }

  Future<void> setYubikeyClientAPIKey(String v) async {
    return await set(yubikeyClientAPIKey, v);
  }

  Future<String> getYubikeyClientAPIKey() async {
    return await get(yubikeyClientAPIKey, defaultValue: '');
  }

  Future<void> setYubikeyClientID(String v) async {
    return await set(yubikeyClientID, v);
  }

  Future<String> getYubikeyClientID() async {
    return await get(yubikeyClientID, defaultValue: '');
  }

  Future<void> setLock(bool value) async {
    return await set(lock, value);
  }

  Future<bool> getLock() async {
    return await get(lock, defaultValue: false);
  }

  Future<void> setPinPadShuffle(bool value) async {
    return await set(pinPadShuffle, value);
  }

  Future<bool> getPinPadShuffle() async {
    return await get(pinPadShuffle, defaultValue: false);
  }

  Future<void> setLockTimeout(LockTimeoutSetting setting) async {
    return await set(lock_timeout, setting.getIndex());
  }

  Future<LockTimeoutSetting> getLockTimeout() async {
    return LockTimeoutSetting(LockTimeoutOption.values[
        await get(lock_timeout, defaultValue: LockTimeoutOption.ONE.index)]);
  }

  // Locking out when max pin attempts exceeded
  Future<int> getLockAttempts() async {
    return await get(pin_attempts, defaultValue: 0);
  }

  Future<void> incrementLockAttempts() async {
    await set(pin_attempts, await getLockAttempts() + 1);
  }

  Future<void> resetLockAttempts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(pin_attempts);
    await prefs.remove(pin_lock_until);
  }

  Future<bool> shouldLock() async {
    if (await get(pin_lock_until) != null || await getLockAttempts() >= 5) {
      return true;
    }
    return false;
  }

  Future<void> updateLockDate() async {
    final int attempts = await getLockAttempts();
    if (attempts >= 20) {
      // 4+ failed attempts
      await set(
          pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(const Duration(hours: 24))));
    } else if (attempts >= 15) {
      // 3 failed attempts
      await set(
          pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(const Duration(minutes: 15))));
    } else if (attempts >= 10) {
      // 2 failed attempts
      await set(
          pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(const Duration(minutes: 5))));
    } else if (attempts >= 5) {
      await set(
          pin_lock_until,
          DateFormat.yMd()
              .add_jms()
              .format(DateTime.now().toUtc().add(const Duration(minutes: 1))));
    }
  }

  Future<DateTime?> getLockDate() async {
    final String? lockDateStr = await get(pin_lock_until);
    if (lockDateStr != null) {
      return DateFormat.yMd().add_jms().parseUtc(lockDateStr);
    } else {
      return null;
    }
  }

  Future<bool> useLegacyStorage() async {
    return await get(use_legacy_storage, defaultValue: false);
  }

  Future<void> setUseLegacyStorage() async {
    await set(use_legacy_storage, true);
  }

  // For logging out
  Future<void> deleteAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(price_conversion);
    await prefs.remove(cur_currency);
    await prefs.remove(auth_method);
    await prefs.remove(lock);
    await prefs.remove(pin_attempts);
    await prefs.remove(pin_lock_until);
    await prefs.remove(lock_timeout);
    await prefs.remove(has_shown_root_warning);
    await prefs.remove(version_app);
    await prefs.remove(endpoint);
    await prefs.remove(pinPadShuffle);
  }
}
