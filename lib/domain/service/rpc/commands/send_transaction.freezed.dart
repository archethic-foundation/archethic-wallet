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
mixin _$RPCSendTransactionCommand {
  /// Source application name
  RPCCommandOrigin get origin => throw _privateConstructorUsedError;

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  archethic.Data get data => throw _privateConstructorUsedError;

  /// - Type: transaction type
  String get type => throw _privateConstructorUsedError;

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCSendTransactionCommandCopyWith<RPCSendTransactionCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSendTransactionCommandCopyWith<$Res> {
  factory $RPCSendTransactionCommandCopyWith(RPCSendTransactionCommand value,
          $Res Function(RPCSendTransactionCommand) then) =
      _$RPCSendTransactionCommandCopyWithImpl<$Res, RPCSendTransactionCommand>;
  @useResult
  $Res call(
      {RPCCommandOrigin origin, archethic.Data data, String type, int version});

  $RPCCommandOriginCopyWith<$Res> get origin;
}

/// @nodoc
class _$RPCSendTransactionCommandCopyWithImpl<$Res,
        $Val extends RPCSendTransactionCommand>
    implements $RPCSendTransactionCommandCopyWith<$Res> {
  _$RPCSendTransactionCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as RPCCommandOrigin,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as archethic.Data,
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
  $RPCCommandOriginCopyWith<$Res> get origin {
    return $RPCCommandOriginCopyWith<$Res>(_value.origin, (value) {
      return _then(_value.copyWith(origin: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RPCSendTransactionCommandCopyWith<$Res>
    implements $RPCSendTransactionCommandCopyWith<$Res> {
  factory _$$_RPCSendTransactionCommandCopyWith(
          _$_RPCSendTransactionCommand value,
          $Res Function(_$_RPCSendTransactionCommand) then) =
      __$$_RPCSendTransactionCommandCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RPCCommandOrigin origin, archethic.Data data, String type, int version});

  @override
  $RPCCommandOriginCopyWith<$Res> get origin;
}

/// @nodoc
class __$$_RPCSendTransactionCommandCopyWithImpl<$Res>
    extends _$RPCSendTransactionCommandCopyWithImpl<$Res,
        _$_RPCSendTransactionCommand>
    implements _$$_RPCSendTransactionCommandCopyWith<$Res> {
  __$$_RPCSendTransactionCommandCopyWithImpl(
      _$_RPCSendTransactionCommand _value,
      $Res Function(_$_RPCSendTransactionCommand) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_$_RPCSendTransactionCommand(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as RPCCommandOrigin,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as archethic.Data,
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

class _$_RPCSendTransactionCommand extends _RPCSendTransactionCommand {
  const _$_RPCSendTransactionCommand(
      {required this.origin,
      required this.data,
      required this.type,
      required this.version})
      : super._();

  /// Source application name
  @override
  final RPCCommandOrigin origin;

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  @override
  final archethic.Data data;

  /// - Type: transaction type
  @override
  final String type;

  /// - Version: version of the transaction (used for backward compatiblity)
  @override
  final int version;

  @override
  String toString() {
    return 'RPCSendTransactionCommand(origin: $origin, data: $data, type: $type, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCSendTransactionCommand &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin, data, type, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCSendTransactionCommandCopyWith<_$_RPCSendTransactionCommand>
      get copyWith => __$$_RPCSendTransactionCommandCopyWithImpl<
          _$_RPCSendTransactionCommand>(this, _$identity);
}

abstract class _RPCSendTransactionCommand extends RPCSendTransactionCommand {
  const factory _RPCSendTransactionCommand(
      {required final RPCCommandOrigin origin,
      required final archethic.Data data,
      required final String type,
      required final int version}) = _$_RPCSendTransactionCommand;
  const _RPCSendTransactionCommand._() : super._();

  @override

  /// Source application name
  RPCCommandOrigin get origin;
  @override

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  archethic.Data get data;
  @override

  /// - Type: transaction type
  String get type;
  @override

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version;
  @override
  @JsonKey(ignore: true)
  _$$_RPCSendTransactionCommandCopyWith<_$_RPCSendTransactionCommand>
      get copyWith => throw _privateConstructorUsedError;
}
