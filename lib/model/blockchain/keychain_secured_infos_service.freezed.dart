// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keychain_secured_infos_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KeychainSecuredInfosService _$KeychainSecuredInfosServiceFromJson(
    Map<String, dynamic> json) {
  return _KeychainSecuredInfosService.fromJson(json);
}

/// @nodoc
mixin _$KeychainSecuredInfosService {
  String get derivationPath => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  KeychainServiceKeyPair? get keyPair => throw _privateConstructorUsedError;
  String get curve => throw _privateConstructorUsedError;
  String get hashAlgo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KeychainSecuredInfosServiceCopyWith<KeychainSecuredInfosService>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeychainSecuredInfosServiceCopyWith<$Res> {
  factory $KeychainSecuredInfosServiceCopyWith(
          KeychainSecuredInfosService value,
          $Res Function(KeychainSecuredInfosService) then) =
      _$KeychainSecuredInfosServiceCopyWithImpl<$Res,
          KeychainSecuredInfosService>;
  @useResult
  $Res call(
      {String derivationPath,
      String name,
      KeychainServiceKeyPair? keyPair,
      String curve,
      String hashAlgo});

  $KeychainServiceKeyPairCopyWith<$Res>? get keyPair;
}

/// @nodoc
class _$KeychainSecuredInfosServiceCopyWithImpl<$Res,
        $Val extends KeychainSecuredInfosService>
    implements $KeychainSecuredInfosServiceCopyWith<$Res> {
  _$KeychainSecuredInfosServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? derivationPath = null,
    Object? name = null,
    Object? keyPair = freezed,
    Object? curve = null,
    Object? hashAlgo = null,
  }) {
    return _then(_value.copyWith(
      derivationPath: null == derivationPath
          ? _value.derivationPath
          : derivationPath // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      keyPair: freezed == keyPair
          ? _value.keyPair
          : keyPair // ignore: cast_nullable_to_non_nullable
              as KeychainServiceKeyPair?,
      curve: null == curve
          ? _value.curve
          : curve // ignore: cast_nullable_to_non_nullable
              as String,
      hashAlgo: null == hashAlgo
          ? _value.hashAlgo
          : hashAlgo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $KeychainServiceKeyPairCopyWith<$Res>? get keyPair {
    if (_value.keyPair == null) {
      return null;
    }

    return $KeychainServiceKeyPairCopyWith<$Res>(_value.keyPair!, (value) {
      return _then(_value.copyWith(keyPair: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KeychainSecuredInfosServiceImplCopyWith<$Res>
    implements $KeychainSecuredInfosServiceCopyWith<$Res> {
  factory _$$KeychainSecuredInfosServiceImplCopyWith(
          _$KeychainSecuredInfosServiceImpl value,
          $Res Function(_$KeychainSecuredInfosServiceImpl) then) =
      __$$KeychainSecuredInfosServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String derivationPath,
      String name,
      KeychainServiceKeyPair? keyPair,
      String curve,
      String hashAlgo});

  @override
  $KeychainServiceKeyPairCopyWith<$Res>? get keyPair;
}

/// @nodoc
class __$$KeychainSecuredInfosServiceImplCopyWithImpl<$Res>
    extends _$KeychainSecuredInfosServiceCopyWithImpl<$Res,
        _$KeychainSecuredInfosServiceImpl>
    implements _$$KeychainSecuredInfosServiceImplCopyWith<$Res> {
  __$$KeychainSecuredInfosServiceImplCopyWithImpl(
      _$KeychainSecuredInfosServiceImpl _value,
      $Res Function(_$KeychainSecuredInfosServiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? derivationPath = null,
    Object? name = null,
    Object? keyPair = freezed,
    Object? curve = null,
    Object? hashAlgo = null,
  }) {
    return _then(_$KeychainSecuredInfosServiceImpl(
      derivationPath: null == derivationPath
          ? _value.derivationPath
          : derivationPath // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      keyPair: freezed == keyPair
          ? _value.keyPair
          : keyPair // ignore: cast_nullable_to_non_nullable
              as KeychainServiceKeyPair?,
      curve: null == curve
          ? _value.curve
          : curve // ignore: cast_nullable_to_non_nullable
              as String,
      hashAlgo: null == hashAlgo
          ? _value.hashAlgo
          : hashAlgo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KeychainSecuredInfosServiceImpl extends _KeychainSecuredInfosService {
  const _$KeychainSecuredInfosServiceImpl(
      {required this.derivationPath,
      required this.name,
      this.keyPair,
      required this.curve,
      required this.hashAlgo})
      : super._();

  factory _$KeychainSecuredInfosServiceImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$KeychainSecuredInfosServiceImplFromJson(json);

  @override
  final String derivationPath;
  @override
  final String name;
  @override
  final KeychainServiceKeyPair? keyPair;
  @override
  final String curve;
  @override
  final String hashAlgo;

  @override
  String toString() {
    return 'KeychainSecuredInfosService(derivationPath: $derivationPath, name: $name, keyPair: $keyPair, curve: $curve, hashAlgo: $hashAlgo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeychainSecuredInfosServiceImpl &&
            (identical(other.derivationPath, derivationPath) ||
                other.derivationPath == derivationPath) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.keyPair, keyPair) || other.keyPair == keyPair) &&
            (identical(other.curve, curve) || other.curve == curve) &&
            (identical(other.hashAlgo, hashAlgo) ||
                other.hashAlgo == hashAlgo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, derivationPath, name, keyPair, curve, hashAlgo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KeychainSecuredInfosServiceImplCopyWith<_$KeychainSecuredInfosServiceImpl>
      get copyWith => __$$KeychainSecuredInfosServiceImplCopyWithImpl<
          _$KeychainSecuredInfosServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeychainSecuredInfosServiceImplToJson(
      this,
    );
  }
}

abstract class _KeychainSecuredInfosService
    extends KeychainSecuredInfosService {
  const factory _KeychainSecuredInfosService(
      {required final String derivationPath,
      required final String name,
      final KeychainServiceKeyPair? keyPair,
      required final String curve,
      required final String hashAlgo}) = _$KeychainSecuredInfosServiceImpl;
  const _KeychainSecuredInfosService._() : super._();

  factory _KeychainSecuredInfosService.fromJson(Map<String, dynamic> json) =
      _$KeychainSecuredInfosServiceImpl.fromJson;

  @override
  String get derivationPath;
  @override
  String get name;
  @override
  KeychainServiceKeyPair? get keyPair;
  @override
  String get curve;
  @override
  String get hashAlgo;
  @override
  @JsonKey(ignore: true)
  _$$KeychainSecuredInfosServiceImplCopyWith<_$KeychainSecuredInfosServiceImpl>
      get copyWith => throw _privateConstructorUsedError;
}
