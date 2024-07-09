part of '../vault.dart';

mixin VaultSecureKeyEncryption {
  static const kEncryptedSecureKey = 'archethic_wallet_encrypted_secure_key';
  static const kEncryptedSecureKeySalt =
      'archethic_wallet_encrypted_secure_key_salt';

  Future<Uint8List> encrypt(
    FlutterSecureStorage secureStorage,
    String password,
    Uint8List clearSecuredKey,
  ) async {
    final salt =
        await _readSalt(secureStorage) ?? await _initSalt(secureStorage);

    final derivedKey = await _generateKey(password, salt);

    return archethic.aesEncrypt(
      archethic.uint8ListToHex(Uint8List.fromList(clearSecuredKey)),
      derivedKey,
    );
  }

  Future<Uint8List> decrypt(
    FlutterSecureStorage secureStorage,
    String password,
    Uint8List encryptedSecuredKey,
  ) async {
    final salt = await _readSalt(secureStorage);

    if (salt == null) throw const Failure.loggedOut();

    final derivedKey = await _generateKey(password, salt);

    return archethic.aesDecrypt(encryptedSecuredKey, derivedKey);
  }

  Future<String> _initSalt(FlutterSecureStorage secureStorage) async {
    final salt = archethic.generateRandomSeed();

    await secureStorage.write(
      key: kEncryptedSecureKeySalt,
      value: base64UrlEncode(archethic.hexToUint8List(salt)),
    );
    return salt;
  }

  Future<String?> _readSalt(
    FlutterSecureStorage secureStorage,
  ) async {
    final saltBase64 = await secureStorage.read(
      key: kEncryptedSecureKeySalt,
    );

    if (saltBase64 == null) {
      return null;
    }

    return archethic.uint8ListToHex(base64Url.decode(saltBase64));
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
