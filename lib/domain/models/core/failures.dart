import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure implements Exception {
  const Failure._();
  const factory Failure.loggedOut({String? message}) = _LoggedOut;
  const factory Failure.network({String? message}) = _NetworkFailure;
  const factory Failure.operationCanceled({String? message}) =
      _OperationCanceled;
  const factory Failure.quotaExceeded({
    String? message,
    DateTime? cooldownEndDate,
  }) = _QuotaExceededFailure;
  const factory Failure.serviceNotFound({String? message}) = _ServiceNotFound;
  const factory Failure.serviceAlreadyExists({String? message}) =
      _ServiceAlreadyExists;
  const factory Failure.insufficientFunds({String? message}) = _InsuffientFunds;
  const factory Failure.unauthorized({String? message}) = _Inauthorized;
  const factory Failure.invalidValue({String? message}) = _InvalidValue;
  const factory Failure.locked({String? message}) = _LockedApplication;
  const factory Failure.other({
    String? message,
    Object? cause,
    StackTrace? stack,
  }) = _OtherFailure;
}

/// Wraps any thrown Exception in a Failure with
/// a specific message.
extension FailureGuard<T> on T Function() {
  T guard(String message) {
    try {
      return call();
    } catch (e, stack) {
      throw Failure.other(
        message: message,
        cause: e,
        stack: stack,
      );
    }
  }
}

/// Wraps any thrown Exception in a Failure with
/// a specific message.
extension FutureFailureGuard<T> on Future<T> {
  Future<T> guard(String message) async {
    try {
      return await this;
    } catch (e, stack) {
      throw Failure.other(
        message: message,
        cause: e,
        stack: stack,
      );
    }
  }
}
