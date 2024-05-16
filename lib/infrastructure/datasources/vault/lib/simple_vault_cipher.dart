part of '../vault.dart';

/// Encryption key is AES encrypted before storage
class SimpleVaultCipher implements VaultCipher {
  static Future<bool> get isSetup => Hive.isSecureKeyDefined(
        const FlutterSecureStorage(),
      );

  static Future<void> clear() => Hive.clearSecureKey(
        const FlutterSecureStorage(),
      );

  @override
  Future<Uint8List> get() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKey = await Hive.readSecureKey(secureStorage) ??
        await Hive.generateAndStoreSecureKey(secureStorage);

    return encryptionKey;
  }

  @override
  Future<void> updateSecureKey(
    String newPassword,
  ) async {}
}
