import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/infrastructure/datasources/vault.dart';
import 'package:aewallet/infrastructure/repositories/authentication.base.dart';

class AuthenticationRepositoryWeb extends AuthenticationRepositoryBase
    implements AuthenticationRepositoryInterface {
  @override
  Future<bool> get isPasswordDefined async {
    return true;
  }

  @override
  Future<bool> isPinValid(String pin) async => _isPassphraseValid(pin);

  @override
  Future<void> setPin(String pin) async {
    await Vault.instance().updateSecureKey(pin);
  }

  @override
  Future<bool> isPasswordValid(String password, String seed) async =>
      _isPassphraseValid(password);

  @override
  Future<void> setPassword(String password, String seed) async {
    final vault = Vault.instance();
    if (await vault.isSetup) {
      await vault.updateSecureKey(password);
    } else {
      await vault.unlock(password);
    }
  }

  Future<bool> _isPassphraseValid(String passphrase) async {
    try {
      final vault = Vault.instance();
      await vault.unlock(passphrase);
      return true;
    } catch (e) {
      return false;
    }
  }
}
