import 'package:flutter/foundation.dart';

@immutable
abstract class Result<Value, Failure> {
  const factory Result.success(Value value) = _Success;
  const factory Result.failure(Failure failure) = _Failure;

  Value? get valueOrNull;
  Failure? get failureOrNull;

  T map<T>({
    required T Function(Value value) success,
    required T Function(Failure failure) failure,
  });
}

class _Success<Value, Failure> implements Result<Value, Failure> {
  const _Success(this._value);

  final Value _value;

  @override
  Value? get valueOrNull => _value;

  @override
  Failure? get failureOrNull => null;

  @override
  T map<T>({
    required T Function(Value value) success,
    required T Function(Failure failure) failure,
  }) =>
      success(_value);
}

class _Failure<Value, Failure> implements Result<Value, Failure> {
  const _Failure(this._failure);

  final Failure _failure;

  @override
  Value? get valueOrNull => null;

  @override
  Failure? get failureOrNull => _failure;

  @override
  T map<T>({
    required T Function(Value value) success,
    required T Function(Failure failure) failure,
  }) =>
      failure(_failure);
}
