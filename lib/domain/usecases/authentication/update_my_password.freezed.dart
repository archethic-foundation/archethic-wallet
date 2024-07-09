// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_my_password.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdatePasswordCommand {
  String get password => throw _privateConstructorUsedError;
  String get passwordConfirmation => throw _privateConstructorUsedError;
  Uint8List get challenge => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdatePasswordCommandCopyWith<UpdatePasswordCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePasswordCommandCopyWith<$Res> {
  factory $UpdatePasswordCommandCopyWith(UpdatePasswordCommand value,
          $Res Function(UpdatePasswordCommand) then) =
      _$UpdatePasswordCommandCopyWithImpl<$Res, UpdatePasswordCommand>;
  @useResult
  $Res call(
      {String password, String passwordConfirmation, Uint8List challenge});
}

/// @nodoc
class _$UpdatePasswordCommandCopyWithImpl<$Res,
        $Val extends UpdatePasswordCommand>
    implements $UpdatePasswordCommandCopyWith<$Res> {
  _$UpdatePasswordCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
    Object? passwordConfirmation = null,
    Object? challenge = null,
  }) {
    return _then(_value.copyWith(
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirmation: null == passwordConfirmation
          ? _value.passwordConfirmation
          : passwordConfirmation // ignore: cast_nullable_to_non_nullable
              as String,
      challenge: null == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePasswordCommandImplCopyWith<$Res>
    implements $UpdatePasswordCommandCopyWith<$Res> {
  factory _$$UpdatePasswordCommandImplCopyWith(
          _$UpdatePasswordCommandImpl value,
          $Res Function(_$UpdatePasswordCommandImpl) then) =
      __$$UpdatePasswordCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String password, String passwordConfirmation, Uint8List challenge});
}

/// @nodoc
class __$$UpdatePasswordCommandImplCopyWithImpl<$Res>
    extends _$UpdatePasswordCommandCopyWithImpl<$Res,
        _$UpdatePasswordCommandImpl>
    implements _$$UpdatePasswordCommandImplCopyWith<$Res> {
  __$$UpdatePasswordCommandImplCopyWithImpl(_$UpdatePasswordCommandImpl _value,
      $Res Function(_$UpdatePasswordCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
    Object? passwordConfirmation = null,
    Object? challenge = null,
  }) {
    return _then(_$UpdatePasswordCommandImpl(
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirmation: null == passwordConfirmation
          ? _value.passwordConfirmation
          : passwordConfirmation // ignore: cast_nullable_to_non_nullable
              as String,
      challenge: null == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$UpdatePasswordCommandImpl extends _UpdatePasswordCommand {
  const _$UpdatePasswordCommandImpl(
      {required this.password,
      required this.passwordConfirmation,
      required this.challenge})
      : super._();

  @override
  final String password;
  @override
  final String passwordConfirmation;
  @override
  final Uint8List challenge;

  @override
  String toString() {
    return 'UpdatePasswordCommand(password: $password, passwordConfirmation: $passwordConfirmation, challenge: $challenge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePasswordCommandImpl &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.passwordConfirmation, passwordConfirmation) ||
                other.passwordConfirmation == passwordConfirmation) &&
            const DeepCollectionEquality().equals(other.challenge, challenge));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password, passwordConfirmation,
      const DeepCollectionEquality().hash(challenge));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePasswordCommandImplCopyWith<_$UpdatePasswordCommandImpl>
      get copyWith => __$$UpdatePasswordCommandImplCopyWithImpl<
          _$UpdatePasswordCommandImpl>(this, _$identity);
}

abstract class _UpdatePasswordCommand extends UpdatePasswordCommand {
  const factory _UpdatePasswordCommand(
      {required final String password,
      required final String passwordConfirmation,
      required final Uint8List challenge}) = _$UpdatePasswordCommandImpl;
  const _UpdatePasswordCommand._() : super._();

  @override
  String get password;
  @override
  String get passwordConfirmation;
  @override
  Uint8List get challenge;
  @override
  @JsonKey(ignore: true)
  _$$UpdatePasswordCommandImplCopyWith<_$UpdatePasswordCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UpdatePasswordResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List encodedChallenge) success,
    required TResult Function() passwordsDoNotMatch,
    required TResult Function() emptyPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List encodedChallenge)? success,
    TResult? Function()? passwordsDoNotMatch,
    TResult? Function()? emptyPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List encodedChallenge)? success,
    TResult Function()? passwordsDoNotMatch,
    TResult Function()? emptyPassword,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePasswordSuccess value) success,
    required TResult Function(_passwordsDoNotMatch value) passwordsDoNotMatch,
    required TResult Function(_emptyPassword value) emptyPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePasswordSuccess value)? success,
    TResult? Function(_passwordsDoNotMatch value)? passwordsDoNotMatch,
    TResult? Function(_emptyPassword value)? emptyPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePasswordSuccess value)? success,
    TResult Function(_passwordsDoNotMatch value)? passwordsDoNotMatch,
    TResult Function(_emptyPassword value)? emptyPassword,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePasswordResultCopyWith<$Res> {
  factory $UpdatePasswordResultCopyWith(UpdatePasswordResult value,
          $Res Function(UpdatePasswordResult) then) =
      _$UpdatePasswordResultCopyWithImpl<$Res, UpdatePasswordResult>;
}

