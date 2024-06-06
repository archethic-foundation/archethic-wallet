part of 'authentication.dart';

class AuthenticationSettingsNotifier
    extends StateNotifier<AuthenticationSettings> {
  AuthenticationSettingsNotifier(this.ref)
      : super(
          AuthenticationSettings.defaultValue,
        );

  final Ref ref;

  Future<void> initialize() async {
    state = await ref
        .read(AuthenticationProviders.authenticationRepository)
        .getSettings();
  }

  Future<void> reset() => _update(
        state.copyWith(
          lock: UnlockOption.yes,
          pinPadShuffle: false,
          lockTimeout: LockTimeoutOption.oneMin,
        ),
      );

  Future<void> _update(AuthenticationSettings authSettings) async {
    await ref
        .read(AuthenticationProviders.authenticationRepository)
        .setSettings(authSettings);
    state = authSettings;
  }

  Future<void> setPrivacyMask(PrivacyMaskOption maskOption) => _update(
        state.copyWith(privacyMask: maskOption),
      );

  Future<void> setAuthMethod(AuthMethod method) => _update(
        state.copyWith(authenticationMethod: method),
      );

  Future<void> setPinPadShuffle(bool pinPadShuffle) => _update(
        state.copyWith(pinPadShuffle: pinPadShuffle),
      );

  Future<void> setLockApp(UnlockOption lockOption) => _update(
        state.copyWith(lock: lockOption),
      );

  Future<void> setLockTimeout(LockTimeoutOption lockTimeout) => _update(
        state.copyWith(lockTimeout: lockTimeout),
      );
}
