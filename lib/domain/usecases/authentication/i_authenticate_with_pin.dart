part of 'authentication.dart';

class IAuthenticateWithPin
    with AuthenticationWithLock
    implements UseCase<PinCredentials, AuthenticationResult> {
  const IAuthenticateWithPin({
    required this.repository,
  });

  @override
  final AuthenticationRepository repository;

  static int get maxFailedAttempts => AuthenticationWithLock.maxFailedAttempts;

  @override
  Future<AuthenticationResult> run(PinCredentials credentials) async {
    final expectedPin = await repository.getPin();

    if (expectedPin == credentials.pin) {
      return authenticationSucceed();
    }

    return authenticationFailed();
  }
}
