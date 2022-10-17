import 'package:freezed_annotation/freezed_annotation.dart';
part 'model.freezed.dart';

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

@freezed
class Credentials with _$Credentials {
  const Credentials._();
  const factory Credentials.pin({
    required String pin,
  }) = PinCredentials;
}

@freezed
class PinAuthenticationState with _$PinAuthenticationState {
  const factory PinAuthenticationState({
    required int failedAttemptsCount,
    required int maxAttemptsCount,
  }) = _PinAuthenticationState;
  const PinAuthenticationState._();
}
