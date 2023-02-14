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
mixin _$RPCCommandSource {
  String get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCCommandSourceCopyWith<RPCCommandSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCCommandSourceCopyWith<$Res> {
  factory $RPCCommandSourceCopyWith(
          RPCCommandSource value, $Res Function(RPCCommandSource) then) =
      _$RPCCommandSourceCopyWithImpl<$Res, RPCCommandSource>;
  @useResult
  $Res call({String name, String? url, String? logo});
}

/// @nodoc
class _$RPCCommandSourceCopyWithImpl<$Res, $Val extends RPCCommandSource>
    implements $RPCCommandSourceCopyWith<$Res> {
  _$RPCCommandSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = freezed,
    Object? logo = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCCommandSourceCopyWith<$Res>
    implements $RPCCommandSourceCopyWith<$Res> {
  factory _$$_RPCCommandSourceCopyWith(
          _$_RPCCommandSource value, $Res Function(_$_RPCCommandSource) then) =
      __$$_RPCCommandSourceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? url, String? logo});
}

/// @nodoc
class __$$_RPCCommandSourceCopyWithImpl<$Res>
    extends _$RPCCommandSourceCopyWithImpl<$Res, _$_RPCCommandSource>
    implements _$$_RPCCommandSourceCopyWith<$Res> {
  __$$_RPCCommandSourceCopyWithImpl(
      _$_RPCCommandSource _value, $Res Function(_$_RPCCommandSource) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = freezed,
    Object? logo = freezed,
  }) {
    return _then(_$_RPCCommandSource(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_RPCCommandSource extends _RPCCommandSource {
  const _$_RPCCommandSource({required this.name, this.url, this.logo})
      : super._();

  @override
  final String name;
  @override
  final String? url;
  @override
  final String? logo;

  @override
  String toString() {
    return 'RPCCommandSource(name: $name, url: $url, logo: $logo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCCommandSource &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.logo, logo) || other.logo == logo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, url, logo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCCommandSourceCopyWith<_$_RPCCommandSource> get copyWith =>
      __$$_RPCCommandSourceCopyWithImpl<_$_RPCCommandSource>(this, _$identity);
}

abstract class _RPCCommandSource extends RPCCommandSource {
  const factory _RPCCommandSource(
      {required final String name,
      final String? url,
      final String? logo}) = _$_RPCCommandSource;
  const _RPCCommandSource._() : super._();

  @override
  String get name;
  @override
  String? get url;
  @override
  String? get logo;
  @override
  @JsonKey(ignore: true)
  _$$_RPCCommandSourceCopyWith<_$_RPCCommandSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RPCSignTransactionCommand {
  /// Source application name
  RPCCommandSource get source => throw _privateConstructorUsedError;

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  archethic.Data get data => throw _privateConstructorUsedError;

  /// - Type: transaction type
  String get type => throw _privateConstructorUsedError;

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCSignTransactionCommandCopyWith<RPCSignTransactionCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSignTransactionCommandCopyWith<$Res> {
  factory $RPCSignTransactionCommandCopyWith(RPCSignTransactionCommand value,
          $Res Function(RPCSignTransactionCommand) then) =
      _$RPCSignTransactionCommandCopyWithImpl<$Res, RPCSignTransactionCommand>;
  @useResult
  $Res call(
      {RPCCommandSource source, archethic.Data data, String type, int version});

  $RPCCommandSourceCopyWith<$Res> get source;
}

/// @nodoc
class _$RPCSignTransactionCommandCopyWithImpl<$Res,
        $Val extends RPCSignTransactionCommand>
    implements $RPCSignTransactionCommandCopyWith<$Res> {
  _$RPCSignTransactionCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as RPCCommandSource,
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
  $RPCCommandSourceCopyWith<$Res> get source {
    return $RPCCommandSourceCopyWith<$Res>(_value.source, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RPCSignTransactionCommandCopyWith<$Res>
    implements $RPCSignTransactionCommandCopyWith<$Res> {
  factory _$$_RPCSignTransactionCommandCopyWith(
          _$_RPCSignTransactionCommand value,
          $Res Function(_$_RPCSignTransactionCommand) then) =
      __$$_RPCSignTransactionCommandCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RPCCommandSource source, archethic.Data data, String type, int version});

  @override
  $RPCCommandSourceCopyWith<$Res> get source;
}

/// @nodoc
class __$$_RPCSignTransactionCommandCopyWithImpl<$Res>
    extends _$RPCSignTransactionCommandCopyWithImpl<$Res,
        _$_RPCSignTransactionCommand>
    implements _$$_RPCSignTransactionCommandCopyWith<$Res> {
  __$$_RPCSignTransactionCommandCopyWithImpl(
      _$_RPCSignTransactionCommand _value,
      $Res Function(_$_RPCSignTransactionCommand) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_$_RPCSignTransactionCommand(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as RPCCommandSource,
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

class _$_RPCSignTransactionCommand extends _RPCSignTransactionCommand {
  const _$_RPCSignTransactionCommand(
      {required this.source,
      required this.data,
      required this.type,
      required this.version})
      : super._();

  /// Source application name
  @override
  final RPCCommandSource source;

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
    return 'RPCSignTransactionCommand(source: $source, data: $data, type: $type, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCSignTransactionCommand &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version));
  }

  @override
  int get hashCode => Object.hash(runtimeType, source, data, type, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCSignTransactionCommandCopyWith<_$_RPCSignTransactionCommand>
      get copyWith => __$$_RPCSignTransactionCommandCopyWithImpl<
          _$_RPCSignTransactionCommand>(this, _$identity);
}

abstract class _RPCSignTransactionCommand extends RPCSignTransactionCommand {
  const factory _RPCSignTransactionCommand(
      {required final RPCCommandSource source,
      required final archethic.Data data,
      required final String type,
      required final int version}) = _$_RPCSignTransactionCommand;
  const _RPCSignTransactionCommand._() : super._();

  @override

  /// Source application name
  RPCCommandSource get source;
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
  _$$_RPCSignTransactionCommandCopyWith<_$_RPCSignTransactionCommand>
      get copyWith => throw _privateConstructorUsedError;
}
