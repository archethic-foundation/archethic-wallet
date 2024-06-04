import 'dart:convert';
import 'dart:developer';

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/infrastructure/datasources/hive.extension.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  static const _logName = 'Vault';

  static Vault? _instance;

  VaultPassphraseDelegate? passphraseDelegate;
  VaultAutolockDelegate? shouldBeLocked;
  VaultCipher? _vaultCipher;

  Future<HiveCipher> get encryptionCipher async {
    if (_vaultCipher == null) throw const Failure.locked();
    return HiveAesCipher(await _vaultCipher!.get());
  }

  Future<void> lock() async {
    log(
      'Locking vault',
      name: _logName,
    );
    await Hive.close();
    _vaultCipher = null;
  }

  Future<void> unlock(String password) async {
    log(
      'Unlocking vault',
      name: _logName,
    );
    _vaultCipher = _cipherFactory.build(password);

    // Ensures we are able to retrieve the encryption key
    await _vaultCipher!.get();
    log(
      'Vault unlocked',
      name: _logName,
    );
  }

  Future<bool> get isSetup async {
    return _cipherFactory.isSetup;
  }

  Future<bool> boxExists(String name) {
    return Hive.boxExists(name);
  }

  Future<void> clear<E>(String name) async {
    log(
      'Deleting vault box $name...',
      name: _logName,
    );
    await Hive.deleteBox<E>(name);
    log(
      '... vault box $name deleted',
      name: _logName,
    );
  }

  Future<void> clearSecureKey() async {
    log(
      'Clearing vault secure key',
      name: _logName,
    );
    await _cipherFactory.clear();
    await lock();
  }

  Future<void> updateSecureKey(
    String passphrase,
  ) async {
    log(
      'Updating vault secure key',
      name: _logName,
    );
    if (_vaultCipher == null) {
      throw const Failure.locked();
    }
    await _vaultCipher!.updateSecureKey(passphrase);
  }

  Future<Box<E>> openBox<E>(
    String name,
  ) async {
    log(
      'Opening box $name',
      name: _logName,
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
      log(
        'Failed to open Hive encrypted Box<$E>($name).',
        error: e,
        stackTrace: stack,
        name: _logName,
      );
      rethrow;
    }
  }

  Future<LazyBox<E>> openLazyBox<E>(
    String name,
  ) async {
    log(
      'Opening lazy box $name',
      name: _logName,
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
      log(
        'Failed to open Hive encrypted Lazy Box<$E>($name).',
        error: e,
        stackTrace: stack,
        name: _logName,
      );
      rethrow;
    }
  }

  Future<void> applyAutolock() async {
    if (shouldBeLocked == null || await shouldBeLocked!() == false) return;
    log(
      'Apply autolock to Vault.',
      name: _logName,
    );
    await lock();
  }

  Future<void> ensureVaultIsUnlocked() async {
    if (_vaultCipher != null) {
      log(
        'Vault already unlocked.',
        name: _logName,
      );

      return;
    }

    if (passphraseDelegate == null) {
      throw Exception(
        'Vault.passwordDelegate must be set before opening Boxes.',
      );
    }
    log(
      'Requesting user action to unlock',
      name: _logName,
    );
    final passphrase = await passphraseDelegate!();

    await unlock(passphrase);
  }
}
