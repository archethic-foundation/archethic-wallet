import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
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
    await _updateVaultPassphrase(pin);
  }

  @override
  Future<bool> isPasswordValid(String password) async =>
      _isPassphraseValid(password);

  @override
  Future<void> setPassword(String password) async {
    await _updateVaultPassphrase(password);
  }

  /// Updates or sets Vault passphrase.
  ///
  /// If a passphrase was already setup, then the Vault MUST be unlocked before calling this.
  Future<void> _updateVaultPassphrase(String passphrase) async {
    final vault = Vault.instance();
    if (await vault.isSetup) {
      await vault.updateSecureKey(passphrase);
    } else {
      await vault.unlock(passphrase);
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
