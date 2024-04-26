import 'dart:developer';

import 'package:aewallet/infrastructure/datasources/secured_datasource_mixin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class VaultCipherBuilder {
  factory VaultCipherBuilder(String password) {
    return kIsWeb
        ? PasswordVaultCipherBuilder(password: password)
        : SimpleVaultCipherBuilder();
  }

  Future<Uint8List> get();
}

/// Encryption key is AES encrypted before storage
class PasswordVaultCipherBuilder implements VaultCipherBuilder {
  PasswordVaultCipherBuilder({required this.password});

  final String password;

  @override
  Future<Uint8List> get() async {
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
}

/// Encryption key is AES encrypted before storage
class SimpleVaultCipherBuilder implements VaultCipherBuilder {
  @override
  Future<Uint8List> get() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKey = await Hive.readSecureKey(secureStorage) ??
        await Hive.generateAndStoreSecureKey(secureStorage);

    return encryptionKey;
  }
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
  HiveCipher? _hiveCipher;

  void lock() {
    log(
      'Locking vault',
      name: LOGNAME,
    );
    Hive.close();
    _hiveCipher = null;
  }

  Future<void> unlock(String password) async {
    log(
      'Unlocking vault',
      name: LOGNAME,
    );
    final cipherBuilder = VaultCipherBuilder(password);
    _hiveCipher = HiveAesCipher(await cipherBuilder.get());
  }

  Future<bool> boxExists(String name) {
    return Hive.boxExists(name);
  }

  Future<void> clear(String name) async {
    await Hive.deleteBoxFromDisk(name);
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
        encryptionCipher: _hiveCipher,
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
        encryptionCipher: _hiveCipher,
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
    if (_hiveCipher != null) return;

    if (passwordDelegate == null) {
      throw Exception(
        'Vault.passwordDelegate must be set before opening Boxes.',
      );
    }

    unlock(await passwordDelegate!());
  }
}
