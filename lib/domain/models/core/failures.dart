import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure implements Exception {
  const Failure._();
  const factory Failure.loggedOut() = _LoggedOut;
  const factory Failure.network() = _NetworkFailure;
  const factory Failure.quotaExceeded({
    DateTime? cooldownEndDate,
  }) = _QuotaExceededFailure;
  const factory Failure.servciceNotFound() = _ServiceNotFound;
  const factory Failure.insufficientFunds() = _InsuffientFunds;
  const factory Failure.unauthorized() = _Inauthorized;
  const factory Failure.invalidValue() = _InvalidValue;
  const factory Failure.other({
    Object? cause,
    StackTrace? stack,
  }) = _OtherFailure;
}
