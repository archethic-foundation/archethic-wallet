// ignore_for_file: file_names

part of 'migration_manager.dart';

/// Decrypts stored password
/// Indeed that encryption is useless as data are stored in FlutterSecureStorage
final migration_541 = LocalDataMigration(
  minAppVersion: 541,
  run: (ref) async {
    final logger = Logger('DataMigration_MoveVaultKey');

    const kEncryptedVaultSecureKey = 'archethic_wallet_encrypted_secure_key';
    const kVaultSecureKey = 'archethic_wallet_secure_key';
    const kNonWebAuthenticationSecureKey =
        'archethic_wallet_authent_secure_key';
    const secureStorage = FlutterSecureStorage();

    Future<void> _migrateVaultSecureKey() async {
      final key = await secureStorage.read(key: kVaultSecureKey);
      if (key == null) {
        logger.info('No Vault key to migrate');
        return;
      }
      logger.info('Migrating Vault key');
      await secureStorage.write(key: kEncryptedVaultSecureKey, value: key);
    }

    Future<void> _migrateNonWehAuthentSecureKey() async {
      final key = await secureStorage.read(key: kVaultSecureKey);
      if (key == null) {
        logger.info('No NonWebAuthent secure key to migrate');
        return;
      }
      logger.info('Migrating NonWebAuthent secure key');
      await secureStorage.write(
        key: kNonWebAuthenticationSecureKey,
        value: key,
      );
    }

    await _migrateVaultSecureKey();

    await _migrateNonWehAuthentSecureKey();

    await secureStorage.delete(key: kVaultSecureKey);
  },
);