/// @nodoc
class _$UpdatePasswordResultCopyWithImpl<$Res,
        $Val extends UpdatePasswordResult>
    implements $UpdatePasswordResultCopyWith<$Res> {
  _$UpdatePasswordResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UpdatePasswordSuccessImplCopyWith<$Res> {
  factory _$$UpdatePasswordSuccessImplCopyWith(
          _$UpdatePasswordSuccessImpl value,
          $Res Function(_$UpdatePasswordSuccessImpl) then) =
      __$$UpdatePasswordSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uint8List encodedChallenge});
}

/// @nodoc
class __$$UpdatePasswordSuccessImplCopyWithImpl<$Res>
    extends _$UpdatePasswordResultCopyWithImpl<$Res,
        _$UpdatePasswordSuccessImpl>
    implements _$$UpdatePasswordSuccessImplCopyWith<$Res> {
  __$$UpdatePasswordSuccessImplCopyWithImpl(_$UpdatePasswordSuccessImpl _value,
      $Res Function(_$UpdatePasswordSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encodedChallenge = null,
  }) {
    return _then(_$UpdatePasswordSuccessImpl(
      encodedChallenge: null == encodedChallenge
          ? _value.encodedChallenge
          : encodedChallenge // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$UpdatePasswordSuccessImpl extends _UpdatePasswordSuccess {
  const _$UpdatePasswordSuccessImpl({required this.encodedChallenge})
      : super._();

  @override
  final Uint8List encodedChallenge;

  @override
  String toString() {
    return 'UpdatePasswordResult.success(encodedChallenge: $encodedChallenge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePasswordSuccessImpl &&
            const DeepCollectionEquality()
                .equals(other.encodedChallenge, encodedChallenge));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(encodedChallenge));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePasswordSuccessImplCopyWith<_$UpdatePasswordSuccessImpl>
      get copyWith => __$$UpdatePasswordSuccessImplCopyWithImpl<
          _$UpdatePasswordSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List encodedChallenge) success,
    required TResult Function() passwordsDoNotMatch,
    required TResult Function() emptyPassword,
  }) {
    return success(encodedChallenge);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List encodedChallenge)? success,
    TResult? Function()? passwordsDoNotMatch,
    TResult? Function()? emptyPassword,
  }) {
    return success?.call(encodedChallenge);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List encodedChallenge)? success,
    TResult Function()? passwordsDoNotMatch,
    TResult Function()? emptyPassword,
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
    required TResult Function(_UpdatePasswordSuccess value) success,
    required TResult Function(_passwordsDoNotMatch value) passwordsDoNotMatch,
    required TResult Function(_emptyPassword value) emptyPassword,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePasswordSuccess value)? success,
    TResult? Function(_passwordsDoNotMatch value)? passwordsDoNotMatch,
    TResult? Function(_emptyPassword value)? emptyPassword,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePasswordSuccess value)? success,
    TResult Function(_passwordsDoNotMatch value)? passwordsDoNotMatch,
    TResult Function(_emptyPassword value)? emptyPassword,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _UpdatePasswordSuccess extends UpdatePasswordResult {
  const factory _UpdatePasswordSuccess(
          {required final Uint8List encodedChallenge}) =
      _$UpdatePasswordSuccessImpl;
  const _UpdatePasswordSuccess._() : super._();

  Uint8List get encodedChallenge;
  @JsonKey(ignore: true)
  _$$UpdatePasswordSuccessImplCopyWith<_$UpdatePasswordSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$passwordsDoNotMatchImplCopyWith<$Res> {
  factory _$$passwordsDoNotMatchImplCopyWith(_$passwordsDoNotMatchImpl value,
          $Res Function(_$passwordsDoNotMatchImpl) then) =
      __$$passwordsDoNotMatchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$passwordsDoNotMatchImplCopyWithImpl<$Res>
    extends _$UpdatePasswordResultCopyWithImpl<$Res, _$passwordsDoNotMatchImpl>
    implements _$$passwordsDoNotMatchImplCopyWith<$Res> {
  __$$passwordsDoNotMatchImplCopyWithImpl(_$passwordsDoNotMatchImpl _value,
      $Res Function(_$passwordsDoNotMatchImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$passwordsDoNotMatchImpl extends _passwordsDoNotMatch {
  const _$passwordsDoNotMatchImpl() : super._();

  @override
  String toString() {
    return 'UpdatePasswordResult.passwordsDoNotMatch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$passwordsDoNotMatchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List encodedChallenge) success,
    required TResult Function() passwordsDoNotMatch,
    required TResult Function() emptyPassword,
  }) {
    return passwordsDoNotMatch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List encodedChallenge)? success,
    TResult? Function()? passwordsDoNotMatch,
    TResult? Function()? emptyPassword,
  }) {
    return passwordsDoNotMatch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List encodedChallenge)? success,
    TResult Function()? passwordsDoNotMatch,
    TResult Function()? emptyPassword,
    required TResult orElse(),
  }) {
    if (passwordsDoNotMatch != null) {
      return passwordsDoNotMatch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePasswordSuccess value) success,
    required TResult Function(_passwordsDoNotMatch value) passwordsDoNotMatch,
    required TResult Function(_emptyPassword value) emptyPassword,
  }) {
    return passwordsDoNotMatch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePasswordSuccess value)? success,
    TResult? Function(_passwordsDoNotMatch value)? passwordsDoNotMatch,
    TResult? Function(_emptyPassword value)? emptyPassword,
  }) {
    return passwordsDoNotMatch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePasswordSuccess value)? success,
    TResult Function(_passwordsDoNotMatch value)? passwordsDoNotMatch,
    TResult Function(_emptyPassword value)? emptyPassword,
    required TResult orElse(),
  }) {
    if (passwordsDoNotMatch != null) {
      return passwordsDoNotMatch(this);
    }
    return orElse();
  }
}

