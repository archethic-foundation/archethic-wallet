// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ContactCreationFormState {
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get publicKey => throw _privateConstructorUsedError;
  String get publicKeyRecovered => throw _privateConstructorUsedError;
  bool get favorite => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContactCreationFormStateCopyWith<ContactCreationFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactCreationFormStateCopyWith<$Res> {
  factory $ContactCreationFormStateCopyWith(ContactCreationFormState value,
          $Res Function(ContactCreationFormState) then) =
      _$ContactCreationFormStateCopyWithImpl<$Res, ContactCreationFormState>;
  @useResult
  $Res call(
      {String name,
      String address,
      String publicKey,
      String publicKeyRecovered,
      bool favorite,
      String error});
}

/// @nodoc
class _$ContactCreationFormStateCopyWithImpl<$Res,
        $Val extends ContactCreationFormState>
    implements $ContactCreationFormStateCopyWith<$Res> {
  _$ContactCreationFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? publicKey = null,
    Object? publicKeyRecovered = null,
    Object? favorite = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      publicKeyRecovered: null == publicKeyRecovered
          ? _value.publicKeyRecovered
          : publicKeyRecovered // ignore: cast_nullable_to_non_nullable
              as String,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ContactCreationFormStateCopyWith<$Res>
    implements $ContactCreationFormStateCopyWith<$Res> {
  factory _$$_ContactCreationFormStateCopyWith(
          _$_ContactCreationFormState value,
          $Res Function(_$_ContactCreationFormState) then) =
      __$$_ContactCreationFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String address,
      String publicKey,
      String publicKeyRecovered,
      bool favorite,
      String error});
}

/// @nodoc
class __$$_ContactCreationFormStateCopyWithImpl<$Res>
    extends _$ContactCreationFormStateCopyWithImpl<$Res,
        _$_ContactCreationFormState>
    implements _$$_ContactCreationFormStateCopyWith<$Res> {
  __$$_ContactCreationFormStateCopyWithImpl(_$_ContactCreationFormState _value,
      $Res Function(_$_ContactCreationFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? publicKey = null,
    Object? publicKeyRecovered = null,
    Object? favorite = null,
    Object? error = null,
  }) {
    return _then(_$_ContactCreationFormState(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      publicKeyRecovered: null == publicKeyRecovered
          ? _value.publicKeyRecovered
          : publicKeyRecovered // ignore: cast_nullable_to_non_nullable
              as String,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ContactCreationFormState extends _ContactCreationFormState {
  const _$_ContactCreationFormState(
      {this.name = '',
      this.address = '',
      this.publicKey = '',
      this.publicKeyRecovered = '',
      this.favorite = false,
      this.error = ''})
      : super._();

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String publicKey;
  @override
  @JsonKey()
  final String publicKeyRecovered;
  @override
  @JsonKey()
  final bool favorite;
  @override
  @JsonKey()
  final String error;

  @override
  String toString() {
    return 'ContactCreationFormState(name: $name, address: $address, publicKey: $publicKey, publicKeyRecovered: $publicKeyRecovered, favorite: $favorite, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContactCreationFormState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.publicKeyRecovered, publicKeyRecovered) ||
                other.publicKeyRecovered == publicKeyRecovered) &&
            (identical(other.favorite, favorite) ||
                other.favorite == favorite) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, address, publicKey,
      publicKeyRecovered, favorite, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ContactCreationFormStateCopyWith<_$_ContactCreationFormState>
      get copyWith => __$$_ContactCreationFormStateCopyWithImpl<
          _$_ContactCreationFormState>(this, _$identity);
}

abstract class _ContactCreationFormState extends ContactCreationFormState {
  const factory _ContactCreationFormState(
      {final String name,
      final String address,
      final String publicKey,
      final String publicKeyRecovered,
      final bool favorite,
      final String error}) = _$_ContactCreationFormState;
  const _ContactCreationFormState._() : super._();

  @override
  String get name;
  @override
  String get address;
  @override
  String get publicKey;
  @override
  String get publicKeyRecovered;
  @override
  bool get favorite;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$$_ContactCreationFormStateCopyWith<_$_ContactCreationFormState>
      get copyWith => throw _privateConstructorUsedError;
}
