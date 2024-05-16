part of 'authentication.dart';

@freezed
class PasswordAuthenticationState with _$PasswordAuthenticationState {
  const factory PasswordAuthenticationState({
    required int failedAttemptsCount,
    required int maxAttemptsCount,
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

  Future<AuthenticationResult> authenticateWithPassword(
    PasswordCredentials password,
  ) async {
    final authenticationRepository = ref.read(
      AuthenticationProviders.authenticationRepository,
    );
    final authenticationResult = await AuthenticateWithPassword(
      repository: authenticationRepository,
    ).run(password);

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
