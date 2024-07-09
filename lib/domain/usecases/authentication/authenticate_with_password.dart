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
    try {
      final decodedKey = await repository.decodeWithPassword(
        credentials.password,
        credentials.challenge,
      );
      return authenticationSucceed(decodedKey);
    } catch (e) {
      return authenticationFailed();
    }
  }
}
