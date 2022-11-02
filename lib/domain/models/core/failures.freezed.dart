// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Failure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function() invalidValue,
    required TResult Function(Object? cause, StackTrace? stack) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function()? invalidValue,
    TResult? Function(Object? cause, StackTrace? stack)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function()? invalidValue,
    TResult Function(Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_OtherFailure value) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_OtherFailure value)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_InvalidValue value)? invalidValue,
    TResult Function(_OtherFailure value)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_LoggedOutCopyWith<$Res> {
  factory _$$_LoggedOutCopyWith(
          _$_LoggedOut value, $Res Function(_$_LoggedOut) then) =
      __$$_LoggedOutCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoggedOutCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$_LoggedOut>
    implements _$$_LoggedOutCopyWith<$Res> {
  __$$_LoggedOutCopyWithImpl(
      _$_LoggedOut _value, $Res Function(_$_LoggedOut) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_LoggedOut extends _LoggedOut {
  const _$_LoggedOut() : super._();

  @override
  String toString() {
    return 'Failure.loggedOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_LoggedOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function() invalidValue,
    required TResult Function(Object? cause, StackTrace? stack) other,
  }) {
    return loggedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function()? invalidValue,
    TResult? Function(Object? cause, StackTrace? stack)? other,
  }) {
    return loggedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function()? invalidValue,
    TResult Function(Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_OtherFailure value) other,
  }) {
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return loggedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_InvalidValue value)? invalidValue,
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
  const factory _LoggedOut() = _$_LoggedOut;
  const _LoggedOut._() : super._();
}

/// @nodoc
abstract class _$$_NetworkFailureCopyWith<$Res> {
  factory _$$_NetworkFailureCopyWith(
          _$_NetworkFailure value, $Res Function(_$_NetworkFailure) then) =
      __$$_NetworkFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_NetworkFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$_NetworkFailure>
    implements _$$_NetworkFailureCopyWith<$Res> {
  __$$_NetworkFailureCopyWithImpl(
      _$_NetworkFailure _value, $Res Function(_$_NetworkFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_NetworkFailure extends _NetworkFailure {
  const _$_NetworkFailure() : super._();

  @override
  String toString() {
    return 'Failure.network()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_NetworkFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function() invalidValue,
    required TResult Function(Object? cause, StackTrace? stack) other,
  }) {
    return network();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function()? invalidValue,
    TResult? Function(Object? cause, StackTrace? stack)? other,
  }) {
    return network?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function()? invalidValue,
    TResult Function(Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_OtherFailure value) other,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_InvalidValue value)? invalidValue,
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
  const factory _NetworkFailure() = _$_NetworkFailure;
  const _NetworkFailure._() : super._();
}

/// @nodoc
abstract class _$$_InvalidValueCopyWith<$Res> {
  factory _$$_InvalidValueCopyWith(
          _$_InvalidValue value, $Res Function(_$_InvalidValue) then) =
      __$$_InvalidValueCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InvalidValueCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$_InvalidValue>
    implements _$$_InvalidValueCopyWith<$Res> {
  __$$_InvalidValueCopyWithImpl(
      _$_InvalidValue _value, $Res Function(_$_InvalidValue) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_InvalidValue extends _InvalidValue {
  const _$_InvalidValue() : super._();

  @override
  String toString() {
    return 'Failure.invalidValue()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_InvalidValue);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function() invalidValue,
    required TResult Function(Object? cause, StackTrace? stack) other,
  }) {
    return invalidValue();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function()? invalidValue,
    TResult? Function(Object? cause, StackTrace? stack)? other,
  }) {
    return invalidValue?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function()? invalidValue,
    TResult Function(Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (invalidValue != null) {
      return invalidValue();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_OtherFailure value) other,
  }) {
    return invalidValue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return invalidValue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_InvalidValue value)? invalidValue,
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
  const factory _InvalidValue() = _$_InvalidValue;
  const _InvalidValue._() : super._();
}

/// @nodoc
abstract class _$$_OtherFailureCopyWith<$Res> {
  factory _$$_OtherFailureCopyWith(
          _$_OtherFailure value, $Res Function(_$_OtherFailure) then) =
      __$$_OtherFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({Object? cause, StackTrace? stack});
}

/// @nodoc
class __$$_OtherFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$_OtherFailure>
    implements _$$_OtherFailureCopyWith<$Res> {
  __$$_OtherFailureCopyWithImpl(
      _$_OtherFailure _value, $Res Function(_$_OtherFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(_$_OtherFailure(
      cause: freezed == cause ? _value.cause : cause,
      stack: freezed == stack
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$_OtherFailure extends _OtherFailure {
  const _$_OtherFailure({this.cause, this.stack}) : super._();

  @override
  final Object? cause;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'Failure.other(cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OtherFailure &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(cause), stack);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OtherFailureCopyWith<_$_OtherFailure> get copyWith =>
      __$$_OtherFailureCopyWithImpl<_$_OtherFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function() invalidValue,
    required TResult Function(Object? cause, StackTrace? stack) other,
  }) {
    return other(cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function()? invalidValue,
    TResult? Function(Object? cause, StackTrace? stack)? other,
  }) {
    return other?.call(cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function()? invalidValue,
    TResult Function(Object? cause, StackTrace? stack)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_InvalidValue value) invalidValue,
    required TResult Function(_OtherFailure value) other,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_InvalidValue value)? invalidValue,
    TResult? Function(_OtherFailure value)? other,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_InvalidValue value)? invalidValue,
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
  const factory _OtherFailure({final Object? cause, final StackTrace? stack}) =
      _$_OtherFailure;
  const _OtherFailure._() : super._();

  Object? get cause;
  StackTrace? get stack;
  @JsonKey(ignore: true)
  _$$_OtherFailureCopyWith<_$_OtherFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
