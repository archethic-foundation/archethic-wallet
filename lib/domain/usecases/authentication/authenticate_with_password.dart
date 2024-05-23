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
    String? authentWeb;
    if (kIsWeb) {
      authentWeb = credentials.password;
    }
    final rawExpectedPassword = await repository.getPassword(authentWeb);
    if (rawExpectedPassword == null) {
      return const AuthenticationResult.notSetup();
    }

    final expectedPassword = stringDecryptBase64(
      rawExpectedPassword,
      credentials.seed,
    );

    if (expectedPassword == credentials.password) {
      return authenticationSucceed();
    }

    return authenticationFailed();
  }
}
