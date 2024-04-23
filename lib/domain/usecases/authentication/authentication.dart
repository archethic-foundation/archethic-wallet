import 'package:aewallet/domain/models/authentication.dart';
import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/domain/usecases/usecase.dart';
import 'package:aewallet/infrastructure/datasources/hive_vault.dart';
import 'package:aewallet/util/string_encryption.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yubidart/yubidart.dart';

part 'authenticate_with_password.dart';
part 'authenticate_with_pin.dart';
part 'authenticate_with_yubikey.dart';
part 'authentication.freezed.dart';
part 'update_my_pin.dart';

mixin AuthenticationWithLock {
  AuthenticationRepositoryInterface get repository;
  static int get maxFailedAttempts => 5;

  Duration lockDuration(int attempts) {
    if (attempts == 20) {
      return const Duration(hours: 24);
    }

    if (attempts == 15) {
      return const Duration(minutes: 15);
    }

    if (attempts == 10) {
      return const Duration(minutes: 5);
    }

    if (attempts == 5) {
      return const Duration(minutes: 1);
    }

    return Duration.zero;
  }

  Future<AuthenticationResult> authenticationSucceed() async {
    await repository.resetFailedAttempts();
    await repository.resetLock();

    return const AuthenticationResult.success();
  }

  Future<AuthenticationResult> authenticationFailed() async {
    await repository.incrementFailedAttempts();
    final failedAttempts = await repository.getFailedPinAttempts();
    if (failedAttempts >= maxFailedAttempts) {
      await repository.lock(lockDuration(failedAttempts));
      return const AuthenticationResult.tooMuchAttempts();
    }

    return const AuthenticationResult.wrongCredentials();
  }
}

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
