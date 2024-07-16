import 'dart:io';

import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;

@GenerateNiceMocks([MockSpec<VaultCipherDelegate>()])
import 'vault_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Vault',
    () {
      late Vault vault;
      late MockVaultCipherDelegate cipherDelegate;
      setUp(() async {
        vault = Vault.instance();
        Hive.init('${Directory.current.path}/test/tmp_data');
        await Vault.reset();
        FlutterSecureStorage.setMockInitialValues({});
      });

      void _setupCipherDelegate() {
        cipherDelegate = MockVaultCipherDelegate();
        mockito
            .when(
              cipherDelegate.decode(
                mockito.any,
                mockito.any,
              ),
            )
            .thenAnswer(
              (invocation) async => invocation.positionalArguments[0],
            );
        mockito
            .when(
              cipherDelegate.encode(
                mockito.any,
                mockito.any,
              ),
            )
            .thenAnswer(
              (invocation) async => invocation.positionalArguments[0],
            );
      }

      Future<void> _initVault() async {
        _setupCipherDelegate();

        await vault.initCipher(cipherDelegate);
      }

      test(
        'Should throw when storage not initialized',
        () async {
          // GIVEN
          _setupCipherDelegate();
          vault.cipherDelegate = cipherDelegate;
          const boxName = 'abox';

          // WHEN

          // THEN
          expect(
            () => vault.openBox<String>(boxName),
            throwsA(anything),
          );
        },
      );

      test(
        'Should encode AES key on storage initialisation',
        () async {
          // GIVEN
          _setupCipherDelegate();

          // WHEN
          await vault.initCipher(cipherDelegate);

          // THEN
          mockito.verify(cipherDelegate.encode(mockito.any, true)).called(1);
        },
      );

      test(
        'Should encode AES key on cipher delegate update',
        () async {
          // GIVEN
          _setupCipherDelegate();
          await vault.initCipher(cipherDelegate);

          // WHEN
          _setupCipherDelegate();
          await vault.updateCipher(cipherDelegate);

          // THEN
          mockito.verify(cipherDelegate.encode(mockito.any, true)).called(1);
        },
      );

      test(
        'Should decode AES key when opening the vault [box]',
        () async {
          // GIVEN
          await _initVault();
          await vault.lock();
          const boxName = 'abox';

          // WHEN
          final box = await vault.openBox<String>(boxName);

          // THEN
          expect(box, const TypeMatcher<Box<String>>());
          mockito.verify(cipherDelegate.decode(mockito.any, false)).called(1);
        },
      );

      test(
        'Should decode AES key when opening the vault [lazybox]',
        () async {
          // GIVEN
          await _initVault();
          await vault.lock();
          const boxName = 'abox';

          // WHEN
          final box = await vault.openLazyBox<String>(boxName);

          // THEN
          expect(box, const TypeMatcher<LazyBox<String>>());
          mockito.verify(cipherDelegate.decode(mockito.any, false)).called(1);
        },
      );

      test(
        'Should not decode AES key when Vault already unlocked',
        () async {
          // GIVEN
          await _initVault();
          const boxName = 'abox';

          // WHEN
          final box = await vault.openLazyBox<String>(boxName);

          // THEN
          expect(box, const TypeMatcher<LazyBox<String>>());
          mockito.verifyNever(cipherDelegate.decode(mockito.any, false));
        },
      );
    },
  );
}
