part of 'authentication.dart';

class AuthenticateWithPassword
    with AuthenticationWithLock
    implements UseCase<PasswordCredentials, AuthenticationResult> {
  const AuthenticateWithPassword({
    required this.repository,
  });

  @override
  final AuthenticationRepositoryInterface repository;

  static int get maxFailedAttempts => AuthenticationWithLock.maxFailedAttempts;

  @override
  Future<AuthenticationResult> run(
    PasswordCredentials credentials, {
    UseCaseProgressListener? onProgress,
  }) async {
    if (!await repository.isPasswordDefined) {
      return const AuthenticationResult.notSetup();
    }

    if (await repository.isPasswordValid(
      credentials.password,
    )) {
      return authenticationSucceed();
    }

    return authenticationFailed();
  }
}
