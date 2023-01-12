// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AutoLockState {
  /// After that date, application should lock when displayed
  DateTime? get lockDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AutoLockStateCopyWith<AutoLockState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoLockStateCopyWith<$Res> {
  factory $AutoLockStateCopyWith(
          AutoLockState value, $Res Function(AutoLockState) then) =
      _$AutoLockStateCopyWithImpl<$Res, AutoLockState>;
  @useResult
  $Res call({DateTime? lockDate});
}

/// @nodoc
class _$AutoLockStateCopyWithImpl<$Res, $Val extends AutoLockState>
    implements $AutoLockStateCopyWith<$Res> {
  _$AutoLockStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lockDate = freezed,
  }) {
    return _then(_value.copyWith(
      lockDate: freezed == lockDate
          ? _value.lockDate
          : lockDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AutoLockStateCopyWith<$Res>
    implements $AutoLockStateCopyWith<$Res> {
  factory _$$_AutoLockStateCopyWith(
          _$_AutoLockState value, $Res Function(_$_AutoLockState) then) =
      __$$_AutoLockStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? lockDate});
}

/// @nodoc
class __$$_AutoLockStateCopyWithImpl<$Res>
    extends _$AutoLockStateCopyWithImpl<$Res, _$_AutoLockState>
    implements _$$_AutoLockStateCopyWith<$Res> {
  __$$_AutoLockStateCopyWithImpl(
      _$_AutoLockState _value, $Res Function(_$_AutoLockState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lockDate = freezed,
  }) {
    return _then(_$_AutoLockState(
      lockDate: freezed == lockDate
          ? _value.lockDate
          : lockDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_AutoLockState extends _AutoLockState {
  const _$_AutoLockState({this.lockDate}) : super._();

  /// After that date, application should lock when displayed
  @override
  final DateTime? lockDate;

  @override
  String toString() {
    return 'AutoLockState(lockDate: $lockDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AutoLockState &&
            (identical(other.lockDate, lockDate) ||
                other.lockDate == lockDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lockDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AutoLockStateCopyWith<_$_AutoLockState> get copyWith =>
      __$$_AutoLockStateCopyWithImpl<_$_AutoLockState>(this, _$identity);
}

abstract class _AutoLockState extends AutoLockState {
  const factory _AutoLockState({final DateTime? lockDate}) = _$_AutoLockState;
  const _AutoLockState._() : super._();

  @override

  /// After that date, application should lock when displayed
  DateTime? get lockDate;
  @override
  @JsonKey(ignore: true)
  _$$_AutoLockStateCopyWith<_$_AutoLockState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PasswordAuthenticationState {
  int get failedAttemptsCount => throw _privateConstructorUsedError;
  int get maxAttemptsCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PasswordAuthenticationStateCopyWith<PasswordAuthenticationState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordAuthenticationStateCopyWith<$Res> {
  factory $PasswordAuthenticationStateCopyWith(
          PasswordAuthenticationState value,
          $Res Function(PasswordAuthenticationState) then) =
      _$PasswordAuthenticationStateCopyWithImpl<$Res,
          PasswordAuthenticationState>;
  @useResult
  $Res call({int failedAttemptsCount, int maxAttemptsCount});
}

/// @nodoc
class _$PasswordAuthenticationStateCopyWithImpl<$Res,
        $Val extends PasswordAuthenticationState>
    implements $PasswordAuthenticationStateCopyWith<$Res> {
  _$PasswordAuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedAttemptsCount = null,
    Object? maxAttemptsCount = null,
  }) {
    return _then(_value.copyWith(
      failedAttemptsCount: null == failedAttemptsCount
          ? _value.failedAttemptsCount
          : failedAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAttemptsCount: null == maxAttemptsCount
          ? _value.maxAttemptsCount
          : maxAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PasswordAuthenticationStateCopyWith<$Res>
    implements $PasswordAuthenticationStateCopyWith<$Res> {
  factory _$$_PasswordAuthenticationStateCopyWith(
          _$_PasswordAuthenticationState value,
          $Res Function(_$_PasswordAuthenticationState) then) =
      __$$_PasswordAuthenticationStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int failedAttemptsCount, int maxAttemptsCount});
}

/// @nodoc
class __$$_PasswordAuthenticationStateCopyWithImpl<$Res>
    extends _$PasswordAuthenticationStateCopyWithImpl<$Res,
        _$_PasswordAuthenticationState>
    implements _$$_PasswordAuthenticationStateCopyWith<$Res> {
  __$$_PasswordAuthenticationStateCopyWithImpl(
      _$_PasswordAuthenticationState _value,
      $Res Function(_$_PasswordAuthenticationState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedAttemptsCount = null,
    Object? maxAttemptsCount = null,
  }) {
    return _then(_$_PasswordAuthenticationState(
      failedAttemptsCount: null == failedAttemptsCount
          ? _value.failedAttemptsCount
          : failedAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAttemptsCount: null == maxAttemptsCount
          ? _value.maxAttemptsCount
          : maxAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_PasswordAuthenticationState extends _PasswordAuthenticationState {
  const _$_PasswordAuthenticationState(
      {required this.failedAttemptsCount, required this.maxAttemptsCount})
      : super._();

  @override
  final int failedAttemptsCount;
  @override
  final int maxAttemptsCount;

  @override
  String toString() {
    return 'PasswordAuthenticationState(failedAttemptsCount: $failedAttemptsCount, maxAttemptsCount: $maxAttemptsCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PasswordAuthenticationState &&
            (identical(other.failedAttemptsCount, failedAttemptsCount) ||
                other.failedAttemptsCount == failedAttemptsCount) &&
            (identical(other.maxAttemptsCount, maxAttemptsCount) ||
                other.maxAttemptsCount == maxAttemptsCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, failedAttemptsCount, maxAttemptsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PasswordAuthenticationStateCopyWith<_$_PasswordAuthenticationState>
      get copyWith => __$$_PasswordAuthenticationStateCopyWithImpl<
          _$_PasswordAuthenticationState>(this, _$identity);
}

abstract class _PasswordAuthenticationState
    extends PasswordAuthenticationState {
  const factory _PasswordAuthenticationState(
      {required final int failedAttemptsCount,
      required final int maxAttemptsCount}) = _$_PasswordAuthenticationState;
  const _PasswordAuthenticationState._() : super._();

  @override
  int get failedAttemptsCount;
  @override
  int get maxAttemptsCount;
  @override
  @JsonKey(ignore: true)
  _$$_PasswordAuthenticationStateCopyWith<_$_PasswordAuthenticationState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PinAuthenticationState {
  int get failedAttemptsCount => throw _privateConstructorUsedError;
  int get maxAttemptsCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PinAuthenticationStateCopyWith<PinAuthenticationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PinAuthenticationStateCopyWith<$Res> {
  factory $PinAuthenticationStateCopyWith(PinAuthenticationState value,
          $Res Function(PinAuthenticationState) then) =
      _$PinAuthenticationStateCopyWithImpl<$Res, PinAuthenticationState>;
  @useResult
  $Res call({int failedAttemptsCount, int maxAttemptsCount});
}

/// @nodoc
class _$PinAuthenticationStateCopyWithImpl<$Res,
        $Val extends PinAuthenticationState>
    implements $PinAuthenticationStateCopyWith<$Res> {
  _$PinAuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedAttemptsCount = null,
    Object? maxAttemptsCount = null,
  }) {
    return _then(_value.copyWith(
      failedAttemptsCount: null == failedAttemptsCount
          ? _value.failedAttemptsCount
          : failedAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAttemptsCount: null == maxAttemptsCount
          ? _value.maxAttemptsCount
          : maxAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PinAuthenticationStateCopyWith<$Res>
    implements $PinAuthenticationStateCopyWith<$Res> {
  factory _$$_PinAuthenticationStateCopyWith(_$_PinAuthenticationState value,
          $Res Function(_$_PinAuthenticationState) then) =
      __$$_PinAuthenticationStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int failedAttemptsCount, int maxAttemptsCount});
}

/// @nodoc
class __$$_PinAuthenticationStateCopyWithImpl<$Res>
    extends _$PinAuthenticationStateCopyWithImpl<$Res,
        _$_PinAuthenticationState>
    implements _$$_PinAuthenticationStateCopyWith<$Res> {
  __$$_PinAuthenticationStateCopyWithImpl(_$_PinAuthenticationState _value,
      $Res Function(_$_PinAuthenticationState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedAttemptsCount = null,
    Object? maxAttemptsCount = null,
  }) {
    return _then(_$_PinAuthenticationState(
      failedAttemptsCount: null == failedAttemptsCount
          ? _value.failedAttemptsCount
          : failedAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAttemptsCount: null == maxAttemptsCount
          ? _value.maxAttemptsCount
          : maxAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_PinAuthenticationState extends _PinAuthenticationState {
  const _$_PinAuthenticationState(
      {required this.failedAttemptsCount, required this.maxAttemptsCount})
      : super._();

  @override
  final int failedAttemptsCount;
  @override
  final int maxAttemptsCount;

  @override
  String toString() {
    return 'PinAuthenticationState(failedAttemptsCount: $failedAttemptsCount, maxAttemptsCount: $maxAttemptsCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PinAuthenticationState &&
            (identical(other.failedAttemptsCount, failedAttemptsCount) ||
                other.failedAttemptsCount == failedAttemptsCount) &&
            (identical(other.maxAttemptsCount, maxAttemptsCount) ||
                other.maxAttemptsCount == maxAttemptsCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, failedAttemptsCount, maxAttemptsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PinAuthenticationStateCopyWith<_$_PinAuthenticationState> get copyWith =>
      __$$_PinAuthenticationStateCopyWithImpl<_$_PinAuthenticationState>(
          this, _$identity);
}

abstract class _PinAuthenticationState extends PinAuthenticationState {
  const factory _PinAuthenticationState(
      {required final int failedAttemptsCount,
      required final int maxAttemptsCount}) = _$_PinAuthenticationState;
  const _PinAuthenticationState._() : super._();

  @override
  int get failedAttemptsCount;
  @override
  int get maxAttemptsCount;
  @override
  @JsonKey(ignore: true)
  _$$_PinAuthenticationStateCopyWith<_$_PinAuthenticationState> get copyWith =>
      throw _privateConstructorUsedError;
}
