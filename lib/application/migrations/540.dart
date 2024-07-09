// ignore_for_file: file_names

part of 'migration_manager.dart';

/// Decrypts stored password
/// Indeed that encryption is useless as data are stored in FlutterSecureStorage
final migration_540 = LocalDataMigration(
  minAppVersion: 540,
  run: (ref) async {
    final logger = Logger('DataMigration_RemoveLedgerAuthMethod');

    const _preferencesBox = '_preferencesBox';
    const _kAuthMethod = 'archethic_wallet_auth_method';

    final box = await Hive.openBox<dynamic>(_preferencesBox);
    final authMethod = box.get(_kAuthMethod) as int?;

    if (authMethod != 4) {
      logger.info("AuthMethod doesn't need migration.");
      return;
    }

    await box.put(_kAuthMethod, 3);
    logger.info('AuthMethod fixed.');

    await box.compact();
    await box.close();
  },
);
