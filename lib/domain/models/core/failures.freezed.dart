// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Failure {
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoggedOutImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$LoggedOutImplCopyWith(
          _$LoggedOutImpl value, $Res Function(_$LoggedOutImpl) then) =
      __$$LoggedOutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$LoggedOutImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$LoggedOutImpl>
    implements _$$LoggedOutImplCopyWith<$Res> {
  __$$LoggedOutImplCopyWithImpl(
      _$LoggedOutImpl _value, $Res Function(_$LoggedOutImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$LoggedOutImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoggedOutImpl extends _LoggedOut {
  const _$LoggedOutImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'Failure.loggedOut(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoggedOutImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoggedOutImplCopyWith<_$LoggedOutImpl> get copyWith =>
      __$$LoggedOutImplCopyWithImpl<_$LoggedOutImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return loggedOut(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return loggedOut?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return loggedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut(this);
    }
    return orElse();
  }
}

abstract class _LoggedOut extends Failure {
  const factory _LoggedOut({final String? message}) = _$LoggedOutImpl;
  const _LoggedOut._() : super._();

  @override
  String? get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoggedOutImplCopyWith<_$LoggedOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(_$NetworkFailureImpl value,
          $Res Function(_$NetworkFailureImpl) then) =
      __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
      _$NetworkFailureImpl _value, $Res Function(_$NetworkFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$NetworkFailureImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NetworkFailureImpl extends _NetworkFailure {
  const _$NetworkFailureImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'Failure.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class _NetworkFailure extends Failure {
  const factory _NetworkFailure({final String? message}) = _$NetworkFailureImpl;
  const _NetworkFailure._() : super._();

  @override
  String? get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OperationCanceledImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$OperationCanceledImplCopyWith(_$OperationCanceledImpl value,
          $Res Function(_$OperationCanceledImpl) then) =
      __$$OperationCanceledImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$OperationCanceledImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$OperationCanceledImpl>
    implements _$$OperationCanceledImplCopyWith<$Res> {
  __$$OperationCanceledImplCopyWithImpl(_$OperationCanceledImpl _value,
      $Res Function(_$OperationCanceledImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$OperationCanceledImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$OperationCanceledImpl extends _OperationCanceled {
  const _$OperationCanceledImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'Failure.operationCanceled(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperationCanceledImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OperationCanceledImplCopyWith<_$OperationCanceledImpl> get copyWith =>
      __$$OperationCanceledImplCopyWithImpl<_$OperationCanceledImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return operationCanceled(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return operationCanceled?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (operationCanceled != null) {
      return operationCanceled(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return operationCanceled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return operationCanceled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (operationCanceled != null) {
      return operationCanceled(this);
    }
    return orElse();
  }
}

abstract class _OperationCanceled extends Failure {
  const factory _OperationCanceled({final String? message}) =
      _$OperationCanceledImpl;
  const _OperationCanceled._() : super._();

  @override
  String? get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OperationCanceledImplCopyWith<_$OperationCanceledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuotaExceededFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$QuotaExceededFailureImplCopyWith(_$QuotaExceededFailureImpl value,
          $Res Function(_$QuotaExceededFailureImpl) then) =
      __$$QuotaExceededFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, DateTime? cooldownEndDate});
}

/// @nodoc
class __$$QuotaExceededFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$QuotaExceededFailureImpl>
    implements _$$QuotaExceededFailureImplCopyWith<$Res> {
  __$$QuotaExceededFailureImplCopyWithImpl(_$QuotaExceededFailureImpl _value,
      $Res Function(_$QuotaExceededFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? cooldownEndDate = freezed,
  }) {
    return _then(_$QuotaExceededFailureImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      cooldownEndDate: freezed == cooldownEndDate
          ? _value.cooldownEndDate
          : cooldownEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$QuotaExceededFailureImpl extends _QuotaExceededFailure {
  const _$QuotaExceededFailureImpl({this.message, this.cooldownEndDate})
      : super._();

  @override
  final String? message;
  @override
  final DateTime? cooldownEndDate;

  @override
  String toString() {
    return 'Failure.quotaExceeded(message: $message, cooldownEndDate: $cooldownEndDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuotaExceededFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.cooldownEndDate, cooldownEndDate) ||
                other.cooldownEndDate == cooldownEndDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, cooldownEndDate);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuotaExceededFailureImplCopyWith<_$QuotaExceededFailureImpl>
      get copyWith =>
          __$$QuotaExceededFailureImplCopyWithImpl<_$QuotaExceededFailureImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return quotaExceeded(message, cooldownEndDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return quotaExceeded?.call(message, cooldownEndDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (quotaExceeded != null) {
      return quotaExceeded(message, cooldownEndDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return quotaExceeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return quotaExceeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (quotaExceeded != null) {
      return quotaExceeded(this);
    }
    return orElse();
  }
}

abstract class _QuotaExceededFailure extends Failure {
  const factory _QuotaExceededFailure(
      {final String? message,
      final DateTime? cooldownEndDate}) = _$QuotaExceededFailureImpl;
  const _QuotaExceededFailure._() : super._();

  @override
  String? get message;
  DateTime? get cooldownEndDate;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuotaExceededFailureImplCopyWith<_$QuotaExceededFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServiceNotFoundImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServiceNotFoundImplCopyWith(_$ServiceNotFoundImpl value,
          $Res Function(_$ServiceNotFoundImpl) then) =
      __$$ServiceNotFoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ServiceNotFoundImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServiceNotFoundImpl>
    implements _$$ServiceNotFoundImplCopyWith<$Res> {
  __$$ServiceNotFoundImplCopyWithImpl(
      _$ServiceNotFoundImpl _value, $Res Function(_$ServiceNotFoundImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ServiceNotFoundImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ServiceNotFoundImpl extends _ServiceNotFound {
  const _$ServiceNotFoundImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'Failure.serviceNotFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceNotFoundImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceNotFoundImplCopyWith<_$ServiceNotFoundImpl> get copyWith =>
      __$$ServiceNotFoundImplCopyWithImpl<_$ServiceNotFoundImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return serviceNotFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return serviceNotFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (serviceNotFound != null) {
      return serviceNotFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return serviceNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return serviceNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (serviceNotFound != null) {
      return serviceNotFound(this);
    }
    return orElse();
  }
}

abstract class _ServiceNotFound extends Failure {
  const factory _ServiceNotFound({final String? message}) =
      _$ServiceNotFoundImpl;
  const _ServiceNotFound._() : super._();

  @override
  String? get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceNotFoundImplCopyWith<_$ServiceNotFoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServiceAlreadyExistsImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServiceAlreadyExistsImplCopyWith(_$ServiceAlreadyExistsImpl value,
          $Res Function(_$ServiceAlreadyExistsImpl) then) =
      __$$ServiceAlreadyExistsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ServiceAlreadyExistsImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServiceAlreadyExistsImpl>
    implements _$$ServiceAlreadyExistsImplCopyWith<$Res> {
  __$$ServiceAlreadyExistsImplCopyWithImpl(_$ServiceAlreadyExistsImpl _value,
      $Res Function(_$ServiceAlreadyExistsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ServiceAlreadyExistsImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ServiceAlreadyExistsImpl extends _ServiceAlreadyExists {
  const _$ServiceAlreadyExistsImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'Failure.serviceAlreadyExists(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceAlreadyExistsImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceAlreadyExistsImplCopyWith<_$ServiceAlreadyExistsImpl>
      get copyWith =>
          __$$ServiceAlreadyExistsImplCopyWithImpl<_$ServiceAlreadyExistsImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return serviceAlreadyExists(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return serviceAlreadyExists?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (serviceAlreadyExists != null) {
      return serviceAlreadyExists(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return serviceAlreadyExists(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return serviceAlreadyExists?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (serviceAlreadyExists != null) {
      return serviceAlreadyExists(this);
    }
    return orElse();
  }
}

abstract class _ServiceAlreadyExists extends Failure {
  const factory _ServiceAlreadyExists({final String? message}) =
      _$ServiceAlreadyExistsImpl;
  const _ServiceAlreadyExists._() : super._();

  @override
  String? get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceAlreadyExistsImplCopyWith<_$ServiceAlreadyExistsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsuffientFundsImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$InsuffientFundsImplCopyWith(_$InsuffientFundsImpl value,
          $Res Function(_$InsuffientFundsImpl) then) =
      __$$InsuffientFundsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$InsuffientFundsImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InsuffientFundsImpl>
    implements _$$InsuffientFundsImplCopyWith<$Res> {
  __$$InsuffientFundsImplCopyWithImpl(
      _$InsuffientFundsImpl _value, $Res Function(_$InsuffientFundsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$InsuffientFundsImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InsuffientFundsImpl extends _InsuffientFunds {
  const _$InsuffientFundsImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'Failure.insufficientFunds(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsuffientFundsImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsuffientFundsImplCopyWith<_$InsuffientFundsImpl> get copyWith =>
      __$$InsuffientFundsImplCopyWithImpl<_$InsuffientFundsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return insufficientFunds(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return insufficientFunds?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (insufficientFunds != null) {
      return insufficientFunds(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return insufficientFunds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return insufficientFunds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (insufficientFunds != null) {
      return insufficientFunds(this);
    }
    return orElse();
  }
}

abstract class _InsuffientFunds extends Failure {
  const factory _InsuffientFunds({final String? message}) =
      _$InsuffientFundsImpl;
  const _InsuffientFunds._() : super._();

  @override
  String? get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsuffientFundsImplCopyWith<_$InsuffientFundsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InauthorizedImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$InauthorizedImplCopyWith(
          _$InauthorizedImpl value, $Res Function(_$InauthorizedImpl) then) =
      __$$InauthorizedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$InauthorizedImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InauthorizedImpl>
    implements _$$InauthorizedImplCopyWith<$Res> {
  __$$InauthorizedImplCopyWithImpl(
      _$InauthorizedImpl _value, $Res Function(_$InauthorizedImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$InauthorizedImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InauthorizedImpl extends _Inauthorized {
  const _$InauthorizedImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'Failure.unauthorized(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InauthorizedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InauthorizedImplCopyWith<_$InauthorizedImpl> get copyWith =>
      __$$InauthorizedImplCopyWithImpl<_$InauthorizedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return unauthorized(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return unauthorized?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class _Inauthorized extends Failure {
  const factory _Inauthorized({final String? message}) = _$InauthorizedImpl;
  const _Inauthorized._() : super._();

  @override
  String? get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InauthorizedImplCopyWith<_$InauthorizedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidValueImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$InvalidValueImplCopyWith(
          _$InvalidValueImpl value, $Res Function(_$InvalidValueImpl) then) =
      __$$InvalidValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$InvalidValueImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InvalidValueImpl>
    implements _$$InvalidValueImplCopyWith<$Res> {
  __$$InvalidValueImplCopyWithImpl(
      _$InvalidValueImpl _value, $Res Function(_$InvalidValueImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$InvalidValueImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InvalidValueImpl extends _InvalidValue {
  const _$InvalidValueImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'Failure.invalidValue(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidValueImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidValueImplCopyWith<_$InvalidValueImpl> get copyWith =>
      __$$InvalidValueImplCopyWithImpl<_$InvalidValueImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return invalidValue(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return invalidValue?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (invalidValue != null) {
      return invalidValue(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return invalidValue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return invalidValue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (invalidValue != null) {
      return invalidValue(this);
    }
    return orElse();
  }
}

abstract class _InvalidValue extends Failure {
  const factory _InvalidValue({final String? message}) = _$InvalidValueImpl;
  const _InvalidValue._() : super._();

  @override
  String? get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvalidValueImplCopyWith<_$InvalidValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LockedApplicationImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$LockedApplicationImplCopyWith(_$LockedApplicationImpl value,
          $Res Function(_$LockedApplicationImpl) then) =
      __$$LockedApplicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$LockedApplicationImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$LockedApplicationImpl>
    implements _$$LockedApplicationImplCopyWith<$Res> {
  __$$LockedApplicationImplCopyWithImpl(_$LockedApplicationImpl _value,
      $Res Function(_$LockedApplicationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$LockedApplicationImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LockedApplicationImpl extends _LockedApplication {
  const _$LockedApplicationImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'Failure.locked(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LockedApplicationImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LockedApplicationImplCopyWith<_$LockedApplicationImpl> get copyWith =>
      __$$LockedApplicationImplCopyWithImpl<_$LockedApplicationImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return locked(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return locked?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (locked != null) {
      return locked(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return locked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return locked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (locked != null) {
      return locked(this);
    }
    return orElse();
  }
}

abstract class _LockedApplication extends Failure {
  const factory _LockedApplication({final String? message}) =
      _$LockedApplicationImpl;
  const _LockedApplication._() : super._();

  @override
  String? get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LockedApplicationImplCopyWith<_$LockedApplicationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtherFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$OtherFailureImplCopyWith(
          _$OtherFailureImpl value, $Res Function(_$OtherFailureImpl) then) =
      __$$OtherFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, Object? cause, StackTrace? stack});
}

/// @nodoc
class __$$OtherFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$OtherFailureImpl>
    implements _$$OtherFailureImplCopyWith<$Res> {
  __$$OtherFailureImplCopyWithImpl(
      _$OtherFailureImpl _value, $Res Function(_$OtherFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(_$OtherFailureImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      cause: freezed == cause ? _value.cause : cause,
      stack: freezed == stack
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$OtherFailureImpl extends _OtherFailure {
  const _$OtherFailureImpl({this.message, this.cause, this.stack}) : super._();

  @override
  final String? message;
  @override
  final Object? cause;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'Failure.other(message: $message, cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtherFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause), stack);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherFailureImplCopyWith<_$OtherFailureImpl> get copyWith =>
      __$$OtherFailureImplCopyWithImpl<_$OtherFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) loggedOut,
    required TResult Function(String? message) network,
    required TResult Function(String? message) operationCanceled,
    required TResult Function(String? message, DateTime? cooldownEndDate)
        quotaExceeded,
    required TResult Function(String? message) serviceNotFound,
    required TResult Function(String? message) serviceAlreadyExists,
    required TResult Function(String? message) insufficientFunds,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String? message) invalidValue,
    required TResult Function(String? message) locked,
    required TResult Function(String? message, Object? cause, StackTrace? stack)
        other,
  }) {
    return other(message, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? loggedOut,
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? operationCanceled,
    TResult? Function(String? message, DateTime? cooldownEndDate)?
        quotaExceeded,
    TResult? Function(String? message)? serviceNotFound,
    TResult? Function(String? message)? serviceAlreadyExists,
    TResult? Function(String? message)? insufficientFunds,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String? message)? invalidValue,
    TResult? Function(String? message)? locked,
    TResult? Function(String? message, Object? cause, StackTrace? stack)? other,
  }) {
    return other?.call(message, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? loggedOut,
    TResult Function(String? message)? network,
    TResult Function(String? message)? operationCanceled,
    TResult Function(String? message, DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function(String? message)? serviceNotFound,
    TResult Function(String? message)? serviceAlreadyExists,
    TResult Function(String? message)? insufficientFunds,
    TResult Function(String? message)? unauthorized,
    TResult Function(String? message)? invalidValue,
    TResult Function(String? message)? locked,
    TResult Function(String? message, Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(message, cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_OperationCanceled value) operationCanceled,
    required TResult Function(_QuotaExceededFailure value) quotaExceeded,
    required TResult Function(_ServiceNotFound value) serviceNotFound,
    required TResult Function(_ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(_InsuffientFunds value) insufficientFunds,
    required TResult Function(_Inauthorized value) unauthorized,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_LockedApplication value) locked,
    required TResult Function(_OtherFailure value) other,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_OperationCanceled value)? operationCanceled,
    TResult? Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(_ServiceNotFound value)? serviceNotFound,
    TResult? Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(_InsuffientFunds value)? insufficientFunds,
    TResult? Function(_Inauthorized value)? unauthorized,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_LockedApplication value)? locked,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_OperationCanceled value)? operationCanceled,
    TResult Function(_QuotaExceededFailure value)? quotaExceeded,
    TResult Function(_ServiceNotFound value)? serviceNotFound,
    TResult Function(_ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(_InsuffientFunds value)? insufficientFunds,
    TResult Function(_Inauthorized value)? unauthorized,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_LockedApplication value)? locked,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }
}

abstract class _OtherFailure extends Failure {
  const factory _OtherFailure(
      {final String? message,
      final Object? cause,
      final StackTrace? stack}) = _$OtherFailureImpl;
  const _OtherFailure._() : super._();

  @override
  String? get message;
  Object? get cause;
  StackTrace? get stack;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtherFailureImplCopyWith<_$OtherFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
