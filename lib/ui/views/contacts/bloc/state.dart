import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class ContactCreationFormState with _$ContactCreationFormState {
  const factory ContactCreationFormState({
    @Default('') String name,
    @Default('') String address,
    @Default('') String publicKey,
    @Default(false) bool favorite,
    @Default('') String error,
  }) = _ContactCreationFormState;
  const ContactCreationFormState._();

  bool get isControlsOk => error == '';

  bool get canCreateContact => name.isNotEmpty && address.isNotEmpty;
}
