import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/authentication/model/model.dart';

abstract class UseCase<Result> {
  Future<Result> run();
}

abstract class AuthenticationDelegate<C extends Credentials> {
  Future<bool> isSetup();
  Future<AuthenticationResult> verifyCredentials(C credentials);
}

abstract class IAuthenticateWithCredentials
    implements UseCase<AuthenticationResult> {}

class IAuthenticateWithPin implements IAuthenticateWithCredentials {
  const IAuthenticateWithPin({
    required this.credentials,
    required this.repository,
  });

  final Credentials credentials;
  final AuthenticationRepository repository;

  @override
  Future<AuthenticationResult> run() async {
    final expectedPin = await repository.getPin();

    if (expectedPin == credentials.pin) {
      await repository.resetFailedPinAttempts();
      await repository.resetLock();

      return const AuthenticationResult.success();
    }

    await repository.incrementFailedPinAttemptsCount();
    final failedPinAttemptsCount = await repository.getFailedPinAttemptsCount();
    if (failedPinAttemptsCount >= 5) {
      await repository.lock(const Duration(minutes: 1));
      return const AuthenticationResult.tooMuchAttempts();
    }

    return const AuthenticationResult.wrongCredentials();
  }
}