abstract class _passwordsDoNotMatch extends UpdatePasswordResult {
  const factory _passwordsDoNotMatch() = _$passwordsDoNotMatchImpl;
  const _passwordsDoNotMatch._() : super._();
}

/// @nodoc
abstract class _$$emptyPasswordImplCopyWith<$Res> {
  factory _$$emptyPasswordImplCopyWith(
          _$emptyPasswordImpl value, $Res Function(_$emptyPasswordImpl) then) =
      __$$emptyPasswordImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$emptyPasswordImplCopyWithImpl<$Res>
    extends _$UpdatePasswordResultCopyWithImpl<$Res, _$emptyPasswordImpl>
    implements _$$emptyPasswordImplCopyWith<$Res> {
  __$$emptyPasswordImplCopyWithImpl(
      _$emptyPasswordImpl _value, $Res Function(_$emptyPasswordImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$emptyPasswordImpl extends _emptyPassword {
  const _$emptyPasswordImpl() : super._();

  @override
  String toString() {
    return 'UpdatePasswordResult.emptyPassword()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$emptyPasswordImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List encodedChallenge) success,
    required TResult Function() passwordsDoNotMatch,
    required TResult Function() emptyPassword,
  }) {
    return emptyPassword();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List encodedChallenge)? success,
    TResult? Function()? passwordsDoNotMatch,
    TResult? Function()? emptyPassword,
  }) {
    return emptyPassword?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List encodedChallenge)? success,
    TResult Function()? passwordsDoNotMatch,
    TResult Function()? emptyPassword,
    required TResult orElse(),
  }) {
    if (emptyPassword != null) {
      return emptyPassword();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePasswordSuccess value) success,
    required TResult Function(_passwordsDoNotMatch value) passwordsDoNotMatch,
    required TResult Function(_emptyPassword value) emptyPassword,
  }) {
    return emptyPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePasswordSuccess value)? success,
    TResult? Function(_passwordsDoNotMatch value)? passwordsDoNotMatch,
    TResult? Function(_emptyPassword value)? emptyPassword,
  }) {
    return emptyPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePasswordSuccess value)? success,
    TResult Function(_passwordsDoNotMatch value)? passwordsDoNotMatch,
    TResult Function(_emptyPassword value)? emptyPassword,
    required TResult orElse(),
  }) {
    if (emptyPassword != null) {
      return emptyPassword(this);
    }
    return orElse();
  }
}

abstract class _emptyPassword extends UpdatePasswordResult {
  const factory _emptyPassword() = _$emptyPasswordImpl;
  const _emptyPassword._() : super._();
}
