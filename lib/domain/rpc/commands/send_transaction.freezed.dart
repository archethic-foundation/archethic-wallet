// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCSendTransactionCommandData {
  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  Data get data => throw _privateConstructorUsedError;

  /// - Type: transaction type
  String get type => throw _privateConstructorUsedError;

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCSendTransactionCommandDataCopyWith<RPCSendTransactionCommandData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSendTransactionCommandDataCopyWith<$Res> {
  factory $RPCSendTransactionCommandDataCopyWith(
          RPCSendTransactionCommandData value,
          $Res Function(RPCSendTransactionCommandData) then) =
      _$RPCSendTransactionCommandDataCopyWithImpl<$Res,
          RPCSendTransactionCommandData>;
  @useResult
  $Res call({Data data, String type, int version});

  $DataCopyWith<$Res> get data;
}

/// @nodoc
class _$RPCSendTransactionCommandDataCopyWithImpl<$Res,
        $Val extends RPCSendTransactionCommandData>
    implements $RPCSendTransactionCommandDataCopyWith<$Res> {
  _$RPCSendTransactionCommandDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DataCopyWith<$Res> get data {
    return $DataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RPCSendTransactionCommandDataCopyWith<$Res>
    implements $RPCSendTransactionCommandDataCopyWith<$Res> {
  factory _$$_RPCSendTransactionCommandDataCopyWith(
          _$_RPCSendTransactionCommandData value,
          $Res Function(_$_RPCSendTransactionCommandData) then) =
      __$$_RPCSendTransactionCommandDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Data data, String type, int version});

  @override
  $DataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_RPCSendTransactionCommandDataCopyWithImpl<$Res>
    extends _$RPCSendTransactionCommandDataCopyWithImpl<$Res,
        _$_RPCSendTransactionCommandData>
    implements _$$_RPCSendTransactionCommandDataCopyWith<$Res> {
  __$$_RPCSendTransactionCommandDataCopyWithImpl(
      _$_RPCSendTransactionCommandData _value,
      $Res Function(_$_RPCSendTransactionCommandData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_$_RPCSendTransactionCommandData(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_RPCSendTransactionCommandData extends _RPCSendTransactionCommandData {
  const _$_RPCSendTransactionCommandData(
      {required this.data, required this.type, required this.version})
      : super._();

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  @override
  final Data data;

  /// - Type: transaction type
  @override
  final String type;

  /// - Version: version of the transaction (used for backward compatiblity)
  @override
  final int version;

  @override
  String toString() {
    return 'RPCSendTransactionCommandData(data: $data, type: $type, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCSendTransactionCommandData &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, type, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCSendTransactionCommandDataCopyWith<_$_RPCSendTransactionCommandData>
      get copyWith => __$$_RPCSendTransactionCommandDataCopyWithImpl<
          _$_RPCSendTransactionCommandData>(this, _$identity);
}

abstract class _RPCSendTransactionCommandData
    extends RPCSendTransactionCommandData {
  const factory _RPCSendTransactionCommandData(
      {required final Data data,
      required final String type,
      required final int version}) = _$_RPCSendTransactionCommandData;
  const _RPCSendTransactionCommandData._() : super._();

  @override

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  Data get data;
  @override

  /// - Type: transaction type
  String get type;
  @override

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version;
  @override
  @JsonKey(ignore: true)
  _$$_RPCSendTransactionCommandDataCopyWith<_$_RPCSendTransactionCommandData>
      get copyWith => throw _privateConstructorUsedError;
}
