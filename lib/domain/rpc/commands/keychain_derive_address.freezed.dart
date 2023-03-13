// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keychain_derive_address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCKeychainDeriveAddressCommandData {
  /// Service name to identify the derivation path to use
  String get serviceName => throw _privateConstructorUsedError;

  /// Chain index to derive (optional - default to 0)
  int? get index => throw _privateConstructorUsedError;

  /// Additional information to add to a service derivation path (optional - default to empty)
  String? get pathSuffix => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCKeychainDeriveAddressCommandDataCopyWith<
          RPCKeychainDeriveAddressCommandData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCKeychainDeriveAddressCommandDataCopyWith<$Res> {
  factory $RPCKeychainDeriveAddressCommandDataCopyWith(
          RPCKeychainDeriveAddressCommandData value,
          $Res Function(RPCKeychainDeriveAddressCommandData) then) =
      _$RPCKeychainDeriveAddressCommandDataCopyWithImpl<$Res,
          RPCKeychainDeriveAddressCommandData>;
  @useResult
  $Res call({String serviceName, int? index, String? pathSuffix});
}

/// @nodoc
class _$RPCKeychainDeriveAddressCommandDataCopyWithImpl<$Res,
        $Val extends RPCKeychainDeriveAddressCommandData>
    implements $RPCKeychainDeriveAddressCommandDataCopyWith<$Res> {
  _$RPCKeychainDeriveAddressCommandDataCopyWithImpl(this._value, this._then);

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
abstract class _$$_RPCKeychainDeriveAddressCommandDataCopyWith<$Res>
    implements $RPCKeychainDeriveAddressCommandDataCopyWith<$Res> {
  factory _$$_RPCKeychainDeriveAddressCommandDataCopyWith(
          _$_RPCKeychainDeriveAddressCommandData value,
          $Res Function(_$_RPCKeychainDeriveAddressCommandData) then) =
      __$$_RPCKeychainDeriveAddressCommandDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String serviceName, int? index, String? pathSuffix});
}

/// @nodoc
class __$$_RPCKeychainDeriveAddressCommandDataCopyWithImpl<$Res>
    extends _$RPCKeychainDeriveAddressCommandDataCopyWithImpl<$Res,
        _$_RPCKeychainDeriveAddressCommandData>
    implements _$$_RPCKeychainDeriveAddressCommandDataCopyWith<$Res> {
  __$$_RPCKeychainDeriveAddressCommandDataCopyWithImpl(
      _$_RPCKeychainDeriveAddressCommandData _value,
      $Res Function(_$_RPCKeychainDeriveAddressCommandData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceName = null,
    Object? index = freezed,
    Object? pathSuffix = freezed,
  }) {
    return _then(_$_RPCKeychainDeriveAddressCommandData(
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

class _$_RPCKeychainDeriveAddressCommandData
    extends _RPCKeychainDeriveAddressCommandData {
  const _$_RPCKeychainDeriveAddressCommandData(
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
    return 'RPCKeychainDeriveAddressCommandData(serviceName: $serviceName, index: $index, pathSuffix: $pathSuffix)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCKeychainDeriveAddressCommandData &&
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
  _$$_RPCKeychainDeriveAddressCommandDataCopyWith<
          _$_RPCKeychainDeriveAddressCommandData>
      get copyWith => __$$_RPCKeychainDeriveAddressCommandDataCopyWithImpl<
          _$_RPCKeychainDeriveAddressCommandData>(this, _$identity);
}

abstract class _RPCKeychainDeriveAddressCommandData
    extends RPCKeychainDeriveAddressCommandData {
  const factory _RPCKeychainDeriveAddressCommandData(
      {required final String serviceName,
      final int? index,
      final String? pathSuffix}) = _$_RPCKeychainDeriveAddressCommandData;
  const _RPCKeychainDeriveAddressCommandData._() : super._();

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
  _$$_RPCKeychainDeriveAddressCommandDataCopyWith<
          _$_RPCKeychainDeriveAddressCommandData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RPCKeychainDeriveAddressResultData {
  String get address => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCKeychainDeriveAddressResultDataCopyWith<
          RPCKeychainDeriveAddressResultData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCKeychainDeriveAddressResultDataCopyWith<$Res> {
  factory $RPCKeychainDeriveAddressResultDataCopyWith(
          RPCKeychainDeriveAddressResultData value,
          $Res Function(RPCKeychainDeriveAddressResultData) then) =
      _$RPCKeychainDeriveAddressResultDataCopyWithImpl<$Res,
          RPCKeychainDeriveAddressResultData>;
  @useResult
  $Res call({String address});
}

/// @nodoc
class _$RPCKeychainDeriveAddressResultDataCopyWithImpl<$Res,
        $Val extends RPCKeychainDeriveAddressResultData>
    implements $RPCKeychainDeriveAddressResultDataCopyWith<$Res> {
  _$RPCKeychainDeriveAddressResultDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCKeychainDeriveAddressResultDataCopyWith<$Res>
    implements $RPCKeychainDeriveAddressResultDataCopyWith<$Res> {
  factory _$$_RPCKeychainDeriveAddressResultDataCopyWith(
          _$_RPCKeychainDeriveAddressResultData value,
          $Res Function(_$_RPCKeychainDeriveAddressResultData) then) =
      __$$_RPCKeychainDeriveAddressResultDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address});
}

/// @nodoc
class __$$_RPCKeychainDeriveAddressResultDataCopyWithImpl<$Res>
    extends _$RPCKeychainDeriveAddressResultDataCopyWithImpl<$Res,
        _$_RPCKeychainDeriveAddressResultData>
    implements _$$_RPCKeychainDeriveAddressResultDataCopyWith<$Res> {
  __$$_RPCKeychainDeriveAddressResultDataCopyWithImpl(
      _$_RPCKeychainDeriveAddressResultData _value,
      $Res Function(_$_RPCKeychainDeriveAddressResultData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_$_RPCKeychainDeriveAddressResultData(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RPCKeychainDeriveAddressResultData
    extends _RPCKeychainDeriveAddressResultData {
  const _$_RPCKeychainDeriveAddressResultData({required this.address})
      : super._();

  @override
  final String address;

  @override
  String toString() {
    return 'RPCKeychainDeriveAddressResultData(address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCKeychainDeriveAddressResultData &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCKeychainDeriveAddressResultDataCopyWith<
          _$_RPCKeychainDeriveAddressResultData>
      get copyWith => __$$_RPCKeychainDeriveAddressResultDataCopyWithImpl<
          _$_RPCKeychainDeriveAddressResultData>(this, _$identity);
}

abstract class _RPCKeychainDeriveAddressResultData
    extends RPCKeychainDeriveAddressResultData {
  const factory _RPCKeychainDeriveAddressResultData(
      {required final String address}) = _$_RPCKeychainDeriveAddressResultData;
  const _RPCKeychainDeriveAddressResultData._() : super._();

  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$_RPCKeychainDeriveAddressResultDataCopyWith<
          _$_RPCKeychainDeriveAddressResultData>
      get copyWith => throw _privateConstructorUsedError;
}
