// ignore_for_file: file_names

part of 'migration_manager.dart';

/// Decrypts stored password
/// Indeed that encryption is useless as data are stored in FlutterSecureStorage
final migration_526 = LocalDataMigration(
  minAppVersion: 526,
  run: (ref) async {
    const logName = 'DataMigration_EncryptedPassword';

    final box = await _openSecuredBox(_kVaultBox);

    if (box == null) {
      log('No password to migrate', name: logName);
      return;
    }

    final encryptedPassword = box.get(_kPassword);
    if (encryptedPassword == null) {
      log('No password to migrate', name: logName);
      return;
    }

    final seed = box.get(_kSeed);
    if (seed == null) {
      log('No password to migrate', name: logName);
      return;
    }

    try {
      final rawPassword = stringDecryptBase64(
        encryptedPassword,
        seed,
      );
      await box.put(_kPassword, rawPassword);
      await box.compact();
      await box.close();
    } catch (e) {
      log('Password decryption failed', name: logName);
      return;
    }
  },
);

const String _kVaultBox = '_vaultBox';
const String _kPassword = 'archethic_wallet_password';
const String _kSeed = 'archethic_wallet_seed';

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

Future<HiveCipher?> _prepareCipher() async {
  const secureStorage = FlutterSecureStorage();
  final encryptionKey = await Hive.readSecureKey(secureStorage);

  if (encryptionKey == null) return null;
  return HiveAesCipher(encryptionKey);
}
