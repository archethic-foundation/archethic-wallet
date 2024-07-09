part of 'authentication.dart';

class AuthenticateWithYubikey
    with AuthenticationWithLock
    implements UseCase<YubikeyCredentials, AuthenticationResult> {
  const AuthenticateWithYubikey({
    required this.repository,
  });

  @override
  final AuthenticationRepositoryInterface repository;

  static int get maxFailedAttempts => AuthenticationWithLock.maxFailedAttempts;

  @override
  Future<AuthenticationResult> run(
    YubikeyCredentials credentials, {
    UseCaseProgressListener? onProgress,
  }) async {
    final vault = await AuthentHiveSecuredDatasource.getInstance();

    final yubikeyClientAPIKey = vault.getYubikeyClientAPIKey();
    final yubikeyClientID = vault.getYubikeyClientID();
    if (yubikeyClientID.isEmpty && yubikeyClientAPIKey.isEmpty) {
      return const AuthenticationResult.notSetup();
    }
    final verificationResponse = await Yubidart()
        .otp
        .verify(credentials.otp, yubikeyClientAPIKey, yubikeyClientID);

    if (verificationResponse.status == 'OK') {
      return authenticationSucceed(credentials.challenge);
    }

    return authenticationFailed();
  }
}
