// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignTransactionCommand {
  /// Source application name
  String get source => throw _privateConstructorUsedError;

  /// Service
  String get accountName => throw _privateConstructorUsedError;

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  archethic.Data get data => throw _privateConstructorUsedError;

  /// - Type: transaction type
  String get type => throw _privateConstructorUsedError;

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignTransactionCommandCopyWith<SignTransactionCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignTransactionCommandCopyWith<$Res> {
  factory $SignTransactionCommandCopyWith(SignTransactionCommand value,
          $Res Function(SignTransactionCommand) then) =
      _$SignTransactionCommandCopyWithImpl<$Res, SignTransactionCommand>;
  @useResult
  $Res call(
      {String source,
      String accountName,
      archethic.Data data,
      String type,
      int version});
}

/// @nodoc
class _$SignTransactionCommandCopyWithImpl<$Res,
        $Val extends SignTransactionCommand>
    implements $SignTransactionCommandCopyWith<$Res> {
  _$SignTransactionCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? accountName = null,
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
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
}

/// @nodoc
abstract class _$$_SignTransactionCommandCopyWith<$Res>
    implements $SignTransactionCommandCopyWith<$Res> {
  factory _$$_SignTransactionCommandCopyWith(_$_SignTransactionCommand value,
          $Res Function(_$_SignTransactionCommand) then) =
      __$$_SignTransactionCommandCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String source,
      String accountName,
      archethic.Data data,
      String type,
      int version});
}

/// @nodoc
class __$$_SignTransactionCommandCopyWithImpl<$Res>
    extends _$SignTransactionCommandCopyWithImpl<$Res,
        _$_SignTransactionCommand>
    implements _$$_SignTransactionCommandCopyWith<$Res> {
  __$$_SignTransactionCommandCopyWithImpl(_$_SignTransactionCommand _value,
      $Res Function(_$_SignTransactionCommand) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? accountName = null,
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_$_SignTransactionCommand(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$_SignTransactionCommand extends _SignTransactionCommand {
  const _$_SignTransactionCommand(
      {required this.source,
      required this.accountName,
      required this.data,
      required this.type,
      required this.version})
      : super._();

  /// Source application name
  @override
  final String source;

  /// Service
  @override
  final String accountName;

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
    return 'SignTransactionCommand(source: $source, accountName: $accountName, data: $data, type: $type, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignTransactionCommand &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, source, accountName, data, type, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignTransactionCommandCopyWith<_$_SignTransactionCommand> get copyWith =>
      __$$_SignTransactionCommandCopyWithImpl<_$_SignTransactionCommand>(
          this, _$identity);
}

abstract class _SignTransactionCommand extends SignTransactionCommand {
  const factory _SignTransactionCommand(
      {required final String source,
      required final String accountName,
      required final archethic.Data data,
      required final String type,
      required final int version}) = _$_SignTransactionCommand;
  const _SignTransactionCommand._() : super._();

  @override

  /// Source application name
  String get source;
  @override

  /// Service
  String get accountName;
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
  _$$_SignTransactionCommandCopyWith<_$_SignTransactionCommand> get copyWith =>
      throw _privateConstructorUsedError;
}
