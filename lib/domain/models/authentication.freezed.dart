// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'authentication.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Credentials {
  String get pin => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pin) pin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pin)? pin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pin)? pin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PinCredentials value) pin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CredentialsCopyWith<Credentials> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialsCopyWith<$Res> {
  factory $CredentialsCopyWith(
          Credentials value, $Res Function(Credentials) then) =
      _$CredentialsCopyWithImpl<$Res>;
  $Res call({String pin});
}

/// @nodoc
class _$CredentialsCopyWithImpl<$Res> implements $CredentialsCopyWith<$Res> {
  _$CredentialsCopyWithImpl(this._value, this._then);

  final Credentials _value;
  // ignore: unused_field
  final $Res Function(Credentials) _then;

  @override
  $Res call({
    Object? pin = freezed,
  }) {
    return _then(_value.copyWith(
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$PinCredentialsCopyWith<$Res>
    implements $CredentialsCopyWith<$Res> {
  factory _$$PinCredentialsCopyWith(
          _$PinCredentials value, $Res Function(_$PinCredentials) then) =
      __$$PinCredentialsCopyWithImpl<$Res>;
  @override
  $Res call({String pin});
}

/// @nodoc
class __$$PinCredentialsCopyWithImpl<$Res>
    extends _$CredentialsCopyWithImpl<$Res>
    implements _$$PinCredentialsCopyWith<$Res> {
  __$$PinCredentialsCopyWithImpl(
      _$PinCredentials _value, $Res Function(_$PinCredentials) _then)
      : super(_value, (v) => _then(v as _$PinCredentials));

  @override
  _$PinCredentials get _value => super._value as _$PinCredentials;

  @override
  $Res call({
    Object? pin = freezed,
  }) {
    return _then(_$PinCredentials(
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PinCredentials extends PinCredentials {
  const _$PinCredentials({required this.pin}) : super._();

  @override
  final String pin;

  @override
  String toString() {
    return 'Credentials.pin(pin: $pin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PinCredentials &&
            const DeepCollectionEquality().equals(other.pin, pin));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pin));

  @JsonKey(ignore: true)
  @override
  _$$PinCredentialsCopyWith<_$PinCredentials> get copyWith =>
      __$$PinCredentialsCopyWithImpl<_$PinCredentials>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pin) pin,
  }) {
    return pin(this.pin);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pin)? pin,
  }) {
    return pin?.call(this.pin);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pin)? pin,
    required TResult orElse(),
  }) {
    if (pin != null) {
      return pin(this.pin);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PinCredentials value) pin,
  }) {
    return pin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
  }) {
    return pin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
    required TResult orElse(),
  }) {
    if (pin != null) {
      return pin(this);
    }
    return orElse();
  }
}

abstract class PinCredentials extends Credentials {
  const factory PinCredentials({required final String pin}) = _$PinCredentials;
  const PinCredentials._() : super._();

  @override
  String get pin;
  @override
  @JsonKey(ignore: true)
  _$$PinCredentialsCopyWith<_$PinCredentials> get copyWith =>
      throw _privateConstructorUsedError;
}