part of '../vault.dart';

/// Used on Web platform only.
///
/// Helpers to store [Vault] encryption data :
///   - [kEncryptedSecureKey] : AES key encrypted with user password
///   - [kEncryptedSecureKeySalt] : AES key encryption salt
///
extension HiveEncryptedSecuredKey on HiveInterface {
  static const kEncryptedSecureKey = 'archethic_wallet_encrypted_secure_key';
  static const kEncryptedSecureKeySalt =
      'archethic_wallet_encrypted_secure_key_salt';

  Future<Uint8List> updateAndStoreEncryptedSecureKey(
    FlutterSecureStorage secureStorage,
    Uint8List hiveKey,
    String newPassword,
  ) async {
    final salt = archethic.generateRandomSeed();
    final encryptedKey = await encryptSecureKey(
      salt,
      newPassword,
      hiveKey,
    );

    await secureStorage.write(
      key: kEncryptedSecureKey,
      value: base64UrlEncode(encryptedKey.toList()),
    );
    await secureStorage.write(
      key: kEncryptedSecureKeySalt,
      value: base64UrlEncode(archethic.hexToUint8List(salt)),
    );

    return Uint8List.fromList(hiveKey);
  }

  Future<Uint8List> generateAndStoreEncryptedSecureKey(
    FlutterSecureStorage secureStorage,
    String password,
  ) async {
    final salt = archethic.generateRandomSeed();

    final hiveKey = Hive.generateSecureKey();
    final encryptedKey = await encryptSecureKey(
      salt,
      password,
      Uint8List.fromList(hiveKey),
    );

    await secureStorage.write(
      key: kEncryptedSecureKey,
      value: base64UrlEncode(encryptedKey.toList()),
    );
    await secureStorage.write(
      key: kEncryptedSecureKeySalt,
      value: base64UrlEncode(archethic.hexToUint8List(salt)),
    );

    return Uint8List.fromList(hiveKey);
  }

  Future<bool> isEncryptedSecureKeyDefined(
    FlutterSecureStorage secureStorage,
  ) async {
    final keyDefined = await secureStorage.containsKey(
      key: kEncryptedSecureKey,
    );
    final keySaltDefined = await secureStorage.containsKey(
      key: kEncryptedSecureKeySalt,
    );

    return keyDefined && keySaltDefined;
  }

  Future<void> clearEncryptedSecureKey(
    FlutterSecureStorage secureStorage,
  ) =>
      secureStorage.delete(key: kEncryptedSecureKey);

  Future<Uint8List?> readEncryptedSecureKey(
    FlutterSecureStorage secureStorage,
    String password,
  ) async {
    final encryptedKeyBase64 = await secureStorage.read(
      key: kEncryptedSecureKey,
    );
    final saltBase64 = await secureStorage.read(
      key: kEncryptedSecureKeySalt,
    );

    if (encryptedKeyBase64 == null || saltBase64 == null) {
      return null;
    }

    final encryptedKey = base64Url.decode(encryptedKeyBase64);
    final salt = archethic.uint8ListToHex(base64Url.decode(saltBase64));

    final decryptedKey = decryptSecureKey(salt, password, encryptedKey);

    return decryptedKey;
  }

  Future<Uint8List> encryptSecureKey(
    String salt,
    String password,
    Uint8List clearSecuredKey,
  ) async {
    final derivedKey = await _generateKey(password, salt);

    return archethic.aesEncrypt(
      archethic.uint8ListToHex(Uint8List.fromList(clearSecuredKey)),
      derivedKey,
    );
  }

  Future<Uint8List?> decryptSecureKey(
    String salt,
    String password,
    Uint8List encryptedSecuredKey,
  ) async {
    final derivedKey = await _generateKey(password, salt);

    return archethic.aesDecrypt(encryptedSecuredKey, derivedKey);
  }

  Future<Uint8List> _generateKey(
    String password,
    String salt, {
    int iterations = Argon2Parameters.DEFAULT_ITERATIONS,
    int derivedKeyLength = 32,
  }) =>
      compute(
        (_) {
          final passwordBytes = utf8.encode(password);
          final saltBytes = utf8.encode(salt);

          final derivator = KeyDerivator('argon2')
            ..init(
              Argon2Parameters(
                Argon2Parameters.ARGON2_id,
                saltBytes,
                desiredKeyLength: derivedKeyLength,
                iterations: iterations,
              ),
            );

          return derivator.process(passwordBytes);
        },
        null,
      );
}
