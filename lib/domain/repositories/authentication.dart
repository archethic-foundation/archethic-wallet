import 'dart:typed_data';

import 'package:aewallet/domain/models/authentication.dart';

abstract class AuthenticationRepositoryInterface {
  Future<void> clear();

  Future<void> resetFailedAttempts();
  Future<int> getFailedAttempts();
  Future<void> incrementFailedAttempts();

  Future<Uint8List> decodeWithPassword(
    String password,
    Uint8List challenge,
  );
  Future<Uint8List> encodeWithPassword(
    String password,
    Uint8List challenge,
  );

  Future<Uint8List> decodeWithPin(
    String pin,
    Uint8List challenge,
  );
  Future<Uint8List> encodeWithPin(
    String pin,
    Uint8List challenge,
  );

  Future<void> setYubikey({
    required String clientId,
    required String clientApiKey,
  });

  Future<void> lock(Duration duration);
  Future<void> resetLock();
  Future<DateTime?> getLockUntilDate();

  Future<AuthenticationSettings> getSettings();
  Future<void> setSettings(AuthenticationSettings settings);

  Future<DateTime?> getLastInteractionDate();
  Future<void> setLastInteractionDate(DateTime lastInteractionDate);
  Future<void> removeLastInteractionDate();
}
