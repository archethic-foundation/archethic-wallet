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
            maxAttemptsCount: IAuthenticateWithPin.maxFailedAttempts,
          ),
        ) {
    _loadInitialState();
  }

  final Ref ref;

  Future<void> _loadInitialState() async {
    final authenticationRepository = ref.read(
      AuthenticationProviders._authenticationRepository,
    );
    state = state.copyWith(
      failedAttemptsCount:
          await authenticationRepository.getFailedPinAttempts() %
              state.maxAttemptsCount,
    );
  }

  Future<AuthenticationResult> authenticateWithPin(
    PinCredentials pin,
  ) async {
    final authenticationRepository = ref.read(
      AuthenticationProviders._authenticationRepository,
    );
    final authenticationResult = await IAuthenticateWithPin(
      repository: authenticationRepository,
    ).run(pin);

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

  Future<UpdatePinResult> updatePin({
    required String pin,
    required String pinConfirmation,
  }) async =>
      IUpdateMyPin(
        repository: ref.read(
          AuthenticationProviders._authenticationRepository,
        ),
      ).run(
        PinUpdateCommand(
          pin: pin,
          pinConfirmation: pinConfirmation,
        ),
      );
}
