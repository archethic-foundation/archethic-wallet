part of 'authentication.dart';

class AuthenticateWithPin
    with AuthenticationWithLock
    implements UseCase<PinCredentials, AuthenticationResult> {
  const AuthenticateWithPin({
    required this.repository,
  });

  @override
  final AuthenticationRepositoryInterface repository;

  static int get maxFailedAttempts => AuthenticationWithLock.maxFailedAttempts;

  @override
  Future<AuthenticationResult> run(
    PinCredentials credentials, {
    UseCaseProgressListener? onProgress,
  }) async {
    if (await repository.isPinValid(credentials.pin)) {
      return authenticationSucceed();
    }

    return authenticationFailed();
  }
}
