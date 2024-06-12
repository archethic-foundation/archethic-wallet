import 'dart:convert';

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/infrastructure/datasources/hive.extension.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:pointycastle/export.dart';

part 'lib/password_vault_cipher.dart';
part 'lib/simple_vault_cipher.dart';
part 'lib/vault.encrypted_securedkey_extension.dart';
part 'lib/vault.raw_securedkey_extension.dart';

abstract class VaultCipher {
  Future<Uint8List> get();

  Future<void> updateSecureKey(
    String newPassword,
  );
}

abstract class VaultCipherFactory {
  factory VaultCipherFactory() =>
      kIsWeb ? PasswordVaultCipherFactory() : SimpleVaultCipherFactory();

  VaultCipher build(String password);

  Future<bool> get isSetup;

  Future<void> clear();
}

class PasswordVaultCipherFactory implements VaultCipherFactory {
  @override
  VaultCipher build(String password) => PasswordVaultCipher(
        passphrase: password,
      );

  @override
  Future<bool> get isSetup => PasswordVaultCipher.isSetup;

  @override
  Future<void> clear() => PasswordVaultCipher.clear();
}

class SimpleVaultCipherFactory implements VaultCipherFactory {
  @override
  VaultCipher build(String password) => SimpleVaultCipher();

  @override
  Future<void> clear() => SimpleVaultCipher.clear();

  @override
  Future<bool> get isSetup => SimpleVaultCipher.isSetup;
}

typedef VaultPassphraseDelegate = Future<String> Function();
typedef VaultAutolockDelegate = Future<bool> Function();

class Vault {
  Vault._({VaultCipherFactory? cipherFactory}) {
    _cipherFactory = cipherFactory ?? VaultCipherFactory();
  }

  factory Vault.instance({VaultCipherFactory? cipherFactory}) {
    Vault._instance ??= Vault._(cipherFactory: cipherFactory);
    return Vault._instance!;
  }

  @visibleForTesting
  static Future<void> reset() async {
    Vault._instance = null;
    await Hive.deleteFromDisk();
  }

  late final VaultCipherFactory _cipherFactory;

  static final _logger = Logger('Vault');

  static Vault? _instance;

  VaultPassphraseDelegate? passphraseDelegate;
  VaultAutolockDelegate? shouldBeLocked;
  VaultCipher? _vaultCipher;

  final isLocked = ValueNotifier(true);

  Future<HiveCipher> get encryptionCipher async {
    if (_vaultCipher == null) throw const Failure.locked();
    return HiveAesCipher(await _vaultCipher!.get());
  }

  Future<void> lock() async {
    _logger.info(
      'Locking vault',
    );
    await Hive.close();
    _vaultCipher = null;
    isLocked.value = true;
  }

  Future<void> unlock(String password) async {
    _logger.info(
      'Unlocking vault',
    );
    _vaultCipher = _cipherFactory.build(password);

    // Ensures we are able to retrieve the encryption key
    await _vaultCipher!.get();
    isLocked.value = false;
    _logger.info(
      'Vault unlocked',
    );
  }

  Future<bool> get isSetup async {
    return _cipherFactory.isSetup;
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
    await _cipherFactory.clear();
    await lock();
  }

  Future<void> updateSecureKey(
    String passphrase,
  ) async {
    _logger.info(
      'Updating vault secure key',
    );
    if (_vaultCipher == null) {
      throw const Failure.locked();
    }
    await _vaultCipher!.updateSecureKey(passphrase);
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
        encryptionCipher: await encryptionCipher,
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
        encryptionCipher: await encryptionCipher,
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

    if (passphraseDelegate == null) {
      throw Exception(
        'Vault.passwordDelegate must be set before opening Boxes.',
      );
    }
    _logger.info(
      'Requesting user action to unlock',
    );
    final passphrase = await passphraseDelegate!();

    await unlock(passphrase);
  }
}
