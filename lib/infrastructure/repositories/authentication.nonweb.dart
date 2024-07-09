import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/infrastructure/datasources/authent_nonweb.secured_hive.dart';
import 'package:aewallet/infrastructure/repositories/authentication.base.dart';
import 'package:flutter/foundation.dart';

class AuthenticationRepositoryNonWeb extends AuthenticationRepositoryBase
    implements AuthenticationRepositoryInterface {
  @override
  Future<void> clear() async {
    await resetFailedAttempts();
    await resetLock();
    await AuthentHiveSecuredDatasource.clear();
  }

  @override
  Future<Uint8List> decodeWithPassword(
    String password,
    Uint8List challenge,
  ) async {
    final authDatasource = await AuthentHiveSecuredDatasource.getInstance();

    final expectedPassword = authDatasource.getPassword();

    if (expectedPassword != password) {
      throw const Failure.invalidValue();
    }

    return challenge;
  }

  @override
  Future<Uint8List> encodeWithPassword(
    String password,
    Uint8List challenge,
  ) async {
    final authDatasource = await AuthentHiveSecuredDatasource.getInstance();

    await authDatasource.setPassword(password);

    return challenge;
  }

  @override
  Future<Uint8List> decodeWithPin(
    String pin,
    Uint8List challenge,
  ) async {
    final authDatasource = await AuthentHiveSecuredDatasource.getInstance();

    final expectedPin = authDatasource.getPin();

    if (expectedPin != pin) {
      throw const Failure.invalidValue();
    }

    return challenge;
  }

  @override
  Future<Uint8List> encodeWithPin(
    String pin,
    Uint8List challenge,
  ) async {
    final authDatasource = await AuthentHiveSecuredDatasource.getInstance();

    await authDatasource.setPin(pin);

    return challenge;
  }
}
