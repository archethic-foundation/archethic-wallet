import 'package:aewallet/domain/models/authentication.dart';

abstract class AuthenticationRepositoryInterface {
  Future<String?> getPin();
  Future<void> setPin(String pin);
  Future<void> resetFailedAttempts();
  Future<int> getFailedPinAttempts();
  Future<void> incrementFailedAttempts();

  Future<String?> getPassword();
  Future<void> setPassword(String password);

  Future<void> lock(Duration duration);
  Future<void> resetLock();
  Future<DateTime?> getLockUntilDate();

  Future<AuthenticationSettings> getSettings();
  Future<void> setSettings(AuthenticationSettings settings);

  Future<DateTime?> getLastInteractionDate();
  Future<void> setLastInteractionDate(DateTime lastInteractionDate);
  Future<void> removeLastInteractionDate();
}
