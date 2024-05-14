part of 'authentication.dart';

@freezed
class YubikeyAuthenticationState with _$YubikeyAuthenticationState {
  const factory YubikeyAuthenticationState({
    required int failedAttemptsCount,
    required int maxAttemptsCount,
    required bool isAuthent,
  }) = _YubikeyAuthenticationState;
  const YubikeyAuthenticationState._();
}

class YubikeyAuthenticationNotifier
    extends StateNotifier<YubikeyAuthenticationState> {
  YubikeyAuthenticationNotifier(this.ref)
      : super(
          YubikeyAuthenticationState(
            failedAttemptsCount: 0,
            maxAttemptsCount: AuthenticateWithYubikey.maxFailedAttempts,
            isAuthent: false,
          ),
        ) {
    _loadInitialState();
  }

  final Ref ref;

  Future<void> _loadInitialState() async {
    if (!mounted) return;
    final authenticationRepository = ref.read(
      AuthenticationProviders.authenticationRepository,
    );

    final maxAttemptsCount = state.maxAttemptsCount;
    final failedPinAttempts =
        await authenticationRepository.getFailedPinAttempts();

    if (!mounted) return;
    state = state.copyWith(
      failedAttemptsCount: failedPinAttempts % maxAttemptsCount,
    );
  }

  Future<AuthenticationResult> authenticateWithYubikey(
    YubikeyCredentials otp,
  ) async {
    state = state.copyWith(isAuthent: false);
    final authenticationRepository = ref.read(
      AuthenticationProviders.authenticationRepository,
    );
    final authenticationResult = await AuthenticateWithYubikey(
      repository: authenticationRepository,
    ).run(otp);

    authenticationResult.maybeMap(
      success: (success) {
        state = state.copyWith(isAuthent: true);
      },
      tooMuchAttempts: (value) {
        ref.invalidate(AuthenticationProviders.lockCountdown);
      },
      orElse: () {},
    );

    state = state.copyWith(
      failedAttemptsCount:
          await authenticationRepository.getFailedPinAttempts() %
              state.maxAttemptsCount,
    );

    return authenticationResult;
  }
}
