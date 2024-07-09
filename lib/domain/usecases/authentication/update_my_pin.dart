part of 'authentication.dart';

@freezed
class UpdatePinResult with _$UpdatePinResult {
  const UpdatePinResult._();
  const factory UpdatePinResult.success({
    required Uint8List encodedChallenge,
  }) = _UpdatePinSuccess;
  const factory UpdatePinResult.pinsDoNotMatch() = _UpdatePinDoNotMatch;
}

@immutable
class PinUpdateCommand {
  const PinUpdateCommand({
    required this.pin,
    required this.pinConfirmation,
    required this.challenge,
  });

  final String pin;
  final String pinConfirmation;
  final Uint8List challenge;
}

class UpdateMyPin extends UseCase<PinUpdateCommand, UpdatePinResult> {
  UpdateMyPin({
    required this.repository,
  });

  final AuthenticationRepositoryInterface repository;

  @override
  Future<UpdatePinResult> run(
    PinUpdateCommand command, {
    UseCaseProgressListener? onProgress,
  }) async {
    if (command.pin != command.pinConfirmation) {
      return const UpdatePinResult.pinsDoNotMatch();
    }

    final encodedKey = await repository.encodeWithPin(
      command.pin,
      command.challenge,
    );
    return UpdatePinResult.success(encodedChallenge: encodedKey);
  }
}
