// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keychain_derive_keypair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RPCKeychainDeriveKeypairCommandData {
  /// Service name to identify the derivation path to use
  String get serviceName => throw _privateConstructorUsedError;

  /// Chain index to derive (optional - default to 0)
  int? get index => throw _privateConstructorUsedError;

  /// Additional information to add to a service derivation path (optional - default to empty)
  String? get pathSuffix => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCKeychainDeriveKeypairCommandDataCopyWith<
          RPCKeychainDeriveKeypairCommandData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCKeychainDeriveKeypairCommandDataCopyWith<$Res> {
  factory $RPCKeychainDeriveKeypairCommandDataCopyWith(
          RPCKeychainDeriveKeypairCommandData value,
          $Res Function(RPCKeychainDeriveKeypairCommandData) then) =
      _$RPCKeychainDeriveKeypairCommandDataCopyWithImpl<$Res,
          RPCKeychainDeriveKeypairCommandData>;
  @useResult
  $Res call({String serviceName, int? index, String? pathSuffix});
}

/// @nodoc
class _$RPCKeychainDeriveKeypairCommandDataCopyWithImpl<$Res,
        $Val extends RPCKeychainDeriveKeypairCommandData>
    implements $RPCKeychainDeriveKeypairCommandDataCopyWith<$Res> {
  _$RPCKeychainDeriveKeypairCommandDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceName = null,
    Object? index = freezed,
    Object? pathSuffix = freezed,
  }) {
    return _then(_value.copyWith(
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      pathSuffix: freezed == pathSuffix
          ? _value.pathSuffix
          : pathSuffix // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RPCKeychainDeriveKeypairCommandDataImplCopyWith<$Res>
    implements $RPCKeychainDeriveKeypairCommandDataCopyWith<$Res> {
  factory _$$RPCKeychainDeriveKeypairCommandDataImplCopyWith(
          _$RPCKeychainDeriveKeypairCommandDataImpl value,
          $Res Function(_$RPCKeychainDeriveKeypairCommandDataImpl) then) =
      __$$RPCKeychainDeriveKeypairCommandDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String serviceName, int? index, String? pathSuffix});
}

/// @nodoc
class __$$RPCKeychainDeriveKeypairCommandDataImplCopyWithImpl<$Res>
    extends _$RPCKeychainDeriveKeypairCommandDataCopyWithImpl<$Res,
        _$RPCKeychainDeriveKeypairCommandDataImpl>
    implements _$$RPCKeychainDeriveKeypairCommandDataImplCopyWith<$Res> {
  __$$RPCKeychainDeriveKeypairCommandDataImplCopyWithImpl(
      _$RPCKeychainDeriveKeypairCommandDataImpl _value,
      $Res Function(_$RPCKeychainDeriveKeypairCommandDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceName = null,
    Object? index = freezed,
    Object? pathSuffix = freezed,
  }) {
    return _then(_$RPCKeychainDeriveKeypairCommandDataImpl(
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      pathSuffix: freezed == pathSuffix
          ? _value.pathSuffix
          : pathSuffix // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RPCKeychainDeriveKeypairCommandDataImpl
    extends _RPCKeychainDeriveKeypairCommandData {
  const _$RPCKeychainDeriveKeypairCommandDataImpl(
      {required this.serviceName, this.index, this.pathSuffix})
      : super._();

  /// Service name to identify the derivation path to use
  @override
  final String serviceName;

  /// Chain index to derive (optional - default to 0)
  @override
  final int? index;

  /// Additional information to add to a service derivation path (optional - default to empty)
  @override
  final String? pathSuffix;

  @override
  String toString() {
    return 'RPCKeychainDeriveKeypairCommandData(serviceName: $serviceName, index: $index, pathSuffix: $pathSuffix)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCKeychainDeriveKeypairCommandDataImpl &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.pathSuffix, pathSuffix) ||
                other.pathSuffix == pathSuffix));
  }

  @override
  int get hashCode => Object.hash(runtimeType, serviceName, index, pathSuffix);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RPCKeychainDeriveKeypairCommandDataImplCopyWith<
          _$RPCKeychainDeriveKeypairCommandDataImpl>
      get copyWith => __$$RPCKeychainDeriveKeypairCommandDataImplCopyWithImpl<
          _$RPCKeychainDeriveKeypairCommandDataImpl>(this, _$identity);
}

abstract class _RPCKeychainDeriveKeypairCommandData
    extends RPCKeychainDeriveKeypairCommandData {
  const factory _RPCKeychainDeriveKeypairCommandData(
      {required final String serviceName,
      final int? index,
      final String? pathSuffix}) = _$RPCKeychainDeriveKeypairCommandDataImpl;
  const _RPCKeychainDeriveKeypairCommandData._() : super._();

  @override

  /// Service name to identify the derivation path to use
  String get serviceName;
  @override

  /// Chain index to derive (optional - default to 0)
  int? get index;
  @override

  /// Additional information to add to a service derivation path (optional - default to empty)
  String? get pathSuffix;
  @override
  @JsonKey(ignore: true)
  _$$RPCKeychainDeriveKeypairCommandDataImplCopyWith<
          _$RPCKeychainDeriveKeypairCommandDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RPCKeychainDeriveKeypairResultData {
  String get publicKey => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCKeychainDeriveKeypairResultDataCopyWith<
          RPCKeychainDeriveKeypairResultData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCKeychainDeriveKeypairResultDataCopyWith<$Res> {
  factory $RPCKeychainDeriveKeypairResultDataCopyWith(
          RPCKeychainDeriveKeypairResultData value,
          $Res Function(RPCKeychainDeriveKeypairResultData) then) =
      _$RPCKeychainDeriveKeypairResultDataCopyWithImpl<$Res,
          RPCKeychainDeriveKeypairResultData>;
  @useResult
  $Res call({String publicKey});
}

/// @nodoc
class _$RPCKeychainDeriveKeypairResultDataCopyWithImpl<$Res,
        $Val extends RPCKeychainDeriveKeypairResultData>
    implements $RPCKeychainDeriveKeypairResultDataCopyWith<$Res> {
  _$RPCKeychainDeriveKeypairResultDataCopyWithImpl(this._value, this._then);

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
abstract class _$$RPCKeychainDeriveKeypairResultDataImplCopyWith<$Res>
    implements $RPCKeychainDeriveKeypairResultDataCopyWith<$Res> {
  factory _$$RPCKeychainDeriveKeypairResultDataImplCopyWith(
          _$RPCKeychainDeriveKeypairResultDataImpl value,
          $Res Function(_$RPCKeychainDeriveKeypairResultDataImpl) then) =
      __$$RPCKeychainDeriveKeypairResultDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String publicKey});
}

/// @nodoc
class __$$RPCKeychainDeriveKeypairResultDataImplCopyWithImpl<$Res>
    extends _$RPCKeychainDeriveKeypairResultDataCopyWithImpl<$Res,
        _$RPCKeychainDeriveKeypairResultDataImpl>
    implements _$$RPCKeychainDeriveKeypairResultDataImplCopyWith<$Res> {
  __$$RPCKeychainDeriveKeypairResultDataImplCopyWithImpl(
      _$RPCKeychainDeriveKeypairResultDataImpl _value,
      $Res Function(_$RPCKeychainDeriveKeypairResultDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_$RPCKeychainDeriveKeypairResultDataImpl(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RPCKeychainDeriveKeypairResultDataImpl
    extends _RPCKeychainDeriveKeypairResultData {
  const _$RPCKeychainDeriveKeypairResultDataImpl({required this.publicKey})
      : super._();

  @override
  final String publicKey;

  @override
  String toString() {
    return 'RPCKeychainDeriveKeypairResultData(publicKey: $publicKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCKeychainDeriveKeypairResultDataImpl &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, publicKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RPCKeychainDeriveKeypairResultDataImplCopyWith<
          _$RPCKeychainDeriveKeypairResultDataImpl>
      get copyWith => __$$RPCKeychainDeriveKeypairResultDataImplCopyWithImpl<
          _$RPCKeychainDeriveKeypairResultDataImpl>(this, _$identity);
}

abstract class _RPCKeychainDeriveKeypairResultData
    extends RPCKeychainDeriveKeypairResultData {
  const factory _RPCKeychainDeriveKeypairResultData(
          {required final String publicKey}) =
      _$RPCKeychainDeriveKeypairResultDataImpl;
  const _RPCKeychainDeriveKeypairResultData._() : super._();

  @override
  String get publicKey;
  @override
  @JsonKey(ignore: true)
  _$$RPCKeychainDeriveKeypairResultDataImplCopyWith<
          _$RPCKeychainDeriveKeypairResultDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
