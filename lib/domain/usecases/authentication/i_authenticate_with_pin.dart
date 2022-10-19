part of 'authentication.dart';

@freezed
class AuthenticationResult with _$AuthenticationResult {
  const AuthenticationResult._();
  const factory AuthenticationResult.success() = _AuthenticationResult;
  const factory AuthenticationResult.wrongCredentials() =
      _AuthenticationFailure;
  const factory AuthenticationResult.notSetup() = _AuthenticationNotSetup;
  const factory AuthenticationResult.tooMuchAttempts() =
      _AuthenticationTooMuchAttempts;
}

class IAuthenticateWithPin
    with AuthenticationLock
    implements UseCase<Credentials, AuthenticationResult> {
  const IAuthenticateWithPin({
    required this.repository,
  });

  final AuthenticationRepository repository;

  static int get maxFailedAttempts => AuthenticationLock.maxFailedAttempts;

  @override
  Future<AuthenticationResult> run(Credentials credentials) async {
    final expectedPin = await repository.getPin();

    if (expectedPin == credentials.pin) {
      await repository.resetFailedAttempts();
      await repository.resetLock();

      return const AuthenticationResult.success();
    }

    await repository.incrementFailedAttempts();
    final failedAttempts = await repository.getFailedPinAttempts();
    if (failedAttempts >= maxFailedAttempts) {
      await repository.lock(lockDuration(failedAttempts));
      return const AuthenticationResult.tooMuchAttempts();
    }

    return const AuthenticationResult.wrongCredentials();
  }
}
