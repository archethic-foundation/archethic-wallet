part of 'authentication.dart';

class IAuthenticateWithPassword
    with AuthenticationWithLock
    implements UseCase<PasswordCredentials, AuthenticationResult> {
  const IAuthenticateWithPassword({
    required this.repository,
  });

  @override
  final AuthenticationRepository repository;

  static int get maxFailedAttempts => AuthenticationWithLock.maxFailedAttempts;

  @override
  Future<AuthenticationResult> run(PasswordCredentials credentials) async {
    final rawExpectedPassword = await repository.getPassword();
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
