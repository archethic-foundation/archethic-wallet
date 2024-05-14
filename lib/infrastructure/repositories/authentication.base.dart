import 'package:aewallet/domain/models/authentication.dart';
import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/device_unlock_option.dart';

abstract class AuthenticationRepositoryBase
    implements AuthenticationRepositoryInterface {
  Future<HivePreferencesDatasource> get preferences async =>
      HivePreferencesDatasource.getInstance();

  @override
  Future<int> getFailedPinAttempts() async {
    return (await preferences).getLockAttempts();
  }

  @override
  Future<void> incrementFailedAttempts() async {
    return (await preferences).incrementLockAttempts();
  }

  @override
  Future<void> resetFailedAttempts() async {
    return (await preferences).resetLockAttempts();
  }

  @override
  Future<void> resetLock() async {
    return (await preferences).removeLockDate();
  }

  @override
  Future<DateTime?> getLockUntilDate() async {
    return (await preferences).getLockDate();
  }

  @override
  Future<void> lock(Duration duration) async {
    return (await preferences).setLockDate(DateTime.now().add(duration));
  }

  @override
  Future<DateTime?> getLastInteractionDate() async {
    return (await preferences).getLastInteractionDate();
  }

  @override
  Future<void> setLastInteractionDate(DateTime newAutoLockDate) async {
    return (await preferences).setLastInteractionDate(newAutoLockDate);
  }

  @override
  Future<void> removeLastInteractionDate() async {
    return (await preferences).clearLastInteractionDate();
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
    final syncPrefs = await preferences;
    await syncPrefs.setAuthMethod(
      AuthenticationMethod(settings.authenticationMethod),
    );
    await syncPrefs.setPinPadShuffle(
      settings.pinPadShuffle,
    );
    await syncPrefs.setLock(settings.lock == UnlockOption.yes);
    await syncPrefs.setLockTimeout(
      settings.lockTimeout,
    );
  }
}
