import 'dart:typed_data';

import 'package:aewallet/domain/repositories/authentication.dart';
import 'package:aewallet/domain/usecases/usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_my_password.freezed.dart';

@freezed
class UpdatePasswordCommand with _$UpdatePasswordCommand {
  const factory UpdatePasswordCommand({
    required String password,
    required String passwordConfirmation,
    required Uint8List challenge,
  }) = _UpdatePasswordCommand;

  const UpdatePasswordCommand._();
}

@freezed
class UpdatePasswordResult with _$UpdatePasswordResult {
  const UpdatePasswordResult._();
  const factory UpdatePasswordResult.success({
    required Uint8List encodedChallenge,
  }) = _UpdatePasswordSuccess;
  const factory UpdatePasswordResult.passwordsDoNotMatch() =
      _passwordsDoNotMatch;
  const factory UpdatePasswordResult.emptyPassword() = _emptyPassword;
}

class UpdateMyPassword
    extends UseCase<UpdatePasswordCommand, UpdatePasswordResult> {
  UpdateMyPassword({required this.repository});

  final AuthenticationRepositoryInterface repository;

  @override
  Future<UpdatePasswordResult> run(
    UpdatePasswordCommand command, {
    UseCaseProgressListener? onProgress,
  }) async {
    if (command.password.isEmpty || command.passwordConfirmation.isEmpty) {
      return const UpdatePasswordResult.emptyPassword();
    }

    if (command.password != command.passwordConfirmation) {
      return const UpdatePasswordResult.passwordsDoNotMatch();
    }

    final encodedKey = await repository.encodeWithPassword(
      command.password,
      command.challenge,
    );
    return UpdatePasswordResult.success(encodedChallenge: encodedKey);
  }
}
