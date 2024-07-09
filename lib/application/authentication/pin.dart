part of 'authentication.dart';

@freezed
class PinAuthenticationState with _$PinAuthenticationState {
  const factory PinAuthenticationState({
    required int failedAttemptsCount,
    required int maxAttemptsCount,
  }) = _PinAuthenticationState;
  const PinAuthenticationState._();
}

class PinAuthenticationNotifier extends StateNotifier<PinAuthenticationState> {
  PinAuthenticationNotifier(this.ref)
      : super(
          PinAuthenticationState(
            failedAttemptsCount: 0,
            maxAttemptsCount: AuthenticateWithPin.maxFailedAttempts,
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

  Future<AuthenticationResult> decodeWithPin(
    PinCredentials pin,
  ) async {
    final authenticationRepository = ref.read(
      AuthenticationProviders.authenticationRepository,
    );
    final authenticationResult = await AuthenticateWithPin(
      repository: authenticationRepository,
    ).run(pin);

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

  Future<UpdatePinResult> updatePin({
    required String pin,
    required String pinConfirmation,
    required Uint8List challenge,
  }) async =>
      UpdateMyPin(
        repository: ref.read(
          AuthenticationProviders.authenticationRepository,
        ),
      ).run(
        PinUpdateCommand(
          pin: pin,
          pinConfirmation: pinConfirmation,
          challenge: challenge,
        ),
      );
}
