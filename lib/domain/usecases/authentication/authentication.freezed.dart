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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List decodedChallenge) success,
    required TResult Function() wrongCredentials,
    required TResult Function() notSetup,
    required TResult Function() tooMuchAttempts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List decodedChallenge)? success,
    TResult? Function()? wrongCredentials,
    TResult? Function()? notSetup,
    TResult? Function()? tooMuchAttempts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List decodedChallenge)? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationResult value) success,
    required TResult Function(_AuthenticationFailure value) wrongCredentials,
    required TResult Function(_AuthenticationNotSetup value) notSetup,
    required TResult Function(_AuthenticationTooMuchAttempts value)
        tooMuchAttempts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationResult value)? success,
    TResult? Function(_AuthenticationFailure value)? wrongCredentials,
    TResult? Function(_AuthenticationNotSetup value)? notSetup,
    TResult? Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationResultCopyWith<$Res> {
  factory $AuthenticationResultCopyWith(AuthenticationResult value,
          $Res Function(AuthenticationResult) then) =
      _$AuthenticationResultCopyWithImpl<$Res, AuthenticationResult>;
}

/// @nodoc
class _$AuthenticationResultCopyWithImpl<$Res,
        $Val extends AuthenticationResult>
    implements $AuthenticationResultCopyWith<$Res> {
  _$AuthenticationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthenticationResultImplCopyWith<$Res> {
  factory _$$AuthenticationResultImplCopyWith(_$AuthenticationResultImpl value,
          $Res Function(_$AuthenticationResultImpl) then) =
      __$$AuthenticationResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uint8List decodedChallenge});
}

