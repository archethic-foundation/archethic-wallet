part of 'authentication.dart';

class AuthenticationSettingsNotifier
    extends StateNotifier<AuthenticationSettings> {
  AuthenticationSettingsNotifier(this.ref)
      : super(
          const AuthenticationSettings(
            authenticationMethod: AuthMethod.pin,
            pinPadShuffle: false,
            lock: UnlockOption.yes,
            lockTimeout: LockTimeoutOption.oneMin,
          ),
        );

  final Ref ref;

  Future<void> initialize() async {
    state = await ref
        .read(AuthenticationProviders._authenticationRepository)
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
        .read(AuthenticationProviders._authenticationRepository)
        .setSettings(authSettings);
    state = authSettings;
  }

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
