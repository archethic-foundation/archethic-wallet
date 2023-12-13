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
  bool get isAuthent => throw _privateConstructorUsedError;

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
  $Res call({int failedAttemptsCount, int maxAttemptsCount, bool isAuthent});
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
    Object? isAuthent = null,
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
      isAuthent: null == isAuthent
          ? _value.isAuthent
          : isAuthent // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call({int failedAttemptsCount, int maxAttemptsCount, bool isAuthent});
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
    Object? isAuthent = null,
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
      isAuthent: null == isAuthent
          ? _value.isAuthent
          : isAuthent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PasswordAuthenticationStateImpl extends _PasswordAuthenticationState {
  const _$PasswordAuthenticationStateImpl(
      {required this.failedAttemptsCount,
      required this.maxAttemptsCount,
      required this.isAuthent})
      : super._();

  @override
  final int failedAttemptsCount;
  @override
  final int maxAttemptsCount;
  @override
  final bool isAuthent;

  @override
  String toString() {
    return 'PasswordAuthenticationState(failedAttemptsCount: $failedAttemptsCount, maxAttemptsCount: $maxAttemptsCount, isAuthent: $isAuthent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordAuthenticationStateImpl &&
            (identical(other.failedAttemptsCount, failedAttemptsCount) ||
                other.failedAttemptsCount == failedAttemptsCount) &&
            (identical(other.maxAttemptsCount, maxAttemptsCount) ||
                other.maxAttemptsCount == maxAttemptsCount) &&
            (identical(other.isAuthent, isAuthent) ||
                other.isAuthent == isAuthent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, failedAttemptsCount, maxAttemptsCount, isAuthent);

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
      required final int maxAttemptsCount,
      required final bool isAuthent}) = _$PasswordAuthenticationStateImpl;
  const _PasswordAuthenticationState._() : super._();

  @override
  int get failedAttemptsCount;
  @override
  int get maxAttemptsCount;
  @override
  bool get isAuthent;
  @override
  @JsonKey(ignore: true)
  _$$PasswordAuthenticationStateImplCopyWith<_$PasswordAuthenticationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PinAuthenticationState {
  int get failedAttemptsCount => throw _privateConstructorUsedError;
  int get maxAttemptsCount => throw _privateConstructorUsedError;
  bool get isAuthent => throw _privateConstructorUsedError;

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
  $Res call({int failedAttemptsCount, int maxAttemptsCount, bool isAuthent});
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
    Object? isAuthent = null,
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
      isAuthent: null == isAuthent
          ? _value.isAuthent
          : isAuthent // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call({int failedAttemptsCount, int maxAttemptsCount, bool isAuthent});
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
    Object? isAuthent = null,
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
      isAuthent: null == isAuthent
          ? _value.isAuthent
          : isAuthent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PinAuthenticationStateImpl extends _PinAuthenticationState {
  const _$PinAuthenticationStateImpl(
      {required this.failedAttemptsCount,
      required this.maxAttemptsCount,
      required this.isAuthent})
      : super._();

  @override
  final int failedAttemptsCount;
  @override
  final int maxAttemptsCount;
  @override
  final bool isAuthent;

  @override
  String toString() {
    return 'PinAuthenticationState(failedAttemptsCount: $failedAttemptsCount, maxAttemptsCount: $maxAttemptsCount, isAuthent: $isAuthent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PinAuthenticationStateImpl &&
            (identical(other.failedAttemptsCount, failedAttemptsCount) ||
                other.failedAttemptsCount == failedAttemptsCount) &&
            (identical(other.maxAttemptsCount, maxAttemptsCount) ||
                other.maxAttemptsCount == maxAttemptsCount) &&
            (identical(other.isAuthent, isAuthent) ||
                other.isAuthent == isAuthent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, failedAttemptsCount, maxAttemptsCount, isAuthent);

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
      required final int maxAttemptsCount,
      required final bool isAuthent}) = _$PinAuthenticationStateImpl;
  const _PinAuthenticationState._() : super._();

  @override
  int get failedAttemptsCount;
  @override
  int get maxAttemptsCount;
  @override
  bool get isAuthent;
  @override
  @JsonKey(ignore: true)
  _$$PinAuthenticationStateImplCopyWith<_$PinAuthenticationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthenticationGuardState {
  /// Date at which the application should be locked
  /// [null] when application should not be locked
  DateTime? get lockDate => throw _privateConstructorUsedError;

  /// [true] when a timer should be set to
  /// lock application during use.
  bool get timerEnabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthenticationGuardStateCopyWith<AuthenticationGuardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationGuardStateCopyWith<$Res> {
  factory $AuthenticationGuardStateCopyWith(AuthenticationGuardState value,
          $Res Function(AuthenticationGuardState) then) =
      _$AuthenticationGuardStateCopyWithImpl<$Res, AuthenticationGuardState>;
  @useResult
  $Res call({DateTime? lockDate, bool timerEnabled});
}

/// @nodoc
class _$AuthenticationGuardStateCopyWithImpl<$Res,
        $Val extends AuthenticationGuardState>
    implements $AuthenticationGuardStateCopyWith<$Res> {
  _$AuthenticationGuardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lockDate = freezed,
    Object? timerEnabled = null,
  }) {
    return _then(_value.copyWith(
      lockDate: freezed == lockDate
          ? _value.lockDate
          : lockDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timerEnabled: null == timerEnabled
          ? _value.timerEnabled
          : timerEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthenticationGuardStateImplCopyWith<$Res>
    implements $AuthenticationGuardStateCopyWith<$Res> {
  factory _$$AuthenticationGuardStateImplCopyWith(
          _$AuthenticationGuardStateImpl value,
          $Res Function(_$AuthenticationGuardStateImpl) then) =
      __$$AuthenticationGuardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? lockDate, bool timerEnabled});
}

/// @nodoc
class __$$AuthenticationGuardStateImplCopyWithImpl<$Res>
    extends _$AuthenticationGuardStateCopyWithImpl<$Res,
        _$AuthenticationGuardStateImpl>
    implements _$$AuthenticationGuardStateImplCopyWith<$Res> {
  __$$AuthenticationGuardStateImplCopyWithImpl(
      _$AuthenticationGuardStateImpl _value,
      $Res Function(_$AuthenticationGuardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lockDate = freezed,
    Object? timerEnabled = null,
  }) {
    return _then(_$AuthenticationGuardStateImpl(
      lockDate: freezed == lockDate
          ? _value.lockDate
          : lockDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timerEnabled: null == timerEnabled
          ? _value.timerEnabled
          : timerEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthenticationGuardStateImpl extends _AuthenticationGuardState {
  const _$AuthenticationGuardStateImpl(
      {required this.lockDate, required this.timerEnabled})
      : super._();

  /// Date at which the application should be locked
  /// [null] when application should not be locked
  @override
  final DateTime? lockDate;

  /// [true] when a timer should be set to
  /// lock application during use.
  @override
  final bool timerEnabled;

  @override
  String toString() {
    return 'AuthenticationGuardState(lockDate: $lockDate, timerEnabled: $timerEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationGuardStateImpl &&
            (identical(other.lockDate, lockDate) ||
                other.lockDate == lockDate) &&
            (identical(other.timerEnabled, timerEnabled) ||
                other.timerEnabled == timerEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lockDate, timerEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationGuardStateImplCopyWith<_$AuthenticationGuardStateImpl>
      get copyWith => __$$AuthenticationGuardStateImplCopyWithImpl<
          _$AuthenticationGuardStateImpl>(this, _$identity);
}

abstract class _AuthenticationGuardState extends AuthenticationGuardState {
  const factory _AuthenticationGuardState(
      {required final DateTime? lockDate,
      required final bool timerEnabled}) = _$AuthenticationGuardStateImpl;
  const _AuthenticationGuardState._() : super._();

  @override

  /// Date at which the application should be locked
  /// [null] when application should not be locked
  DateTime? get lockDate;
  @override

  /// [true] when a timer should be set to
  /// lock application during use.
  bool get timerEnabled;
  @override
  @JsonKey(ignore: true)
  _$$AuthenticationGuardStateImplCopyWith<_$AuthenticationGuardStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$YubikeyAuthenticationState {
  int get failedAttemptsCount => throw _privateConstructorUsedError;
  int get maxAttemptsCount => throw _privateConstructorUsedError;
  bool get isAuthent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $YubikeyAuthenticationStateCopyWith<YubikeyAuthenticationState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YubikeyAuthenticationStateCopyWith<$Res> {
  factory $YubikeyAuthenticationStateCopyWith(YubikeyAuthenticationState value,
          $Res Function(YubikeyAuthenticationState) then) =
      _$YubikeyAuthenticationStateCopyWithImpl<$Res,
          YubikeyAuthenticationState>;
  @useResult
  $Res call({int failedAttemptsCount, int maxAttemptsCount, bool isAuthent});
}

/// @nodoc
class _$YubikeyAuthenticationStateCopyWithImpl<$Res,
        $Val extends YubikeyAuthenticationState>
    implements $YubikeyAuthenticationStateCopyWith<$Res> {
  _$YubikeyAuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedAttemptsCount = null,
    Object? maxAttemptsCount = null,
    Object? isAuthent = null,
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
      isAuthent: null == isAuthent
          ? _value.isAuthent
          : isAuthent // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YubikeyAuthenticationStateImplCopyWith<$Res>
    implements $YubikeyAuthenticationStateCopyWith<$Res> {
  factory _$$YubikeyAuthenticationStateImplCopyWith(
          _$YubikeyAuthenticationStateImpl value,
          $Res Function(_$YubikeyAuthenticationStateImpl) then) =
      __$$YubikeyAuthenticationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int failedAttemptsCount, int maxAttemptsCount, bool isAuthent});
}

/// @nodoc
class __$$YubikeyAuthenticationStateImplCopyWithImpl<$Res>
    extends _$YubikeyAuthenticationStateCopyWithImpl<$Res,
        _$YubikeyAuthenticationStateImpl>
    implements _$$YubikeyAuthenticationStateImplCopyWith<$Res> {
  __$$YubikeyAuthenticationStateImplCopyWithImpl(
      _$YubikeyAuthenticationStateImpl _value,
      $Res Function(_$YubikeyAuthenticationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedAttemptsCount = null,
    Object? maxAttemptsCount = null,
    Object? isAuthent = null,
  }) {
    return _then(_$YubikeyAuthenticationStateImpl(
      failedAttemptsCount: null == failedAttemptsCount
          ? _value.failedAttemptsCount
          : failedAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAttemptsCount: null == maxAttemptsCount
          ? _value.maxAttemptsCount
          : maxAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      isAuthent: null == isAuthent
          ? _value.isAuthent
          : isAuthent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$YubikeyAuthenticationStateImpl extends _YubikeyAuthenticationState {
  const _$YubikeyAuthenticationStateImpl(
      {required this.failedAttemptsCount,
      required this.maxAttemptsCount,
      required this.isAuthent})
      : super._();

  @override
  final int failedAttemptsCount;
  @override
  final int maxAttemptsCount;
  @override
  final bool isAuthent;

  @override
  String toString() {
    return 'YubikeyAuthenticationState(failedAttemptsCount: $failedAttemptsCount, maxAttemptsCount: $maxAttemptsCount, isAuthent: $isAuthent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YubikeyAuthenticationStateImpl &&
            (identical(other.failedAttemptsCount, failedAttemptsCount) ||
                other.failedAttemptsCount == failedAttemptsCount) &&
            (identical(other.maxAttemptsCount, maxAttemptsCount) ||
                other.maxAttemptsCount == maxAttemptsCount) &&
            (identical(other.isAuthent, isAuthent) ||
                other.isAuthent == isAuthent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, failedAttemptsCount, maxAttemptsCount, isAuthent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YubikeyAuthenticationStateImplCopyWith<_$YubikeyAuthenticationStateImpl>
      get copyWith => __$$YubikeyAuthenticationStateImplCopyWithImpl<
          _$YubikeyAuthenticationStateImpl>(this, _$identity);
}

abstract class _YubikeyAuthenticationState extends YubikeyAuthenticationState {
  const factory _YubikeyAuthenticationState(
      {required final int failedAttemptsCount,
      required final int maxAttemptsCount,
      required final bool isAuthent}) = _$YubikeyAuthenticationStateImpl;
  const _YubikeyAuthenticationState._() : super._();

  @override
  int get failedAttemptsCount;
  @override
  int get maxAttemptsCount;
  @override
  bool get isAuthent;
  @override
  @JsonKey(ignore: true)
  _$$YubikeyAuthenticationStateImplCopyWith<_$YubikeyAuthenticationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
