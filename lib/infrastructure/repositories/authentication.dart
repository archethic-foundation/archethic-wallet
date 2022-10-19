import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/vault.dart';

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  Vault? _vault;
  Future<Vault> get vault async => _vault ??= await Vault.getInstance();

  Preferences? _preferences;
  Future<Preferences> get preferences async =>
      _preferences ??= await Preferences.getInstance();

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

  Future<DateTime?> getLockDate() async {
    return (await preferences).getLockDate();
  }

  @override
  Future<void> lock(Duration duration) async {
    (await preferences).setLockDate(DateTime.now().add(duration));
  }

  @override
  Future<AuthenticationSettings> getSettings() async => AuthenticationSettings(
        authenticationMethod: (await preferences).getAuthMethod().method,
        pinPadShuffle: (await preferences).getPinPadShuffle(),
      );

  @override
  Future<void> setSettings(AuthenticationSettings settings) async {
    (await preferences).setAuthMethod(
      AuthenticationMethod(settings.authenticationMethod),
    );
    (await preferences).setPinPadShuffle(
      settings.pinPadShuffle,
    );
  }
}
