// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionDTO _$TransactionDTOFromJson(Map<String, dynamic> json) {
  return _TransactionDTOToken.fromJson(json);
}

/// @nodoc
mixin _$TransactionDTO {
  TokenDTO get token => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TokenDTO token) token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TokenDTO token)? token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TokenDTO token)? token,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionDTOToken value) token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionDTOToken value)? token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionDTOToken value)? token,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionDTOCopyWith<TransactionDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionDTOCopyWith<$Res> {
  factory $TransactionDTOCopyWith(
          TransactionDTO value, $Res Function(TransactionDTO) then) =
      _$TransactionDTOCopyWithImpl<$Res, TransactionDTO>;
  @useResult
  $Res call({TokenDTO token});

  $TokenDTOCopyWith<$Res> get token;
}

/// @nodoc
class _$TransactionDTOCopyWithImpl<$Res, $Val extends TransactionDTO>
    implements $TransactionDTOCopyWith<$Res> {
  _$TransactionDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenDTO,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenDTOCopyWith<$Res> get token {
    return $TokenDTOCopyWith<$Res>(_value.token, (value) {
      return _then(_value.copyWith(token: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TransactionDTOTokenCopyWith<$Res>
    implements $TransactionDTOCopyWith<$Res> {
  factory _$$_TransactionDTOTokenCopyWith(_$_TransactionDTOToken value,
          $Res Function(_$_TransactionDTOToken) then) =
      __$$_TransactionDTOTokenCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TokenDTO token});

  @override
  $TokenDTOCopyWith<$Res> get token;
}

/// @nodoc
class __$$_TransactionDTOTokenCopyWithImpl<$Res>
    extends _$TransactionDTOCopyWithImpl<$Res, _$_TransactionDTOToken>
    implements _$$_TransactionDTOTokenCopyWith<$Res> {
  __$$_TransactionDTOTokenCopyWithImpl(_$_TransactionDTOToken _value,
      $Res Function(_$_TransactionDTOToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$_TransactionDTOToken(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenDTO,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransactionDTOToken extends _TransactionDTOToken {
  const _$_TransactionDTOToken({required this.token}) : super._();

  factory _$_TransactionDTOToken.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionDTOTokenFromJson(json);

  @override
  final TokenDTO token;

  @override
  String toString() {
    return 'TransactionDTO.token(token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionDTOToken &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionDTOTokenCopyWith<_$_TransactionDTOToken> get copyWith =>
      __$$_TransactionDTOTokenCopyWithImpl<_$_TransactionDTOToken>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TokenDTO token) token,
  }) {
    return token(this.token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TokenDTO token)? token,
  }) {
    return token?.call(this.token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TokenDTO token)? token,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token(this.token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionDTOToken value) token,
  }) {
    return token(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionDTOToken value)? token,
  }) {
    return token?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionDTOToken value)? token,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionDTOTokenToJson(
      this,
    );
  }
}

abstract class _TransactionDTOToken extends TransactionDTO {
  const factory _TransactionDTOToken({required final TokenDTO token}) =
      _$_TransactionDTOToken;
  const _TransactionDTOToken._() : super._();

  factory _TransactionDTOToken.fromJson(Map<String, dynamic> json) =
      _$_TransactionDTOToken.fromJson;

  @override
  TokenDTO get token;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionDTOTokenCopyWith<_$_TransactionDTOToken> get copyWith =>
      throw _privateConstructorUsedError;
}
