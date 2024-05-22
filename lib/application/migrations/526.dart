// ignore_for_file: file_names

part of 'migration_manager.dart';

/// Decrypts stored password
/// Indeed that encryption is useless as data are stored in FlutterSecureStorage
final migration_526 = LocalDataMigration(
  minAppVersion: 526,
  run: (ref) async {
    const logName = 'DataMigration_EncryptedPassword';

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
        log('No password to migrate', name: logName);
        return;
      }

      final seed = sourceBox.get(_kSeed);
      if (seed == null) {
        log('No password to migrate', name: logName);
        return;
      }

      try {
        final rawPassword = stringDecryptBase64(
          encryptedPassword,
          seed,
        );
        await destinationBox.put(_kPassword, rawPassword);
        await sourceBox.delete(_kPassword);

        log('Password migrated', name: logName);
      } catch (e) {
        log('Password decryption failed', name: logName);
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
        log('No $key to migrate', name: logName);
        return;
      }

      await destinationBox.put(key, data);
      await sourceBox.delete(key);
      log('$key migrated', name: logName);
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
        log('Unable to open box', name: logName);
        return null;
      }
    }

    final sourceBox = await _openSecuredBox(_kSourceBox);
    final destinationBox = await _openSecuredBox(_kDestinationBox);

    if (destinationBox == null) {
      throw Exception('Unable to create $_kDestinationBox box');
    }

    if (sourceBox == null) {
      log('No authentication data to migrate', name: logName);
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