/// @nodoc
class __$$AuthenticationResultImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res, _$AuthenticationResultImpl>
    implements _$$AuthenticationResultImplCopyWith<$Res> {
  __$$AuthenticationResultImplCopyWithImpl(_$AuthenticationResultImpl _value,
      $Res Function(_$AuthenticationResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decodedChallenge = null,
  }) {
    return _then(_$AuthenticationResultImpl(
      decodedChallenge: null == decodedChallenge
          ? _value.decodedChallenge
          : decodedChallenge // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$AuthenticationResultImpl extends _AuthenticationResult
    with DiagnosticableTreeMixin {
  const _$AuthenticationResultImpl({required this.decodedChallenge})
      : super._();

  @override
  final Uint8List decodedChallenge;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthenticationResult.success(decodedChallenge: $decodedChallenge)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthenticationResult.success'))
      ..add(DiagnosticsProperty('decodedChallenge', decodedChallenge));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationResultImpl &&
            const DeepCollectionEquality()
                .equals(other.decodedChallenge, decodedChallenge));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(decodedChallenge));

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationResultImplCopyWith<_$AuthenticationResultImpl>
      get copyWith =>
          __$$AuthenticationResultImplCopyWithImpl<_$AuthenticationResultImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List decodedChallenge) success,
    required TResult Function() wrongCredentials,
    required TResult Function() notSetup,
    required TResult Function() tooMuchAttempts,
  }) {
    return success(decodedChallenge);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List decodedChallenge)? success,
    TResult? Function()? wrongCredentials,
    TResult? Function()? notSetup,
    TResult? Function()? tooMuchAttempts,
  }) {
    return success?.call(decodedChallenge);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List decodedChallenge)? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(decodedChallenge);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationResult value) success,
    required TResult Function(_AuthenticationFailure value) wrongCredentials,
    required TResult Function(_AuthenticationNotSetup value) notSetup,
    required TResult Function(_AuthenticationTooMuchAttempts value)
        tooMuchAttempts,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationResult value)? success,
    TResult? Function(_AuthenticationFailure value)? wrongCredentials,
    TResult? Function(_AuthenticationNotSetup value)? notSetup,
    TResult? Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationResult extends AuthenticationResult {
  const factory _AuthenticationResult(
      {required final Uint8List decodedChallenge}) = _$AuthenticationResultImpl;
  const _AuthenticationResult._() : super._();

  Uint8List get decodedChallenge;

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationResultImplCopyWith<_$AuthenticationResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationFailureImplCopyWith<$Res> {
  factory _$$AuthenticationFailureImplCopyWith(
          _$AuthenticationFailureImpl value,
          $Res Function(_$AuthenticationFailureImpl) then) =
      __$$AuthenticationFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationFailureImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res,
        _$AuthenticationFailureImpl>
    implements _$$AuthenticationFailureImplCopyWith<$Res> {
  __$$AuthenticationFailureImplCopyWithImpl(_$AuthenticationFailureImpl _value,
      $Res Function(_$AuthenticationFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthenticationFailureImpl extends _AuthenticationFailure
    with DiagnosticableTreeMixin {
  const _$AuthenticationFailureImpl() : super._();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthenticationResult.wrongCredentials()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty('type', 'AuthenticationResult.wrongCredentials'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationFailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List decodedChallenge) success,
    required TResult Function() wrongCredentials,
    required TResult Function() notSetup,
    required TResult Function() tooMuchAttempts,
  }) {
    return wrongCredentials();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List decodedChallenge)? success,
    TResult? Function()? wrongCredentials,
    TResult? Function()? notSetup,
    TResult? Function()? tooMuchAttempts,
  }) {
    return wrongCredentials?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List decodedChallenge)? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (wrongCredentials != null) {
      return wrongCredentials();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationResult value) success,
    required TResult Function(_AuthenticationFailure value) wrongCredentials,
    required TResult Function(_AuthenticationNotSetup value) notSetup,
    required TResult Function(_AuthenticationTooMuchAttempts value)
        tooMuchAttempts,
  }) {
    return wrongCredentials(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationResult value)? success,
    TResult? Function(_AuthenticationFailure value)? wrongCredentials,
    TResult? Function(_AuthenticationNotSetup value)? notSetup,
    TResult? Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
  }) {
    return wrongCredentials?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (wrongCredentials != null) {
      return wrongCredentials(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationFailure extends AuthenticationResult {
  const factory _AuthenticationFailure() = _$AuthenticationFailureImpl;
  const _AuthenticationFailure._() : super._();
}

/// @nodoc
abstract class _$$AuthenticationNotSetupImplCopyWith<$Res> {
  factory _$$AuthenticationNotSetupImplCopyWith(
          _$AuthenticationNotSetupImpl value,
          $Res Function(_$AuthenticationNotSetupImpl) then) =
      __$$AuthenticationNotSetupImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationNotSetupImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res,
        _$AuthenticationNotSetupImpl>
    implements _$$AuthenticationNotSetupImplCopyWith<$Res> {
  __$$AuthenticationNotSetupImplCopyWithImpl(
      _$AuthenticationNotSetupImpl _value,
      $Res Function(_$AuthenticationNotSetupImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthenticationNotSetupImpl extends _AuthenticationNotSetup
    with DiagnosticableTreeMixin {
  const _$AuthenticationNotSetupImpl() : super._();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthenticationResult.notSetup()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'AuthenticationResult.notSetup'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationNotSetupImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List decodedChallenge) success,
    required TResult Function() wrongCredentials,
    required TResult Function() notSetup,
    required TResult Function() tooMuchAttempts,
  }) {
    return notSetup();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List decodedChallenge)? success,
    TResult? Function()? wrongCredentials,
    TResult? Function()? notSetup,
    TResult? Function()? tooMuchAttempts,
  }) {
    return notSetup?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List decodedChallenge)? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (notSetup != null) {
      return notSetup();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationResult value) success,
    required TResult Function(_AuthenticationFailure value) wrongCredentials,
    required TResult Function(_AuthenticationNotSetup value) notSetup,
    required TResult Function(_AuthenticationTooMuchAttempts value)
        tooMuchAttempts,
  }) {
    return notSetup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationResult value)? success,
    TResult? Function(_AuthenticationFailure value)? wrongCredentials,
    TResult? Function(_AuthenticationNotSetup value)? notSetup,
    TResult? Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
  }) {
    return notSetup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (notSetup != null) {
      return notSetup(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationNotSetup extends AuthenticationResult {
  const factory _AuthenticationNotSetup() = _$AuthenticationNotSetupImpl;
  const _AuthenticationNotSetup._() : super._();
}

/// @nodoc
abstract class _$$AuthenticationTooMuchAttemptsImplCopyWith<$Res> {
  factory _$$AuthenticationTooMuchAttemptsImplCopyWith(
          _$AuthenticationTooMuchAttemptsImpl value,
          $Res Function(_$AuthenticationTooMuchAttemptsImpl) then) =
      __$$AuthenticationTooMuchAttemptsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationTooMuchAttemptsImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res,
        _$AuthenticationTooMuchAttemptsImpl>
    implements _$$AuthenticationTooMuchAttemptsImplCopyWith<$Res> {
  __$$AuthenticationTooMuchAttemptsImplCopyWithImpl(
      _$AuthenticationTooMuchAttemptsImpl _value,
      $Res Function(_$AuthenticationTooMuchAttemptsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthenticationTooMuchAttemptsImpl extends _AuthenticationTooMuchAttempts
    with DiagnosticableTreeMixin {
  const _$AuthenticationTooMuchAttemptsImpl() : super._();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthenticationResult.tooMuchAttempts()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty('type', 'AuthenticationResult.tooMuchAttempts'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationTooMuchAttemptsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List decodedChallenge) success,
    required TResult Function() wrongCredentials,
    required TResult Function() notSetup,
    required TResult Function() tooMuchAttempts,
  }) {
    return tooMuchAttempts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List decodedChallenge)? success,
    TResult? Function()? wrongCredentials,
    TResult? Function()? notSetup,
    TResult? Function()? tooMuchAttempts,
  }) {
    return tooMuchAttempts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List decodedChallenge)? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (tooMuchAttempts != null) {
      return tooMuchAttempts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationResult value) success,
    required TResult Function(_AuthenticationFailure value) wrongCredentials,
    required TResult Function(_AuthenticationNotSetup value) notSetup,
    required TResult Function(_AuthenticationTooMuchAttempts value)
        tooMuchAttempts,
  }) {
    return tooMuchAttempts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationResult value)? success,
    TResult? Function(_AuthenticationFailure value)? wrongCredentials,
    TResult? Function(_AuthenticationNotSetup value)? notSetup,
    TResult? Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
  }) {
    return tooMuchAttempts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (tooMuchAttempts != null) {
      return tooMuchAttempts(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationTooMuchAttempts extends AuthenticationResult {
  const factory _AuthenticationTooMuchAttempts() =
      _$AuthenticationTooMuchAttemptsImpl;
  const _AuthenticationTooMuchAttempts._() : super._();
}

/// @nodoc
mixin _$UpdatePinResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List encodedChallenge) success,
    required TResult Function() pinsDoNotMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List encodedChallenge)? success,
    TResult? Function()? pinsDoNotMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List encodedChallenge)? success,
    TResult Function()? pinsDoNotMatch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePinSuccess value) success,
    required TResult Function(_UpdatePinDoNotMatch value) pinsDoNotMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePinSuccess value)? success,
    TResult? Function(_UpdatePinDoNotMatch value)? pinsDoNotMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePinSuccess value)? success,
    TResult Function(_UpdatePinDoNotMatch value)? pinsDoNotMatch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePinResultCopyWith<$Res> {
  factory $UpdatePinResultCopyWith(
          UpdatePinResult value, $Res Function(UpdatePinResult) then) =
      _$UpdatePinResultCopyWithImpl<$Res, UpdatePinResult>;
}

