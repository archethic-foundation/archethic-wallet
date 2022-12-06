// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'token_property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TokenProperty {
  String get propertyName => throw _privateConstructorUsedError;
  dynamic get propertyValue => throw _privateConstructorUsedError;
  List<TokenPropertyAccess> get publicKeys =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokenPropertyCopyWith<TokenProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPropertyCopyWith<$Res> {
  factory $TokenPropertyCopyWith(
          TokenProperty value, $Res Function(TokenProperty) then) =
      _$TokenPropertyCopyWithImpl<$Res, TokenProperty>;
  @useResult
  $Res call(
      {String propertyName,
      dynamic propertyValue,
      List<TokenPropertyAccess> publicKeys});
}

/// @nodoc
class _$TokenPropertyCopyWithImpl<$Res, $Val extends TokenProperty>
    implements $TokenPropertyCopyWith<$Res> {
  _$TokenPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? propertyName = null,
    Object? propertyValue = null,
    Object? publicKeys = null,
  }) {
    return _then(_value.copyWith(
      propertyName: null == propertyName
          ? _value.propertyName
          : propertyName // ignore: cast_nullable_to_non_nullable
              as String,
      propertyValue: null == propertyValue
          ? _value.propertyValue
          : propertyValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      publicKeys: null == publicKeys
          ? _value.publicKeys
          : publicKeys // ignore: cast_nullable_to_non_nullable
              as List<TokenPropertyAccess>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokenPropertyCopyWith<$Res>
    implements $TokenPropertyCopyWith<$Res> {
  factory _$$_TokenPropertyCopyWith(
          _$_TokenProperty value, $Res Function(_$_TokenProperty) then) =
      __$$_TokenPropertyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String propertyName,
      dynamic propertyValue,
      List<TokenPropertyAccess> publicKeys});
}

/// @nodoc
class __$$_TokenPropertyCopyWithImpl<$Res>
    extends _$TokenPropertyCopyWithImpl<$Res, _$_TokenProperty>
    implements _$$_TokenPropertyCopyWith<$Res> {
  __$$_TokenPropertyCopyWithImpl(
      _$_TokenProperty _value, $Res Function(_$_TokenProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? propertyName = null,
    Object? propertyValue = null,
    Object? publicKeys = null,
  }) {
    return _then(_$_TokenProperty(
      propertyName: null == propertyName
          ? _value.propertyName
          : propertyName // ignore: cast_nullable_to_non_nullable
              as String,
      propertyValue: null == propertyValue
          ? _value.propertyValue
          : propertyValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      publicKeys: null == publicKeys
          ? _value._publicKeys
          : publicKeys // ignore: cast_nullable_to_non_nullable
              as List<TokenPropertyAccess>,
    ));
  }
}

/// @nodoc

class _$_TokenProperty extends _TokenProperty {
  const _$_TokenProperty(
      {required this.propertyName,
      required this.propertyValue,
      required final List<TokenPropertyAccess> publicKeys})
      : _publicKeys = publicKeys,
        super._();

  @override
  final String propertyName;
  @override
  final dynamic propertyValue;
  final List<TokenPropertyAccess> _publicKeys;
  @override
  List<TokenPropertyAccess> get publicKeys {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_publicKeys);
  }

  @override
  String toString() {
    return 'TokenProperty(propertyName: $propertyName, propertyValue: $propertyValue, publicKeys: $publicKeys)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenProperty &&
            (identical(other.propertyName, propertyName) ||
                other.propertyName == propertyName) &&
            const DeepCollectionEquality()
                .equals(other.propertyValue, propertyValue) &&
            const DeepCollectionEquality()
                .equals(other._publicKeys, _publicKeys));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      propertyName,
      const DeepCollectionEquality().hash(propertyValue),
      const DeepCollectionEquality().hash(_publicKeys));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenPropertyCopyWith<_$_TokenProperty> get copyWith =>
      __$$_TokenPropertyCopyWithImpl<_$_TokenProperty>(this, _$identity);
}

abstract class _TokenProperty extends TokenProperty {
  const factory _TokenProperty(
      {required final String propertyName,
      required final dynamic propertyValue,
      required final List<TokenPropertyAccess> publicKeys}) = _$_TokenProperty;
  const _TokenProperty._() : super._();

  @override
  String get propertyName;
  @override
  dynamic get propertyValue;
  @override
  List<TokenPropertyAccess> get publicKeys;
  @override
  @JsonKey(ignore: true)
  _$$_TokenPropertyCopyWith<_$_TokenProperty> get copyWith =>
      throw _privateConstructorUsedError;
}
