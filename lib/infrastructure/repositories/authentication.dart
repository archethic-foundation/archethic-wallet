import 'package:aewallet/domain/models/authentication.dart';
import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:aewallet/infrastructure/datasources/hive_vault.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/device_unlock_option.dart';

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  HiveVaultDatasource? _vault;
  Future<HiveVaultDatasource> get vault async =>
      _vault ??= await HiveVaultDatasource.getInstance();

  HivePreferencesDatasource? _preferences;
  Future<HivePreferencesDatasource> get preferences async =>
      _preferences ??= await HivePreferencesDatasource.getInstance();

  @override
  Future<String?> getPin() async {
    return (await vault).getPin();
  }

  @override
  Future<void> setPin(String pin) async {
    (await vault).setPin(pin);
  }

  @override
  Future<int> getFailedPinAttempts() async {
    return (await preferences).getLockAttempts();
  }

  @override
  Future<void> incrementFailedAttempts() async {
    (await preferences).incrementLockAttempts();
  }

  @override
  Future<void> resetFailedAttempts() async {
    await (await preferences).resetLockAttempts();
  }

  @override
  Future<String?> getPassword() async {
    return (await vault).getPassword();
  }

  @override
  Future<void> setPassword(String password) async {
    (await vault).setPassword(password);
  }

  @override
  Future<void> resetLock() async {
    (await preferences).removeLockDate();
  }

  @override
  Future<DateTime?> getLockUntilDate() async {
    return (await preferences).getLockDate();
  }

  @override
  Future<void> lock(Duration duration) async {
    (await preferences).setLockDate(DateTime.now().add(duration));
  }

  @override
  Future<DateTime?> getAutoLockTriggerDate() async {
    return (await preferences).getAutoLockTriggerDate();
  }

  @override
  Future<void> setAutoLockTriggerDate(DateTime newAutoLockDate) async {
    return (await preferences).setAutoLockTriggerDate(newAutoLockDate);
  }

  @override
  Future<void> removeAutoLockTriggerDate() async {
    return (await preferences).clearAutoLockTriggerDate();
  }

  @override
  Future<AuthenticationSettings> getSettings() async {
    final loadedPreferences = await preferences;
    return AuthenticationSettings(
      authenticationMethod: loadedPreferences.getAuthMethod().method,
      pinPadShuffle: loadedPreferences.getPinPadShuffle(),
      lock: loadedPreferences.getLock() ? UnlockOption.yes : UnlockOption.no,
      lockTimeout: loadedPreferences.getLockTimeout(),
    );
  }

  @override
  Future<void> setSettings(AuthenticationSettings settings) async {
    (await preferences).setAuthMethod(
      AuthenticationMethod(settings.authenticationMethod),
    );
    (await preferences).setPinPadShuffle(
      settings.pinPadShuffle,
    );
    (await preferences).setLock(settings.lock == UnlockOption.yes);
    (await preferences).setLockTimeout(
      settings.lockTimeout,
    );
  }
}
