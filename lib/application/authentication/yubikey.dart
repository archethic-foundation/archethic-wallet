part of 'authentication.dart';

@freezed
class YubikeyAuthenticationState with _$YubikeyAuthenticationState {
  const factory YubikeyAuthenticationState({
    required int failedAttemptsCount,
    required int maxAttemptsCount,
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

    state = state.copyWith(
      failedAttemptsCount:
          await authenticationRepository.getFailedPinAttempts() %
              state.maxAttemptsCount,
    );

    return authenticationResult;
  }
}
