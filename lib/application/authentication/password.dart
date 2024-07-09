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
        await authenticationRepository.getFailedAttempts();

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
      failedAttemptsCount: await authenticationRepository.getFailedAttempts() %
          state.maxAttemptsCount,
    );

    return authenticationResult;
  }

  Future<UpdatePasswordResult> updatePassword({
    required String password,
    required String passwordConfirmation,
    required Uint8List challenge,
  }) async =>
      UpdateMyPassword(
        repository: ref.read(AuthenticationProviders.authenticationRepository),
      ).run(
        UpdatePasswordCommand(
          password: password,
          passwordConfirmation: passwordConfirmation,
          challenge: challenge,
        ),
      );
}
