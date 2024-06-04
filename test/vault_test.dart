import 'dart:io';

import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pointycastle/export.dart';

@GenerateNiceMocks([MockSpec<VaultDelegate>()])
import 'vault_test.mocks.dart';

class VaultDelegate {
  VaultDelegate();

  Future<String> passwordDelegate() async {
    throw UnimplementedError();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// Enforce usage of the [PasswordVaultCipherFactory].
  /// That way, we actually test the vault key encryption.
  Vault vault() => Vault.instance(cipherFactory: PasswordVaultCipherFactory());

  group(
    'Vault',
    () {
      late MockVaultDelegate vaultDelegate;
      setUp(() async {
        Hive.init('${Directory.current.path}/test/tmp_data');
        await Vault.reset();
        FlutterSecureStorage.setMockInitialValues({});
      });

      void _setupUserInputPassphrase(String passphrase) {
        vaultDelegate = MockVaultDelegate();
        when(vaultDelegate.passwordDelegate())
            .thenAnswer((_) async => passphrase);
        vault().passphraseDelegate = vaultDelegate.passwordDelegate;
      }

      test(
        'Should ask for passphrase when creating the vault [box]',
        () async {
          // GIVEN
          _setupUserInputPassphrase('passphrase');
          const boxName = 'abox';

          // WHEN
          final box = await vault().openBox<String>(boxName);

          // THEN
          expect(box, const TypeMatcher<Box<String>>());
          verify(vaultDelegate.passwordDelegate()).called(1);
        },
      );

      test(
        'Should ask for passphrase when creating the vault [lazybox]',
        () async {
          // GIVEN
          _setupUserInputPassphrase('passphrase');
          const boxName = 'abox';

          // WHEN
          final box = await vault().openLazyBox<String>(boxName);

          // THEN
          expect(box, const TypeMatcher<LazyBox<String>>());
          verify(vaultDelegate.passwordDelegate()).called(1);
        },
      );

      test(
        'Should not ask for passphrase when Vault already unlocked',
        () async {
          // GIVEN
          _setupUserInputPassphrase('passphrase');
          await vault().unlock('passphrase');
          const boxName = 'abox';

          // WHEN
          final box = await vault().openBox<String>(boxName);

          // THEN
          expect(box, const TypeMatcher<Box<String>>());
          verifyNever(vaultDelegate.passwordDelegate());
        },
      );

      test(
        'Should ask for passphrase when Vault locked',
        () async {
          // GIVEN
          _setupUserInputPassphrase('passphrase');
          await vault().unlock('passphrase');
          await vault().lock();

          // WHEN
          final box = await vault().openBox<String>('aBox');

          // THEN
          expect(box, const TypeMatcher<Box<String>>());
          verify(vaultDelegate.passwordDelegate()).called(1);
        },
      );

      test(
        'Should ask for passphrase after clearing secure key',
        () async {
          // GIVEN
          _setupUserInputPassphrase('passphrase');
          await vault().unlock('passphrase');
          await vault().clearSecureKey();

          // WHEN
          final box = await vault().openBox<String>('aBox');

          // THEN
          expect(box, const TypeMatcher<Box<String>>());
          verify(vaultDelegate.passwordDelegate()).called(1);
        },
      );

      test(
        'Should reject data reading with wrong passphrase',
        () async {
          // GIVEN
          _setupUserInputPassphrase('oldPassphrase');

          const boxName = 'box';
          final box = await vault().openBox<String>(boxName);
          await box.put('aKey', 'aValue');

          await vault().updateSecureKey('newPassphrase');
          await vault().lock();

          // WHEN
          expect(
            () => vault().openBox<String>(boxName),
            throwsA(isA<InvalidCipherTextException>()),
          );
        },
      );
    },
  );
}
