import 'dart:developer';

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/infrastructure/datasources/secured_datasource_mixin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

/// Encryption key is AES encrypted before storage
class PasswordVaultCipher implements VaultCipher {
  PasswordVaultCipher({required this.password});

  final String password;

  Uint8List? _key;

  static Future<bool> get isSetup => Hive.isEncryptedSecureKeyDefined(
        const FlutterSecureStorage(),
      );

  static Future<void> clear() => Hive.clearEncryptedSecureKey(
        const FlutterSecureStorage(),
      );

  @override
  Future<Uint8List> get() async => _key ?? (_key = await _genKey());

  Future<Uint8List> _genKey() async {
    const secureStorage = FlutterSecureStorage();

    final encryptionKey = await Hive.readEncryptedSecureKey(
          secureStorage,
          password,
        ) ??
        await Hive.generateAndStoreEncryptedSecureKey(
          secureStorage,
          password,
        );

    return encryptionKey;
  }

  @override
  Future<void> updateSecureKey(
    String newPassword,
  ) async {
    const secureStorage = FlutterSecureStorage();

    await Hive.updateAndStoreEncryptedSecureKey(
      secureStorage,
      await get(),
      newPassword,
    );
  }
}

/// Encryption key is AES encrypted before storage
class SimpleVaultCipher implements VaultCipher {
  static Future<bool> get isSetup => Hive.isSecureKeyDefined(
        const FlutterSecureStorage(),
      );

  static Future<void> clear() => Hive.clearSecureKey(
        const FlutterSecureStorage(),
      );

  @override
  Future<Uint8List> get() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKey = await Hive.readSecureKey(secureStorage) ??
        await Hive.generateAndStoreSecureKey(secureStorage);

    return encryptionKey;
  }

  @override
  Future<void> updateSecureKey(
    String newPassword,
  ) async {}
}

typedef VaultPasswordDelegate = Future<String> Function();
typedef VaultAutolockDelegate = Future<bool> Function();

class Vault {
  factory Vault.instance() {
    Vault._instance ??= Vault._();
    return Vault._instance!;
  }

  static const LOGNAME = 'Vault';

  Vault._();

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
      name: LOGNAME,
    );
    Hive.close();
    _vaultCipher = null;
  }

  Future<void> unlock(String password) async {
    log(
      'Unlocking vault',
      name: LOGNAME,
    );
    _vaultCipher = VaultCipher(password);

    // Ensures we are able to retrieve the encryption key
    await _vaultCipher!.get();
    log(
      'Vault unlocked',
      name: LOGNAME,
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
      name: LOGNAME,
    );
    await VaultCipher.clear();
  }

  Future<void> updateSecureKey(
    String newPassword,
  ) async {
    log(
      'Updating vault secure key',
      name: LOGNAME,
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
      name: LOGNAME,
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
        name: LOGNAME,
      );
      rethrow;
    }
  }

  Future<LazyBox<E>> openLazyBox<E>(
    String name,
  ) async {
    log(
      'Opening lazy box $name',
      name: LOGNAME,
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
        name: LOGNAME,
      );
      rethrow;
    }
  }

  Future<void> _applyAutolock() async {
    if (shouldBeLocked == null || await shouldBeLocked!() == false) return;
    log(
      'Apply autolock to Vault.',
      name: LOGNAME,
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
      name: LOGNAME,
    );
    final password = await passwordDelegate!();
    log(
      'User unlocked',
      name: LOGNAME,
    );

    unlock(password);

    log(
      'Vault Unlocked.',
      name: LOGNAME,
    );
  }
}
