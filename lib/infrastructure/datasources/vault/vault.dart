import 'dart:async';
import 'dart:convert';

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/infrastructure/datasources/hive.extension.dart';
import 'package:aewallet/ui/util/singleton_task.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:pointycastle/export.dart';

part 'lib/vault.encrypted_securedkey_extension.dart';

abstract class VaultCipherDelegate {
  Future<Uint8List?> encode(Uint8List payload, bool userCancelable);
  Future<Uint8List?> decode(Uint8List payload, bool userCancelable);
}

typedef VaultAutolockDelegate = Future<bool> Function();

class VaultCipher {
  VaultCipher(this.key);

  final Uint8List key;

  HiveCipher get hiveCipher => HiveAesCipher(key);
}

class Vault {
  Vault._();

  factory Vault.instance() {
    Vault._instance ??= Vault._();
    return Vault._instance!;
  }

  @visibleForTesting
  static Future<void> reset() async {
    Vault._instance = null;
    await Hive.deleteFromDisk();
  }

  static final _logger = Logger('Vault');

  static Vault? _instance;

  VaultAutolockDelegate? shouldBeLocked;
  VaultCipher? _vaultCipher;
  VaultCipherDelegate? _cipherDelegate;

  VaultCipher get _vaultCipherOrThrow {
    if (_vaultCipher == null) throw const Failure.locked();

    return _vaultCipher!;
  }

  VaultCipherDelegate get _cipherDelegateOrThrow {
    if (_cipherDelegate == null) {
      throw Exception(
        'Vault.cipherDelegate must be set before opening Boxes.',
      );
    }

    return _cipherDelegate!;
  }

  final isLocked = ValueNotifier(true);

  SingletonTask<void>? __lockTask;
  SingletonTask<void> get _lockTask => __lockTask ??= SingletonTask<void>(
        name: 'Vault lock task',
        task: () async {
          await Hive.close();
          _vaultCipher = null;
          isLocked.value = true;
        },
      );

  Future<void> lock() async {
    _logger.info(
      'Locking vault',
    );
    return _lockTask.run();
  }

  SingletonTask<void>? __unlockTask;
  SingletonTask<void> get _unlockTask => __unlockTask ??= SingletonTask<void>(
        name: 'Vault unlock task',
        task: () async {
          /// If a verify operation is running, wait for it to finish.
          /// This is to prevent stacking multiple unlock operations.
          final verifyUnlockResult = await _verifyUnlockAbilityTask.wait;
          if (verifyUnlockResult == true) {
            _logger.info(
              'Vault already unlocked',
            );
            return;
          }

          final encryptedKey = await readEncryptedKey();

          if (encryptedKey == null) {
            _logger.info(
              'Abort : Vault not initialized.',
            );
            throw const Failure.invalidValue();
          }

          final key = await _cipherDelegateOrThrow.decode(encryptedKey, false);
          if (key == null) {
            _logger.info(
              'Abort : User canceled operation.',
            );

            throw const Failure.operationCanceled();
          }
          _vaultCipher = VaultCipher(
            key,
          );

          isLocked.value = false;
          _logger.info(
            'Vault unlocked',
          );
        },
      );

  Future<void> unlock() async {
    _logger.info(
      'Unlocking vault',
    );

    return _unlockTask.run();
  }

  SingletonTask<bool>? __verifyUnlockAbilityTask;
  SingletonTask<bool> get _verifyUnlockAbilityTask =>
      __verifyUnlockAbilityTask ??= SingletonTask<bool>(
        name: 'Verify unlock ability task',
        task: () async {
          try {
            final encryptedKey = await readEncryptedKey();

            if (encryptedKey == null) {
              _logger.info(
                'Abort : Vault not initialized.',
              );
              throw const Failure.locked();
            }

            final decodedChallenge =
                await _cipherDelegateOrThrow.decode(encryptedKey, true);

            final canBeUnlocked = decodedChallenge != null;
            _logger.info(
              'Vault ${canBeUnlocked ? 'can' : 'cannot'} be unlocked.',
            );

            /// Unlocks in a preventive way.
            /// In case a lock occured during the process.
            if (decodedChallenge != null) {
              _vaultCipher = VaultCipher(
                decodedChallenge,
              );

              isLocked.value = false;
              _logger.info(
                'Vault unlocked',
              );
            }

            return canBeUnlocked;
          } catch (e) {
            return false;
          }
        },
      );

