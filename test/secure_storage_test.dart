import 'dart:typed_data';

import 'package:aewallet/infrastructure/datasources/secured_datasource_mixin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pointycastle/pointycastle.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group(
    'Vault',
    () {
      setUp(() async {
        FlutterSecureStorage.setMockInitialValues({});
      });

      group(
        'Vault key (without password)',
        () {
          test(
            'Should generate & read Vault encryption key with right password',
            () async {
              const secureStorage = FlutterSecureStorage();
              final expectedEncryptionKey =
                  await Hive.generateAndStoreSecureKey(
                secureStorage,
              );

              final readEncryptionKey = await Hive.readSecureKey(
                secureStorage,
              );

              expect(readEncryptionKey, expectedEncryptionKey);
            },
          );
        },
      );

      group(
        'Vault key with password creation',
        () {
          test(
            'Should generate & read Vault encryption key with right password',
            () async {
              const secureStorage = FlutterSecureStorage();
              final expectedEncryptionKey =
                  await Hive.generateAndStoreEncryptedSecureKey(
                secureStorage,
                'password_ok',
              );

              final readEncryptionKey = await Hive.readEncryptedSecureKey(
                secureStorage,
                'password_ok',
              );

              expect(readEncryptionKey, expectedEncryptionKey);
            },
          );

          test(
            'Should throw InvalidCipherTextException when reading Vault encryption key with wrong password',
            () async {
              const secureStorage = FlutterSecureStorage();
              await Hive.generateAndStoreEncryptedSecureKey(
                secureStorage,
                'password_ok',
              );

              expect(
                () async => Hive.readEncryptedSecureKey(
                  secureStorage,
                  'wrong_password',
                ),
                throwsA(isA<InvalidCipherTextException>()),
              );
            },
          );
        },
      );
      group(
        'Vault key with password update',
        () {
          test(
            'Should update Vault encryption key password',
            () async {
              const secureStorage = FlutterSecureStorage();
              final expectedEncryptionKey =
                  await Hive.generateAndStoreEncryptedSecureKey(
                secureStorage,
                'previous_password',
              );

              await Hive.updateAndStoreEncryptedSecureKey(
                secureStorage,
                expectedEncryptionKey,
                'new_password',
              );

              final readEncryptionKey = await Hive.readEncryptedSecureKey(
                secureStorage,
                'new_password',
              );

              expect(readEncryptionKey, expectedEncryptionKey);
            },
          );
        },
      );
      group(
        'Secure key encryption key with password & salt',
        () {
          test(
            'Should decrypt securedKey with right salt and password',
            () async {
              final securedKey = Uint8List.fromList([1, 2, 3, 4]);
              final encryptedSecureKey = Hive.encryptSecureKey(
                'salt_ok',
                'password_ok',
                securedKey,
              );
              final decryptedSecureKey = Hive.decryptSecureKey(
                'salt_ok',
                'password_ok',
                encryptedSecureKey,
              );

              expect(decryptedSecureKey, securedKey);
            },
          );

          test(
            'Should throw InvalidCipherTextException when wrong salt and right password',
            () async {
              final encryptedSecureKey = Hive.encryptSecureKey(
                'salt_ok',
                'password_ok',
                Uint8List.fromList([1, 2, 3, 4]),
              );

              expect(
                () async => Hive.decryptSecureKey(
                  'wrong_salt',
                  'password_ok',
                  encryptedSecureKey,
                ),
                throwsA(isA<InvalidCipherTextException>()),
              );
            },
          );

          test(
            'Should throw InvalidCipherTextException when right salt and wrong password',
            () async {
              final encryptedSecuredKey = Hive.encryptSecureKey(
                'salt_ok',
                'password_ok',
                Uint8List.fromList([1, 2, 3, 4]),
              );
              expect(
                () async => Hive.decryptSecureKey(
                  'salt_ok',
                  'wrong_password',
                  encryptedSecuredKey,
                ),
                throwsA(isA<InvalidCipherTextException>()),
              );
            },
          );
        },
      );
    },
  );
}
