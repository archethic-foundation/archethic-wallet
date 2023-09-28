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
abstract class _$$PasswordAuthenticationStateImplCopyWith<$Res>
    implements $PasswordAuthenticationStateCopyWith<$Res> {
  factory _$$PasswordAuthenticationStateImplCopyWith(
          _$PasswordAuthenticationStateImpl value,
          $Res Function(_$PasswordAuthenticationStateImpl) then) =
      __$$PasswordAuthenticationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int failedAttemptsCount, int maxAttemptsCount});
}

/// @nodoc
class __$$PasswordAuthenticationStateImplCopyWithImpl<$Res>
    extends _$PasswordAuthenticationStateCopyWithImpl<$Res,
        _$PasswordAuthenticationStateImpl>
    implements _$$PasswordAuthenticationStateImplCopyWith<$Res> {
  __$$PasswordAuthenticationStateImplCopyWithImpl(
      _$PasswordAuthenticationStateImpl _value,
      $Res Function(_$PasswordAuthenticationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedAttemptsCount = null,
    Object? maxAttemptsCount = null,
  }) {
    return _then(_$PasswordAuthenticationStateImpl(
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

class _$PasswordAuthenticationStateImpl extends _PasswordAuthenticationState {
  const _$PasswordAuthenticationStateImpl(
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
            other is _$PasswordAuthenticationStateImpl &&
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
  _$$PasswordAuthenticationStateImplCopyWith<_$PasswordAuthenticationStateImpl>
      get copyWith => __$$PasswordAuthenticationStateImplCopyWithImpl<
          _$PasswordAuthenticationStateImpl>(this, _$identity);
}

abstract class _PasswordAuthenticationState
    extends PasswordAuthenticationState {
  const factory _PasswordAuthenticationState(
      {required final int failedAttemptsCount,
      required final int maxAttemptsCount}) = _$PasswordAuthenticationStateImpl;
  const _PasswordAuthenticationState._() : super._();

  @override
  int get failedAttemptsCount;
  @override
  int get maxAttemptsCount;
  @override
  @JsonKey(ignore: true)
  _$$PasswordAuthenticationStateImplCopyWith<_$PasswordAuthenticationStateImpl>
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
abstract class _$$PinAuthenticationStateImplCopyWith<$Res>
    implements $PinAuthenticationStateCopyWith<$Res> {
  factory _$$PinAuthenticationStateImplCopyWith(
          _$PinAuthenticationStateImpl value,
          $Res Function(_$PinAuthenticationStateImpl) then) =
      __$$PinAuthenticationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int failedAttemptsCount, int maxAttemptsCount});
}

/// @nodoc
class __$$PinAuthenticationStateImplCopyWithImpl<$Res>
    extends _$PinAuthenticationStateCopyWithImpl<$Res,
        _$PinAuthenticationStateImpl>
    implements _$$PinAuthenticationStateImplCopyWith<$Res> {
  __$$PinAuthenticationStateImplCopyWithImpl(
      _$PinAuthenticationStateImpl _value,
      $Res Function(_$PinAuthenticationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedAttemptsCount = null,
    Object? maxAttemptsCount = null,
  }) {
    return _then(_$PinAuthenticationStateImpl(
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

class _$PinAuthenticationStateImpl extends _PinAuthenticationState {
  const _$PinAuthenticationStateImpl(
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
            other is _$PinAuthenticationStateImpl &&
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
  _$$PinAuthenticationStateImplCopyWith<_$PinAuthenticationStateImpl>
      get copyWith => __$$PinAuthenticationStateImplCopyWithImpl<
          _$PinAuthenticationStateImpl>(this, _$identity);
}

abstract class _PinAuthenticationState extends PinAuthenticationState {
  const factory _PinAuthenticationState(
      {required final int failedAttemptsCount,
      required final int maxAttemptsCount}) = _$PinAuthenticationStateImpl;
  const _PinAuthenticationState._() : super._();

  @override
  int get failedAttemptsCount;
  @override
  int get maxAttemptsCount;
  @override
  @JsonKey(ignore: true)
  _$$PinAuthenticationStateImplCopyWith<_$PinAuthenticationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StartupAuthentState {
  /// After that date, application should lock when displayed
  DateTime? get lockDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StartupAuthentStateCopyWith<StartupAuthentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StartupAuthentStateCopyWith<$Res> {
  factory $StartupAuthentStateCopyWith(
          StartupAuthentState value, $Res Function(StartupAuthentState) then) =
      _$StartupAuthentStateCopyWithImpl<$Res, StartupAuthentState>;
  @useResult
  $Res call({DateTime? lockDate});
}

/// @nodoc
class _$StartupAuthentStateCopyWithImpl<$Res, $Val extends StartupAuthentState>
    implements $StartupAuthentStateCopyWith<$Res> {
  _$StartupAuthentStateCopyWithImpl(this._value, this._then);

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
abstract class _$$StartupAuthentStateImplCopyWith<$Res>
    implements $StartupAuthentStateCopyWith<$Res> {
  factory _$$StartupAuthentStateImplCopyWith(_$StartupAuthentStateImpl value,
          $Res Function(_$StartupAuthentStateImpl) then) =
      __$$StartupAuthentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? lockDate});
}

/// @nodoc
class __$$StartupAuthentStateImplCopyWithImpl<$Res>
    extends _$StartupAuthentStateCopyWithImpl<$Res, _$StartupAuthentStateImpl>
    implements _$$StartupAuthentStateImplCopyWith<$Res> {
  __$$StartupAuthentStateImplCopyWithImpl(_$StartupAuthentStateImpl _value,
      $Res Function(_$StartupAuthentStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lockDate = freezed,
  }) {
    return _then(_$StartupAuthentStateImpl(
      lockDate: freezed == lockDate
          ? _value.lockDate
          : lockDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$StartupAuthentStateImpl extends _StartupAuthentState {
  const _$StartupAuthentStateImpl({this.lockDate}) : super._();

  /// After that date, application should lock when displayed
  @override
  final DateTime? lockDate;

  @override
  String toString() {
    return 'StartupAuthentState(lockDate: $lockDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartupAuthentStateImpl &&
            (identical(other.lockDate, lockDate) ||
                other.lockDate == lockDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lockDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StartupAuthentStateImplCopyWith<_$StartupAuthentStateImpl> get copyWith =>
      __$$StartupAuthentStateImplCopyWithImpl<_$StartupAuthentStateImpl>(
          this, _$identity);
}

abstract class _StartupAuthentState extends StartupAuthentState {
  const factory _StartupAuthentState({final DateTime? lockDate}) =
      _$StartupAuthentStateImpl;
  const _StartupAuthentState._() : super._();

  @override

  /// After that date, application should lock when displayed
  DateTime? get lockDate;
  @override
  @JsonKey(ignore: true)
  _$$StartupAuthentStateImplCopyWith<_$StartupAuthentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