  Future<bool> verifyUnlockAbility() async {
    _logger.info(
      'Verify unlock ability',
    );
    return _verifyUnlockAbilityTask.run();
  }

  Future<bool> get isSetup async {
    return (await readEncryptedKey()) != null;
  }

  Future<bool> boxExists(String name) {
    return Hive.boxExists(name);
  }

  Future<void> clear<E>(String name) async {
    _logger.info(
      'Deleting vault box $name...',
    );
    await Hive.deleteBox<E>(name);
    _logger.info(
      '... vault box $name deleted',
    );
  }

  Future<void> clearSecureKey() async {
    _logger.info(
      'Clearing vault secure key',
    );
    await _clearEncryptedKey();
    await lock();
  }

  VaultCipherDelegate? get cipherDelegate => _cipherDelegate;

  set cipherDelegate(VaultCipherDelegate? cipherDelegate) {
    _logger.info(
      'Set cipher delegate',
    );
    _cipherDelegate = cipherDelegate;
  }

  Future<void> initCipher(VaultCipherDelegate newCipherDelegate) async {
    _logger.info(
      'Init vault secure key',
    );

    final key = Uint8List.fromList(Hive.generateSecureKey());

    final encryptedKey = await newCipherDelegate.encode(
      key,
      true,
    );

    if (encryptedKey == null) throw const Failure.operationCanceled();
    await _writeEncryptedKey(encryptedKey);

    _cipherDelegate = newCipherDelegate;
    _vaultCipher = VaultCipher(
      key,
    );

    isLocked.value = false;
  }

  Future<void> updateCipher(VaultCipherDelegate newCipherDelegate) async {
    _logger.info(
      'Updating vault secure key',
    );
    if (_vaultCipher == null) {
      throw const Failure.locked();
    }

    final encryptedKey = await newCipherDelegate.encode(
      _vaultCipher!.key,
      true,
    );

    if (encryptedKey == null) throw const Failure.operationCanceled();
    await _writeEncryptedKey(encryptedKey);

    _cipherDelegate = newCipherDelegate;
  }

  Future<Box<E>> openBox<E>(
    String name,
  ) async {
    _logger.info(
      'Opening box $name',
    );
    await applyAutolock();
    if (Hive.isBoxOpen(name)) {
      return Hive.box(name);
    }

    try {
      await ensureVaultIsUnlocked();

      return await Hive.openBox<E>(
        name,
        encryptionCipher: _vaultCipherOrThrow.hiveCipher,
      );
    } catch (e, stack) {
      _logger.severe(
        'Failed to open Hive encrypted Box<$E>($name).',
        e,
        stack,
      );
      rethrow;
    }
  }

  Future<LazyBox<E>> openLazyBox<E>(
    String name,
  ) async {
    _logger.info(
      'Opening lazy box $name',
    );

    await applyAutolock();
    if (Hive.isBoxOpen(name)) {
      return Hive.lazyBox(name);
    }

    try {
      await ensureVaultIsUnlocked();

      return await Hive.openLazyBox<E>(
        name,
        encryptionCipher: _vaultCipherOrThrow.hiveCipher,
      );
    } catch (e, stack) {
      _logger.severe(
        'Failed to open Hive encrypted Lazy Box<$E>($name).',
        e,
        stack,
      );
      rethrow;
    }
  }

  Future<void> applyAutolock() async {
    if (shouldBeLocked == null || await shouldBeLocked!() == false) return;
    _logger.info(
      'Apply autolock to Vault.',
    );
    await lock();
  }

  Future<void> ensureVaultIsUnlocked() async {
    if (!isLocked.value) {
      _logger.info(
        'Vault already unlocked.',
      );

      return;
    }

    await unlock();
  }
}

extension VaultKeyDataSource on Vault {
  static const kEncryptedSecureKey = 'archethic_wallet_encrypted_secure_key';
  Future<Uint8List?> readEncryptedKey() async {
    const secureStorage = FlutterSecureStorage();

    final key = await secureStorage.read(key: kEncryptedSecureKey);
    if (key != null) return base64Decode(key);

    return null;
  }

  Future<void> _writeEncryptedKey(Uint8List key) async {
    const secureStorage = FlutterSecureStorage();

    await secureStorage.write(
      key: kEncryptedSecureKey,
      value: base64Encode(key),
    );
  }

  Future<void> _clearEncryptedKey() async {
    const secureStorage = FlutterSecureStorage();

    await secureStorage.delete(
      key: kEncryptedSecureKey,
    );
  }
}
