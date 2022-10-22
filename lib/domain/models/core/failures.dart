import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();
  const factory Failure.network() = _NetworkFailure;
  const factory Failure.invalidValue() = _InvalidValue;
  const factory Failure.other({
    Object? cause,
    StackTrace? stack,
  }) = _OtherFailure;
}
