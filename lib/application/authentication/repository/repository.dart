part of '../authentication.dart';

abstract class AuthenticationRepositoryInterface {
  Future<String?> getPin();
  Future<void> setPin(String pin);
  Future<void> resetFailedPinAttempts();
  Future<int> getFailedPinAttemptsCount();
  Future<void> incrementFailedPinAttemptsCount();

  Future<String?> getPassword();
  Future<void> setPassword(String password);

  Future<void> lock(Duration duration);
  Future<void> resetLock();

  // Future<int> getAttemptsCount();
  //   int get attemptsCount;
  // int get maxAttemptsAccepted;

}
