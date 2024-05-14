import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/infrastructure/datasources/hive_authentication.dart';
import 'package:aewallet/infrastructure/repositories/authentication.base.dart';
import 'package:aewallet/util/string_encryption.dart';

class AuthenticationRepositoryOther extends AuthenticationRepositoryBase
    implements AuthenticationRepositoryInterface {
  @override
  Future<bool> isPinValid(String pin) async {
    final authDatasource = await HiveAuthenticationDatasource.getInstance();

    final expectedPin = authDatasource.getPin();

    return expectedPin == pin;
  }

  @override
  Future<void> setPin(String pin) async {
    final vault = await HiveAuthenticationDatasource.getInstance();
    vault.setPin(pin);
  }

  @override
  Future<bool> get isPasswordDefined async {
    final vault = await HiveAuthenticationDatasource.getInstance();
    return vault.getPassword() != null;
  }

  @override
  Future<bool> isPasswordValid(String password, String seed) async {
    final authDatasource = await HiveAuthenticationDatasource.getInstance();

    final expectedEncryptedPassword = authDatasource.getPassword();
    if (expectedEncryptedPassword == null) return false;

    final expectedPassword = stringDecryptBase64(
      expectedEncryptedPassword,
      seed,
    );
    return password == expectedPassword;
  }

  @override
  Future<void> setPassword(String password, String seed) async {
    final vault = await HiveAuthenticationDatasource.getInstance();
    await vault.setPassword(
      stringEncryptBase64(password, seed),
    );
  }
}
