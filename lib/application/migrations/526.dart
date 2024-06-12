// ignore_for_file: file_names

part of 'migration_manager.dart';

/// Decrypts stored password
/// Indeed that encryption is useless as data are stored in FlutterSecureStorage
final migration_526 = LocalDataMigration(
  minAppVersion: 526,
  run: (ref) async {
    final logger = Logger('DataMigration_EncryptedPassword');

    const _kSourceBox = '_vaultBox';
    const _kDestinationBox = 'NonWebAuthentication';
    const _kPassword = 'archethic_wallet_password';
    const _kSeed = 'archethic_wallet_seed';
    const _kPin = 'archethic_wallet_pin';
    const _kYubikeyClientID = 'archethic_wallet_yubikeyClientID';
    const _kYubikeyClientAPIKey = 'archethic_wallet_yubikeyClientAPIKey';

    Future<void> _migratePassword(Box sourceBox, Box destinationBox) async {
      final encryptedPassword = sourceBox.get(_kPassword);
      if (encryptedPassword == null) {
        logger.info('No password to migrate');
        return;
      }

      final seed = sourceBox.get(_kSeed);
      if (seed == null) {
        logger.info('No password to migrate');
        return;
      }

      try {
        final rawPassword = stringDecryptBase64(
          encryptedPassword,
          seed,
        );
        await destinationBox.put(_kPassword, rawPassword);
        await sourceBox.delete(_kPassword);

        logger.info('Password migrated');
      } catch (e) {
        logger.severe('Password decryption failed');
        return;
      }
    }

    Future<void> _migrateRawData(
      Box sourceBox,
      Box destinationBox,
      String key,
    ) async {
      final data = sourceBox.get(key);
      if (data == null) {
        logger.info('No $key to migrate');
        return;
      }

      await destinationBox.put(key, data);
      await sourceBox.delete(key);
      logger.info('$key migrated');
    }

    Future<HiveCipher?> _prepareCipher() async {
      const secureStorage = FlutterSecureStorage();
      final encryptionKey = await Hive.readSecureKey(secureStorage);

      if (encryptionKey == null) return null;
      return HiveAesCipher(encryptionKey);
    }

    Future<Box<String>?> _openSecuredBox(
      String name,
    ) async {
      try {
        final cipher = await _prepareCipher();
        if (cipher == null) return null;

        return Hive.openBox<String>(
          name,
          encryptionCipher: cipher,
        );
      } catch (e) {
        logger.severe('Unable to open box');
        return null;
      }
    }

    final sourceBox = await _openSecuredBox(_kSourceBox);
    final destinationBox = await _openSecuredBox(_kDestinationBox);

    if (destinationBox == null) {
      throw Exception('Unable to create $_kDestinationBox box');
    }

    if (sourceBox == null) {
      logger.info('No authentication data to migrate');
      return;
    }

    await _migratePassword(sourceBox, destinationBox);
    await _migrateRawData(sourceBox, destinationBox, _kPin);
    await _migrateRawData(sourceBox, destinationBox, _kYubikeyClientAPIKey);
    await _migrateRawData(sourceBox, destinationBox, _kYubikeyClientID);

    await destinationBox.compact();
    await destinationBox.close();

    await sourceBox.compact();
    await sourceBox.close();
  },
);
