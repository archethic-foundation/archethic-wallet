part of 'authentication.dart';

@freezed
class YubikeyAuthenticationState with _$YubikeyAuthenticationState {
  const factory YubikeyAuthenticationState({
    required int failedAttemptsCount,
    required int maxAttemptsCount,
  }) = _YubikeyAuthenticationState;
  const YubikeyAuthenticationState._();
}

@riverpod
class _YubikeyAuthenticationNotifier extends _$YubikeyAuthenticationNotifier {
  @override
  Future<YubikeyAuthenticationState> build() async {
    final authenticationRepository = ref.watch(
      AuthenticationProviders.authenticationRepository,
    );

    final maxAttemptsCount = AuthenticateWithYubikey.maxFailedAttempts;
    final failedPinAttempts =
        await authenticationRepository.getFailedAttempts();

    return YubikeyAuthenticationState(
      failedAttemptsCount: failedPinAttempts % maxAttemptsCount,
      maxAttemptsCount: maxAttemptsCount,
    );
  }

  Future<AuthenticationResult> authenticateWithYubikey(
    YubikeyCredentials otp,
  ) async {
    final lState = state.value;
    if (lState == null) return const AuthenticationResult.notSetup();

    final authenticationRepository = ref.read(
      AuthenticationProviders.authenticationRepository,
    );
    final authenticationResult = await AuthenticateWithYubikey(
      repository: authenticationRepository,
    ).run(otp);

    authenticationResult.maybeMap(
      tooMuchAttempts: (value) {
        ref.invalidate(AuthenticationProviders.lockCountdown);
      },
      orElse: () {},
    );

    state = AsyncData(
      lState.copyWith(
        failedAttemptsCount:
            await authenticationRepository.getFailedAttempts() %
                lState.maxAttemptsCount,
      ),
    );

    return authenticationResult;
  }
}
