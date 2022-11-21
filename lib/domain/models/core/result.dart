import 'package:aewallet/domain/models/core/failures.dart';
import 'package:flutter/foundation.dart';

extension FutureResult<ValueT, FailureT extends Exception>
    on Future<Result<ValueT, FailureT>> {
  /// Returns the value if it is a success.
  /// Else, throws the error as an [Exception].
  ///
  /// Thanks to this extension, instead of :
  /// ```dart
  /// Future<Result<Value, Failure>> result;
  /// final value = (await result).valueOrThrow;
  /// ```
  ///
  /// You can do :
  /// ```dart
  /// Future<Result<Value, Failure>> result;
  /// final value = await result.valueOrThrow;
  /// ```
  Future<ValueT> get valueOrThrow async {
    return (await this).valueOrThrow;
  }

  Future<ValueT?> get valueOrNull async {
    return (await this).valueOrNull;
  }
}

/// An operation's result with [void] success value.
abstract class VoidResult<FailureT extends Exception>
    extends Result<void, FailureT> {
  const factory VoidResult.success() = _VoidSuccess;
  const factory VoidResult.failure(FailureT failure) = _VoidFailure;
}

class _VoidSuccess<FailureT extends Exception> implements VoidResult<FailureT> {
  const _VoidSuccess();

  @override
  FailureT? get failureOrNull => null;

  @override
  bool get isFailure => false;

  @override
  bool get isValue => true;

  @override
  T map<T>({
    required T Function(void value) success,
    required T Function(FailureT failure) failure,
  }) =>
      success(null);

  @override
  void get valueOrNull {}

  @override
  void get valueOrThrow {}
}

class _VoidFailure<FailureT extends Exception> implements VoidResult<FailureT> {
  const _VoidFailure(this._failure);

  final FailureT _failure;

  @override
  FailureT? get failureOrNull => _failure;

  @override
  bool get isFailure => true;

  @override
  bool get isValue => false;

  @override
  T map<T>({
    required T Function(void value) success,
    required T Function(FailureT failure) failure,
  }) =>
      failure(_failure);

  @override
  void get valueOrNull {}

  @override
  void get valueOrThrow {
    throw _failure;
  }
}

/// An operation's result.
/// Can be a success or a failure.
@immutable
abstract class Result<ValueT, FailureT extends Exception> {
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

  /// Returns the value if it is a success.
  /// Else, throws the error as an [Exception].
  ValueT get valueOrThrow;

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
    } on Failure catch (e) {
      return Result.failure(e);
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

class _Success<ValueT, FailureT extends Exception>
    implements Result<ValueT, FailureT> {
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
  ValueT get valueOrThrow => _value;

  @override
  T map<T>({
    required T Function(ValueT value) success,
    required T Function(FailureT failure) failure,
  }) =>
      success(_value);
}

class _Failure<ValueT, FailureT extends Exception>
    implements Result<ValueT, FailureT> {
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
  ValueT get valueOrThrow => throw _failure;

  @override
  T map<T>({
    required T Function(ValueT value) success,
    required T Function(FailureT failure) failure,
  }) =>
      failure(_failure);
}