/// @nodoc
class _$UpdatePinResultCopyWithImpl<$Res, $Val extends UpdatePinResult>
    implements $UpdatePinResultCopyWith<$Res> {
  _$UpdatePinResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePinResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UpdatePinSuccessImplCopyWith<$Res> {
  factory _$$UpdatePinSuccessImplCopyWith(_$UpdatePinSuccessImpl value,
          $Res Function(_$UpdatePinSuccessImpl) then) =
      __$$UpdatePinSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uint8List encodedChallenge});
}

/// @nodoc
class __$$UpdatePinSuccessImplCopyWithImpl<$Res>
    extends _$UpdatePinResultCopyWithImpl<$Res, _$UpdatePinSuccessImpl>
    implements _$$UpdatePinSuccessImplCopyWith<$Res> {
  __$$UpdatePinSuccessImplCopyWithImpl(_$UpdatePinSuccessImpl _value,
      $Res Function(_$UpdatePinSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePinResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encodedChallenge = null,
  }) {
    return _then(_$UpdatePinSuccessImpl(
      encodedChallenge: null == encodedChallenge
          ? _value.encodedChallenge
          : encodedChallenge // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$UpdatePinSuccessImpl extends _UpdatePinSuccess
    with DiagnosticableTreeMixin {
  const _$UpdatePinSuccessImpl({required this.encodedChallenge}) : super._();

  @override
  final Uint8List encodedChallenge;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UpdatePinResult.success(encodedChallenge: $encodedChallenge)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UpdatePinResult.success'))
      ..add(DiagnosticsProperty('encodedChallenge', encodedChallenge));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePinSuccessImpl &&
            const DeepCollectionEquality()
                .equals(other.encodedChallenge, encodedChallenge));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(encodedChallenge));

  /// Create a copy of UpdatePinResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePinSuccessImplCopyWith<_$UpdatePinSuccessImpl> get copyWith =>
      __$$UpdatePinSuccessImplCopyWithImpl<_$UpdatePinSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List encodedChallenge) success,
    required TResult Function() pinsDoNotMatch,
  }) {
    return success(encodedChallenge);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List encodedChallenge)? success,
    TResult? Function()? pinsDoNotMatch,
  }) {
    return success?.call(encodedChallenge);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List encodedChallenge)? success,
    TResult Function()? pinsDoNotMatch,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(encodedChallenge);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePinSuccess value) success,
    required TResult Function(_UpdatePinDoNotMatch value) pinsDoNotMatch,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePinSuccess value)? success,
    TResult? Function(_UpdatePinDoNotMatch value)? pinsDoNotMatch,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePinSuccess value)? success,
    TResult Function(_UpdatePinDoNotMatch value)? pinsDoNotMatch,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _UpdatePinSuccess extends UpdatePinResult {
  const factory _UpdatePinSuccess({required final Uint8List encodedChallenge}) =
      _$UpdatePinSuccessImpl;
  const _UpdatePinSuccess._() : super._();

  Uint8List get encodedChallenge;

  /// Create a copy of UpdatePinResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePinSuccessImplCopyWith<_$UpdatePinSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatePinDoNotMatchImplCopyWith<$Res> {
  factory _$$UpdatePinDoNotMatchImplCopyWith(_$UpdatePinDoNotMatchImpl value,
          $Res Function(_$UpdatePinDoNotMatchImpl) then) =
      __$$UpdatePinDoNotMatchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdatePinDoNotMatchImplCopyWithImpl<$Res>
    extends _$UpdatePinResultCopyWithImpl<$Res, _$UpdatePinDoNotMatchImpl>
    implements _$$UpdatePinDoNotMatchImplCopyWith<$Res> {
  __$$UpdatePinDoNotMatchImplCopyWithImpl(_$UpdatePinDoNotMatchImpl _value,
      $Res Function(_$UpdatePinDoNotMatchImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePinResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdatePinDoNotMatchImpl extends _UpdatePinDoNotMatch
    with DiagnosticableTreeMixin {
  const _$UpdatePinDoNotMatchImpl() : super._();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UpdatePinResult.pinsDoNotMatch()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'UpdatePinResult.pinsDoNotMatch'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePinDoNotMatchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List encodedChallenge) success,
    required TResult Function() pinsDoNotMatch,
  }) {
    return pinsDoNotMatch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List encodedChallenge)? success,
    TResult? Function()? pinsDoNotMatch,
  }) {
    return pinsDoNotMatch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List encodedChallenge)? success,
    TResult Function()? pinsDoNotMatch,
    required TResult orElse(),
  }) {
    if (pinsDoNotMatch != null) {
      return pinsDoNotMatch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePinSuccess value) success,
    required TResult Function(_UpdatePinDoNotMatch value) pinsDoNotMatch,
  }) {
    return pinsDoNotMatch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePinSuccess value)? success,
    TResult? Function(_UpdatePinDoNotMatch value)? pinsDoNotMatch,
  }) {
    return pinsDoNotMatch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePinSuccess value)? success,
    TResult Function(_UpdatePinDoNotMatch value)? pinsDoNotMatch,
    required TResult orElse(),
  }) {
    if (pinsDoNotMatch != null) {
      return pinsDoNotMatch(this);
    }
    return orElse();
  }
}

abstract class _UpdatePinDoNotMatch extends UpdatePinResult {
  const factory _UpdatePinDoNotMatch() = _$UpdatePinDoNotMatchImpl;
  const _UpdatePinDoNotMatch._() : super._();
}
