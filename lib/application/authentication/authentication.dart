import 'package:aewallet/application/settings.dart';
import 'package:aewallet/domain/models/authentication.dart';
import 'package:aewallet/domain/usecases/authentication/authentication.dart';
import 'package:aewallet/infrastructure/repositories/authentication.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'pin.dart';
part 'settings.dart';
part 'authentication.freezed.dart';

abstract class AuthenticationProviders {
  static final _authenticationRepository = Provider(
    (ref) => AuthenticationRepository(),
  );

  static final preferedAuthMethod = Provider<AuthenticationMethod>(
    (ref) => ref
        .read(
          SettingsProviders.localSettingsRepository,
        )
        .getAuthMethod(),
  );

  static final isLocked = StreamProvider.autoDispose<bool>(
    (ref) async* {
      yield* ref.watch(lockCountdown.stream).map(
            (lockCountDownDuration) => lockCountDownDuration.inSeconds > 1,
          );
    },
  );

  static final lockCountdown = StreamProvider.autoDispose<Duration>(
    (ref) async* {
      final lockDate = await ref
          .watch(
            AuthenticationProviders._authenticationRepository,
          )
          .getLockDate();
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

  static final pinAuthentication =
      StateNotifierProvider<PinAuthenticationNotifier, PinAuthenticationState>(
    PinAuthenticationNotifier.new,
  );

  static final settings = StateNotifierProvider<AuthenticationSettingsNotifier,
      AuthenticationSettings>(
    AuthenticationSettingsNotifier.new,
  );
}
