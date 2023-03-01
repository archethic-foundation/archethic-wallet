// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rpc_sign_transaction_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RpcSignTransactionCommand _$RpcSignTransactionCommandFromJson(
    Map<String, dynamic> json) {
  return _RpcSignTransactionCommand.fromJson(json);
}

/// @nodoc
mixin _$RpcSignTransactionCommand {
  /// Service
  String get accountName => throw _privateConstructorUsedError;

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// - Type: transaction type
  String get type => throw _privateConstructorUsedError;

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RpcSignTransactionCommandCopyWith<RpcSignTransactionCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RpcSignTransactionCommandCopyWith<$Res> {
  factory $RpcSignTransactionCommandCopyWith(RpcSignTransactionCommand value,
          $Res Function(RpcSignTransactionCommand) then) =
      _$RpcSignTransactionCommandCopyWithImpl<$Res, RpcSignTransactionCommand>;
  @useResult
  $Res call(
      {String accountName,
      Map<String, dynamic> data,
      String type,
      int version});
}

/// @nodoc
class _$RpcSignTransactionCommandCopyWithImpl<$Res,
        $Val extends RpcSignTransactionCommand>
    implements $RpcSignTransactionCommandCopyWith<$Res> {
  _$RpcSignTransactionCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountName = null,
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
}

/// @nodoc
abstract class _$$_RpcSignTransactionCommandCopyWith<$Res>
    implements $RpcSignTransactionCommandCopyWith<$Res> {
  factory _$$_RpcSignTransactionCommandCopyWith(
          _$_RpcSignTransactionCommand value,
          $Res Function(_$_RpcSignTransactionCommand) then) =
      __$$_RpcSignTransactionCommandCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String accountName,
      Map<String, dynamic> data,
      String type,
      int version});
}

/// @nodoc
class __$$_RpcSignTransactionCommandCopyWithImpl<$Res>
    extends _$RpcSignTransactionCommandCopyWithImpl<$Res,
        _$_RpcSignTransactionCommand>
    implements _$$_RpcSignTransactionCommandCopyWith<$Res> {
  __$$_RpcSignTransactionCommandCopyWithImpl(
      _$_RpcSignTransactionCommand _value,
      $Res Function(_$_RpcSignTransactionCommand) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountName = null,
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_$_RpcSignTransactionCommand(
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
@JsonSerializable()
class _$_RpcSignTransactionCommand extends _RpcSignTransactionCommand {
  const _$_RpcSignTransactionCommand(
      {required this.accountName,
      required final Map<String, dynamic> data,
      required this.type,
      required this.version})
      : _data = data,
        super._();

  factory _$_RpcSignTransactionCommand.fromJson(Map<String, dynamic> json) =>
      _$$_RpcSignTransactionCommandFromJson(json);

  /// Service
  @override
  final String accountName;

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  final Map<String, dynamic> _data;

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  /// - Type: transaction type
  @override
  final String type;

  /// - Version: version of the transaction (used for backward compatiblity)
  @override
  final int version;

  @override
  String toString() {
    return 'RpcSignTransactionCommand(accountName: $accountName, data: $data, type: $type, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RpcSignTransactionCommand &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, accountName,
      const DeepCollectionEquality().hash(_data), type, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RpcSignTransactionCommandCopyWith<_$_RpcSignTransactionCommand>
      get copyWith => __$$_RpcSignTransactionCommandCopyWithImpl<
          _$_RpcSignTransactionCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RpcSignTransactionCommandToJson(
      this,
    );
  }
}

abstract class _RpcSignTransactionCommand extends RpcSignTransactionCommand {
  const factory _RpcSignTransactionCommand(
      {required final String accountName,
      required final Map<String, dynamic> data,
      required final String type,
      required final int version}) = _$_RpcSignTransactionCommand;
  const _RpcSignTransactionCommand._() : super._();

  factory _RpcSignTransactionCommand.fromJson(Map<String, dynamic> json) =
      _$_RpcSignTransactionCommand.fromJson;

  @override

  /// Service
  String get accountName;
  @override

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  Map<String, dynamic> get data;
  @override

  /// - Type: transaction type
  String get type;
  @override

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version;
  @override
  @JsonKey(ignore: true)
  _$$_RpcSignTransactionCommandCopyWith<_$_RpcSignTransactionCommand>
      get copyWith => throw _privateConstructorUsedError;
}
