import 'package:freezed_annotation/freezed_annotation.dart';
part 'authentication.freezed.dart';

@freezed
class Credentials with _$Credentials {
  const Credentials._();
  const factory Credentials.pin({
    required String pin,
  }) = PinCredentials;
}
