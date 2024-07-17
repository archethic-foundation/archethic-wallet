// ignore_for_file: file_names

part of 'migration_manager.dart';

/// Decrypts stored password
/// Indeed that encryption is useless as data are stored in FlutterSecureStorage
final migration_541 = LocalDataMigration(
  minAppVersion: 541,
  run: (ref) async {
    final logger = Logger('DataMigration_MoveVaultKey');

    const kEncryptedSecureKey = 'archethic_wallet_encrypted_secure_key';
    const kSecureKey = 'archethic_wallet_secure_key';

    const secureStorage = FlutterSecureStorage();

    final key = await secureStorage.read(key: kSecureKey);
    if (key == null) {
      logger.info('No Vault key to migrate');
      return;
    }
    logger.info('Migrating Vault key');
    await secureStorage.write(key: kEncryptedSecureKey, value: key);
    await secureStorage.delete(key: kSecureKey);
  },
);
