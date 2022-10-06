import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/data/secured_settings.dart';
import 'package:aewallet/model/data/settings.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/model/device_unlock_option.dart';
import 'package:aewallet/util/vault.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localVaultRepositoryProvider = Provider<Vault>(
  (ref) => throw UnimplementedError(),
);

class SecuredSettingsNotifier extends StateNotifier<SecuredSettings> {
  SecuredSettingsNotifier(this.vault, super.state);

  final Vault vault;

  Future<void> setSeed(String seed) async {
    await vault.setSeed(seed);
    state = state.copyWith(seed: seed);
  }

  Future<void> setPin(String pin) async {
    await vault.setPin(pin);
    state = state.copyWith(pin: pin);
  }

  Future<void> setPassword(String password) async {
    await vault.setPassword(password);
    state = state.copyWith(password: password);
  }

  Future<void> setYubikeyClientAPIKey(String yubikeyClientAPIKey) async {
    await vault.setYubikeyClientAPIKey(yubikeyClientAPIKey);
    state = state.copyWith(yubikeyClientAPIKey: yubikeyClientAPIKey);
  }

  Future<void> setYubikeyClientID(String yubikeyClientID) async {
    await vault.setYubikeyClientID(yubikeyClientID);
    state = state.copyWith(yubikeyClientID: yubikeyClientID);
  }
}

final vaultProvider =
    StateNotifierProvider.autoDispose<SecuredSettingsNotifier, Settings>((ref) {
  final vault = ref.read(localVaultRepositoryProvider);

  return SecuredSettingsNotifier(
    vault,
    vault.toModel(),
  );
});
