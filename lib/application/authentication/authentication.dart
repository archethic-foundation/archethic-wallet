import 'dart:async';

import 'package:aewallet/domain/models/authentication.dart';
import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/domain/usecases/authentication/authentication.dart';
import 'package:aewallet/domain/usecases/authentication/update_my_password.dart';
import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:aewallet/infrastructure/repositories/authentication.nonweb.dart';
import 'package:aewallet/infrastructure/repositories/authentication.web.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/model/privacy_mask_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication.freezed.dart';
part 'authentication.g.dart';
part 'auto_lock_guard.dart';
part 'password.dart';
part 'pin.dart';
part 'settings.dart';
part 'yubikey.dart';

abstract class AuthenticationProviders {
  static final authenticationRepository =
      Provider<AuthenticationRepositoryInterface>(
    (ref) {
      if (kIsWeb) return AuthenticationRepositoryWeb();
      return AuthenticationRepositoryNonWeb();
    },
  );

  /// Whether the application is locked.
  static final isLockCountdownRunning = FutureProvider<bool>(
    (ref) async {
      final lockCountDownDuration = await ref.watch(lockCountdown.future);
      return lockCountDownDuration.inSeconds > 1;
    },
  );

  /// Counts remaining lock duration.
  /// Lock occurs when authentication failed too much times.
  static final lockCountdown = StreamProvider<Duration>(
    (ref) async* {
      final lockDate = await ref
          .watch(
            AuthenticationProviders.authenticationRepository,
          )
          .getLockUntilDate();
      if (lockDate == null || lockDate.isBefore(DateTime.now().toUtc())) {
        yield Duration.zero;
        return;
      }

      while (true) {
        final durationToWait = lockDate.difference(DateTime.now().toUtc());
        if (durationToWait < Duration.zero) {
          yield Duration.zero;
          return;
        }

        yield durationToWait;
        await Future.delayed(const Duration(seconds: 1));
      }
    },
  );

  static final authenticationGuard = AsyncNotifierProvider<
      AuthenticationGuardNotifier, AuthenticationGuardState>(
    AuthenticationGuardNotifier.new,
    name: AuthenticationGuardNotifier._logger.name,
  );

  static final passwordAuthentication = StateNotifierProvider<
      PasswordAuthenticationNotifier, PasswordAuthenticationState>(
    PasswordAuthenticationNotifier.new,
  );

  static final pinAuthentication =
      StateNotifierProvider<PinAuthenticationNotifier, PinAuthenticationState>(
    PinAuthenticationNotifier.new,
  );

  static final yubikeyAuthentication = StateNotifierProvider<
      YubikeyAuthenticationNotifier, YubikeyAuthenticationState>(
    YubikeyAuthenticationNotifier.new,
  );

  static final settings = StateNotifierProvider<AuthenticationSettingsNotifier,
      AuthenticationSettings>(
    AuthenticationSettingsNotifier.new,
  );

  static Future<void> reset(Ref ref) async {
    await ref.read(AuthenticationProviders.settings.notifier).reset();
    await ref.read(authenticationGuard.notifier).unscheduleAutolock();
    await ref.read(authenticationRepository).clear();

    ref
      ..invalidate(passwordAuthentication)
      ..invalidate(pinAuthentication)
      ..invalidate(yubikeyAuthentication);
  }
}
