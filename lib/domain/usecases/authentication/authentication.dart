import 'package:aewallet/domain/models/authentication.dart';
import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/domain/usecases/usecase.dart';
import 'package:aewallet/infrastructure/repositories/authentication.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication.freezed.dart';
part 'i_authenticate_with_pin.dart';
part 'i_update_my_pin.dart';

mixin AuthenticationLock {
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
}
