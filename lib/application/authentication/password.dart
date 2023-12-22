part of 'authentication.dart';

@freezed
class PasswordAuthenticationState with _$PasswordAuthenticationState {
  const factory PasswordAuthenticationState({
    required int failedAttemptsCount,
    required int maxAttemptsCount,
    required bool isAuthent,
  }) = _PasswordAuthenticationState;
  const PasswordAuthenticationState._();
}

class PasswordAuthenticationNotifier
    extends StateNotifier<PasswordAuthenticationState> {
  PasswordAuthenticationNotifier(this.ref)
      : super(
          PasswordAuthenticationState(
            failedAttemptsCount: 0,
            maxAttemptsCount: AuthenticateWithPassword.maxFailedAttempts,
            isAuthent: false,
          ),
        ) {
    _loadInitialState();
  }

  final Ref ref;

  Future<void> _loadInitialState() async {
    if (!mounted) return;
    final authenticationRepository = ref.read(
      AuthenticationProviders._authenticationRepository,
    );

    final maxAttemptsCount = state.maxAttemptsCount;
    final failedPinAttempts =
        await authenticationRepository.getFailedPinAttempts();

    if (!mounted) return;
    state = state.copyWith(
      failedAttemptsCount: failedPinAttempts % maxAttemptsCount,
    );
  }

  Future<AuthenticationResult> authenticateWithPassword(
    PasswordCredentials password,
  ) async {
    state = state.copyWith(isAuthent: false);
    final authenticationRepository = ref.read(
      AuthenticationProviders._authenticationRepository,
    );
    final authenticationResult = await AuthenticateWithPassword(
      repository: authenticationRepository,
    ).run(password);

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
