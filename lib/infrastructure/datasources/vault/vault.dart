import 'dart:convert';
import 'dart:developer';

import 'package:aewallet/domain/models/core/failures.dart';
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
  factory VaultCipher(String password) {
    return kIsWeb
        ? PasswordVaultCipher(password: password)
        : SimpleVaultCipher();
  }

  static Future<bool> get isSetup async {
    return kIsWeb ? PasswordVaultCipher.isSetup : SimpleVaultCipher.isSetup;
  }

  static Future<void> clear() async {
    return kIsWeb ? PasswordVaultCipher.clear() : SimpleVaultCipher.clear();
  }

  Future<Uint8List> get();

  Future<void> updateSecureKey(
    String newPassword,
  );
}

typedef VaultPasswordDelegate = Future<String> Function();
typedef VaultAutolockDelegate = Future<bool> Function();

class Vault {
  Vault._();

  factory Vault.instance() {
    Vault._instance ??= Vault._();
    return Vault._instance!;
  }

  static const _logName = 'Vault';

  static Vault? _instance;

  VaultPasswordDelegate? passwordDelegate;
  VaultAutolockDelegate? shouldBeLocked;
  VaultCipher? _vaultCipher;

  Future<HiveCipher> get encryptionCipher async {
    if (_vaultCipher == null) throw const Failure.locked();
    return HiveAesCipher(await _vaultCipher!.get());
  }

  void lock() {
    log(
      'Locking vault',
      name: _logName,
    );
    Hive.close();
    _vaultCipher = null;
  }

  Future<void> unlock(String password) async {
    log(
      'Unlocking vault',
      name: _logName,
    );
    _vaultCipher = VaultCipher(password);

    // Ensures we are able to retrieve the encryption key
    await _vaultCipher!.get();
    log(
      'Vault unlocked',
      name: _logName,
    );
  }

  Future<bool> get isSetup async {
    return VaultCipher.isSetup;
  }

  Future<bool> boxExists(String name) {
    return Hive.boxExists(name);
  }

  Future<void> clear(String name) async {
    await Hive.deleteBoxFromDisk(name);
  }

  Future<void> clearSecureKey() async {
    log(
      'Clearing vault secure key',
      name: _logName,
    );
    await VaultCipher.clear();
  }

  Future<void> updateSecureKey(
    String newPassword,
  ) async {
    log(
      'Updating vault secure key',
      name: _logName,
    );
    if (_vaultCipher == null) {
      throw const Failure.locked();
    }
    await _vaultCipher!.updateSecureKey(newPassword);
  }

  Future<Box<E>> openBox<E>(
    String name,
  ) async {
    log(
      'Opening box $name',
      name: _logName,
    );
    await _applyAutolock();
    if (Hive.isBoxOpen(name)) {
      return Hive.box(name);
    }

    try {
      await _ensureVaultIsUnlocked();

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

    await _applyAutolock();
    if (Hive.isBoxOpen(name)) {
      return Hive.lazyBox(name);
    }

    try {
      await _ensureVaultIsUnlocked();

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

  Future<void> _applyAutolock() async {
    if (shouldBeLocked == null || await shouldBeLocked!() == false) return;
    log(
      'Apply autolock to Vault.',
      name: _logName,
    );
    lock();
  }

  Future<void> _ensureVaultIsUnlocked() async {
    if (_vaultCipher != null) return;

    if (passwordDelegate == null) {
      throw Exception(
        'Vault.passwordDelegate must be set before opening Boxes.',
      );
    }
    log(
      'Requesting user action to unlock',
      name: _logName,
    );
    final password = await passwordDelegate!();
    log(
      'User unlocked',
      name: _logName,
    );

    unlock(password);

    log(
      'Vault Unlocked.',
      name: _logName,
    );
  }
}
