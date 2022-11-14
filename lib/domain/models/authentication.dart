import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/model/device_unlock_option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication.freezed.dart';

@freezed
class Credentials with _$Credentials {
  const Credentials._();
  const factory Credentials.pin({
    required String pin,
  }) = PinCredentials;

  const factory Credentials.password({
    required String password,
    required String seed,
  }) = PasswordCredentials;
}

@freezed
class AuthenticationSettings with _$AuthenticationSettings {
  const factory AuthenticationSettings({
    required AuthMethod authenticationMethod,
    required bool pinPadShuffle,
    required UnlockOption lock,
    required LockTimeoutOption lockTimeout,
  }) = _AuthenticationSettings;

  const AuthenticationSettings._();
}
