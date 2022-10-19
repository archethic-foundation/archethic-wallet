part of 'authentication.dart';

@freezed
class UpdatePinResult with _$UpdatePinResult {
  const UpdatePinResult._();
  const factory UpdatePinResult.success() = _UpdatePinSuccess;
  const factory UpdatePinResult.pinsDoNotMatch() = _UpdatePinsDoNotMatch;
}

@immutable
class PinUpdateCommand {
  const PinUpdateCommand({
    required this.pin,
    required this.pinConfirmation,
  });

  final String pin;
  final String pinConfirmation;
}

class IUpdateMyPin extends UseCase<PinUpdateCommand, UpdatePinResult> {
  IUpdateMyPin({
    required this.repository,
  });

  final AuthenticationRepositoryInterface repository;

  @override
  Future<UpdatePinResult> run(PinUpdateCommand command) async {
    if (command.pin != command.pinConfirmation) {
      return const UpdatePinResult.pinsDoNotMatch();
    }

    await repository.setPin(command.pin);
    return const UpdatePinResult.success();
  }
}
