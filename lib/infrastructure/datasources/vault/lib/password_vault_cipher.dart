part of '../vault.dart';

/// Encryption key is AES encrypted before storage
class PasswordVaultCipher implements VaultCipher {
  PasswordVaultCipher({required this.passphrase});

  final String passphrase;

  Uint8List? _key;

  static Future<bool> get isSetup => Hive.isEncryptedSecureKeyDefined(
        const FlutterSecureStorage(),
      );

  static Future<void> clear() => Hive.clearEncryptedSecureKey(
        const FlutterSecureStorage(),
      );

  @override
  Future<Uint8List> get() async => _key ?? (_key = await _genKey());

  Future<Uint8List> _genKey() async {
    const secureStorage = FlutterSecureStorage();

    final encryptionKey = await Hive.readEncryptedSecureKey(
          secureStorage,
          passphrase,
        ) ??
        await Hive.generateAndStoreEncryptedSecureKey(
          secureStorage,
          passphrase,
        );

    return encryptionKey;
  }

  @override
  Future<void> updateSecureKey(
    String newPassword,
  ) async {
    const secureStorage = FlutterSecureStorage();

    await Hive.updateAndStoreEncryptedSecureKey(
      secureStorage,
      await get(),
      newPassword,
    );
  }
}
