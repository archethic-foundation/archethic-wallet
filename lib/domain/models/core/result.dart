import 'package:aewallet/domain/models/core/failures.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class Result<ValueT, FailureT> {
  const factory Result.success(ValueT value) = _Success;
  const factory Result.failure(FailureT failure) = _Failure;

  ValueT? get valueOrNull;
  FailureT? get failureOrNull;

  bool get isValue;
  bool get isFailure;

  T map<T>({
    required T Function(ValueT value) success,
    required T Function(FailureT failure) failure,
  });

  /// Transforms exceptions into [Failure.other].
  ///
  /// This is useful when
  ///    - expected error type is [Failure].
  ///    - you don't need to handle specific error cases.
  static Future<Result<ValueT, Failure>> guard<ValueT>(
    Future<ValueT> Function() run,
  ) async {
    try {
      return Result.success(await run());
    } catch (e, stack) {
      return Result.failure(
        Failure.other(
          cause: e,
          stack: stack,
        ),
      );
    }
  }
}

class _Success<ValueT, FailureT> implements Result<ValueT, FailureT> {
  const _Success(this._value);

  final ValueT _value;

  @override
  ValueT? get valueOrNull => _value;

  @override
  FailureT? get failureOrNull => null;

  @override
  bool get isFailure => false;

  @override
  bool get isValue => true;

  @override
  T map<T>({
    required T Function(ValueT value) success,
    required T Function(FailureT failure) failure,
  }) =>
      success(_value);
}

class _Failure<ValueT, FailureT> implements Result<ValueT, FailureT> {
  const _Failure(this._failure);

  final FailureT _failure;

  @override
  ValueT? get valueOrNull => null;

  @override
  FailureT? get failureOrNull => _failure;

  @override
  bool get isFailure => true;

  @override
  bool get isValue => false;

  @override
  T map<T>({
    required T Function(ValueT value) success,
    required T Function(FailureT failure) failure,
  }) =>
      failure(_failure);
}
