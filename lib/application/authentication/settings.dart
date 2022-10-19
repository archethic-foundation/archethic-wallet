part of 'authentication.dart';

@freezed
class AuthenticationSettings with _$AuthenticationSettings {
  const factory AuthenticationSettings({
    required AuthMethod authenticationMethod,
    required bool pinPadShuffle,
  }) = _AuthenticationSettings;

  const AuthenticationSettings._();
}

class AuthenticationSettingsNotifier
    extends StateNotifier<AuthenticationSettings> {
  AuthenticationSettingsNotifier(this.ref)
      : super(
          const AuthenticationSettings(
            authenticationMethod: AuthMethod.pin,
            pinPadShuffle: false,
          ),
        ) {
    _loadInitialState();
  }

  final Ref ref;

  Future<void> _loadInitialState() async {
    state = await ref
        .read(AuthenticationProviders._authenticationRepository)
        .getSettings();
  }

  Future<void> setAuthMethod(AuthMethod method) async {
    final updatedState = state.copyWith(authenticationMethod: method);
    ref
        .read(AuthenticationProviders._authenticationRepository)
        .setSettings(updatedState);
    state = updatedState;
  }

  Future<void> setPinPadShuffle(bool pinPadShuffle) async {
    final updatedState = state.copyWith(pinPadShuffle: pinPadShuffle);
    ref
        .read(AuthenticationProviders._authenticationRepository)
        .setSettings(updatedState);
    state = updatedState;
  }
}
