import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/infrastructure/datasources/authent_nonweb.secured_hive.dart';
import 'package:aewallet/infrastructure/repositories/authentication.base.dart';

class AuthenticationRepositoryNonWeb extends AuthenticationRepositoryBase
    implements AuthenticationRepositoryInterface {
  @override
  Future<bool> isPinValid(String pin) async {
    final authDatasource = await AuthentHiveSecuredDatasource.getInstance();

    final expectedPin = authDatasource.getPin();

    return expectedPin == pin;
  }

  @override
  Future<void> setPin(String pin) async {
    final vault = await AuthentHiveSecuredDatasource.getInstance();
    vault.setPin(pin);
  }

  @override
  Future<bool> get isPasswordDefined async {
    final vault = await AuthentHiveSecuredDatasource.getInstance();
    return vault.getPassword() != null;
  }

  @override
  Future<bool> isPasswordValid(String password) async {
    final authDatasource = await AuthentHiveSecuredDatasource.getInstance();

    final expectedPassword = authDatasource.getPassword();
    return password == expectedPassword;
  }

  @override
  Future<void> setPassword(String password) async {
    final vault = await AuthentHiveSecuredDatasource.getInstance();
    await vault.setPassword(password);
  }
}
