import 'dart:typed_data';

import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:aewallet/infrastructure/repositories/authentication.base.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationRepositoryWeb extends AuthenticationRepositoryBase
    with VaultSecureKeyEncryption
    implements AuthenticationRepositoryInterface {
  final secureStorage = const FlutterSecureStorage();

  @override
  Future<void> clear() async {
    await resetFailedAttempts();
    await resetLock();
  }

  @override
  Future<Uint8List> decodeWithPassword(
    String password,
    Uint8List challenge,
  ) async {
    return decrypt(secureStorage, password, challenge);
  }

  @override
  Future<Uint8List> encodeWithPassword(
    String password,
    Uint8List challenge,
  ) async {
    return encrypt(secureStorage, password, challenge);
  }

  @override
  Future<Uint8List> decodeWithPin(
    String pin,
    Uint8List challenge,
  ) async {
    return decrypt(secureStorage, pin, challenge);
  }

  @override
  Future<Uint8List> encodeWithPin(
    String pin,
    Uint8List challenge,
  ) async {
    return encrypt(secureStorage, pin, challenge);
  }
}
