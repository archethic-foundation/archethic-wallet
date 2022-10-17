part of '../authentication.dart';

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
  Future<int> getFailedPinAttemptsCount() async {
    return (await preferences).getLockAttempts();
  }

  @override
  Future<void> incrementFailedPinAttemptsCount() async {
    (await preferences).incrementLockAttempts();
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
  Future<void> resetFailedPinAttempts() async {
    await (await preferences).resetLockAttempts();
  }

  @override
  Future<void> resetLock() async {
    (await preferences).resetLockDate();
  }

  @override
  Future<void> lock(Duration duration) async {
    (await preferences).setLockDate(DateTime.now().add(duration));
  }
}
