// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'keychain_service_keypair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KeychainServiceKeyPair _$KeychainServiceKeyPairFromJson(
    Map<String, dynamic> json) {
  return _KeychainServiceKeyPair.fromJson(json);
}

/// @nodoc
mixin _$KeychainServiceKeyPair {
  List<int> get privateKey => throw _privateConstructorUsedError;
  List<int> get publicKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KeychainServiceKeyPairCopyWith<KeychainServiceKeyPair> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeychainServiceKeyPairCopyWith<$Res> {
  factory $KeychainServiceKeyPairCopyWith(KeychainServiceKeyPair value,
          $Res Function(KeychainServiceKeyPair) then) =
      _$KeychainServiceKeyPairCopyWithImpl<$Res, KeychainServiceKeyPair>;
  @useResult
  $Res call({List<int> privateKey, List<int> publicKey});
}

/// @nodoc
class _$KeychainServiceKeyPairCopyWithImpl<$Res,
        $Val extends KeychainServiceKeyPair>
    implements $KeychainServiceKeyPairCopyWith<$Res> {
  _$KeychainServiceKeyPairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? privateKey = null,
    Object? publicKey = null,
  }) {
    return _then(_value.copyWith(
      privateKey: null == privateKey
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_KeychainServiceKeyPairCopyWith<$Res>
    implements $KeychainServiceKeyPairCopyWith<$Res> {
  factory _$$_KeychainServiceKeyPairCopyWith(_$_KeychainServiceKeyPair value,
          $Res Function(_$_KeychainServiceKeyPair) then) =
      __$$_KeychainServiceKeyPairCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int> privateKey, List<int> publicKey});
}

/// @nodoc
class __$$_KeychainServiceKeyPairCopyWithImpl<$Res>
    extends _$KeychainServiceKeyPairCopyWithImpl<$Res,
        _$_KeychainServiceKeyPair>
    implements _$$_KeychainServiceKeyPairCopyWith<$Res> {
  __$$_KeychainServiceKeyPairCopyWithImpl(_$_KeychainServiceKeyPair _value,
      $Res Function(_$_KeychainServiceKeyPair) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? privateKey = null,
    Object? publicKey = null,
  }) {
    return _then(_$_KeychainServiceKeyPair(
      privateKey: null == privateKey
          ? _value._privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
      publicKey: null == publicKey
          ? _value._publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_KeychainServiceKeyPair extends _KeychainServiceKeyPair {
  const _$_KeychainServiceKeyPair(
      {required final List<int> privateKey, required final List<int> publicKey})
      : _privateKey = privateKey,
        _publicKey = publicKey,
        super._();

  factory _$_KeychainServiceKeyPair.fromJson(Map<String, dynamic> json) =>
      _$$_KeychainServiceKeyPairFromJson(json);

  final List<int> _privateKey;
  @override
  List<int> get privateKey {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_privateKey);
  }

  final List<int> _publicKey;
  @override
  List<int> get publicKey {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_publicKey);
  }

  @override
  String toString() {
    return 'KeychainServiceKeyPair(privateKey: $privateKey, publicKey: $publicKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KeychainServiceKeyPair &&
            const DeepCollectionEquality()
                .equals(other._privateKey, _privateKey) &&
            const DeepCollectionEquality()
                .equals(other._publicKey, _publicKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_privateKey),
      const DeepCollectionEquality().hash(_publicKey));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_KeychainServiceKeyPairCopyWith<_$_KeychainServiceKeyPair> get copyWith =>
      __$$_KeychainServiceKeyPairCopyWithImpl<_$_KeychainServiceKeyPair>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_KeychainServiceKeyPairToJson(
      this,
    );
  }
}

abstract class _KeychainServiceKeyPair extends KeychainServiceKeyPair {
  const factory _KeychainServiceKeyPair(
      {required final List<int> privateKey,
      required final List<int> publicKey}) = _$_KeychainServiceKeyPair;
  const _KeychainServiceKeyPair._() : super._();

  factory _KeychainServiceKeyPair.fromJson(Map<String, dynamic> json) =
      _$_KeychainServiceKeyPair.fromJson;

  @override
  List<int> get privateKey;
  @override
  List<int> get publicKey;
  @override
  @JsonKey(ignore: true)
  _$$_KeychainServiceKeyPairCopyWith<_$_KeychainServiceKeyPair> get copyWith =>
      throw _privateConstructorUsedError;
}
