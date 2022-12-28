// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_property_access.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TokenPropertyAccess {
  String get publicKey => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokenPropertyAccessCopyWith<TokenPropertyAccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPropertyAccessCopyWith<$Res> {
  factory $TokenPropertyAccessCopyWith(
          TokenPropertyAccess value, $Res Function(TokenPropertyAccess) then) =
      _$TokenPropertyAccessCopyWithImpl<$Res, TokenPropertyAccess>;
  @useResult
  $Res call({String publicKey});
}

/// @nodoc
class _$TokenPropertyAccessCopyWithImpl<$Res, $Val extends TokenPropertyAccess>
    implements $TokenPropertyAccessCopyWith<$Res> {
  _$TokenPropertyAccessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_value.copyWith(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokenPropertyAccessCopyWith<$Res>
    implements $TokenPropertyAccessCopyWith<$Res> {
  factory _$$_TokenPropertyAccessCopyWith(_$_TokenPropertyAccess value,
          $Res Function(_$_TokenPropertyAccess) then) =
      __$$_TokenPropertyAccessCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String publicKey});
}

/// @nodoc
class __$$_TokenPropertyAccessCopyWithImpl<$Res>
    extends _$TokenPropertyAccessCopyWithImpl<$Res, _$_TokenPropertyAccess>
    implements _$$_TokenPropertyAccessCopyWith<$Res> {
  __$$_TokenPropertyAccessCopyWithImpl(_$_TokenPropertyAccess _value,
      $Res Function(_$_TokenPropertyAccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_$_TokenPropertyAccess(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TokenPropertyAccess extends _TokenPropertyAccess {
  const _$_TokenPropertyAccess({required this.publicKey}) : super._();

  @override
  final String publicKey;

  @override
  String toString() {
    return 'TokenPropertyAccess(publicKey: $publicKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenPropertyAccess &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, publicKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenPropertyAccessCopyWith<_$_TokenPropertyAccess> get copyWith =>
      __$$_TokenPropertyAccessCopyWithImpl<_$_TokenPropertyAccess>(
          this, _$identity);
}

abstract class _TokenPropertyAccess extends TokenPropertyAccess {
  const factory _TokenPropertyAccess({required final String publicKey}) =
      _$_TokenPropertyAccess;
  const _TokenPropertyAccess._() : super._();

  @override
  String get publicKey;
  @override
  @JsonKey(ignore: true)
  _$$_TokenPropertyAccessCopyWith<_$_TokenPropertyAccess> get copyWith =>
      throw _privateConstructorUsedError;
}
