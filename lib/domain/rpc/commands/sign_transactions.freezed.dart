// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_transactions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCSignTransactionsCommandData {
  /// Service name to identify the derivation path to use
  String get serviceName => throw _privateConstructorUsedError;

  /// Additional information to add to a service derivation path (optional - default to empty)
  String? get pathSuffix => throw _privateConstructorUsedError;

  /// - List of transaction's infos
  List<RPCSignTransactionCommandData> get rpcSignTransactionCommandData =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCSignTransactionsCommandDataCopyWith<RPCSignTransactionsCommandData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSignTransactionsCommandDataCopyWith<$Res> {
  factory $RPCSignTransactionsCommandDataCopyWith(
          RPCSignTransactionsCommandData value,
          $Res Function(RPCSignTransactionsCommandData) then) =
      _$RPCSignTransactionsCommandDataCopyWithImpl<$Res,
          RPCSignTransactionsCommandData>;
  @useResult
  $Res call(
      {String serviceName,
      String? pathSuffix,
      List<RPCSignTransactionCommandData> rpcSignTransactionCommandData});
}

/// @nodoc
class _$RPCSignTransactionsCommandDataCopyWithImpl<$Res,
        $Val extends RPCSignTransactionsCommandData>
    implements $RPCSignTransactionsCommandDataCopyWith<$Res> {
  _$RPCSignTransactionsCommandDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceName = null,
    Object? pathSuffix = freezed,
    Object? rpcSignTransactionCommandData = null,
  }) {
    return _then(_value.copyWith(
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      pathSuffix: freezed == pathSuffix
          ? _value.pathSuffix
          : pathSuffix // ignore: cast_nullable_to_non_nullable
              as String?,
      rpcSignTransactionCommandData: null == rpcSignTransactionCommandData
          ? _value.rpcSignTransactionCommandData
          : rpcSignTransactionCommandData // ignore: cast_nullable_to_non_nullable
              as List<RPCSignTransactionCommandData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCSignTransactionsCommandDataCopyWith<$Res>
    implements $RPCSignTransactionsCommandDataCopyWith<$Res> {
  factory _$$_RPCSignTransactionsCommandDataCopyWith(
          _$_RPCSignTransactionsCommandData value,
          $Res Function(_$_RPCSignTransactionsCommandData) then) =
      __$$_RPCSignTransactionsCommandDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String serviceName,
      String? pathSuffix,
      List<RPCSignTransactionCommandData> rpcSignTransactionCommandData});
}

/// @nodoc
class __$$_RPCSignTransactionsCommandDataCopyWithImpl<$Res>
    extends _$RPCSignTransactionsCommandDataCopyWithImpl<$Res,
        _$_RPCSignTransactionsCommandData>
    implements _$$_RPCSignTransactionsCommandDataCopyWith<$Res> {
  __$$_RPCSignTransactionsCommandDataCopyWithImpl(
      _$_RPCSignTransactionsCommandData _value,
      $Res Function(_$_RPCSignTransactionsCommandData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceName = null,
    Object? pathSuffix = freezed,
    Object? rpcSignTransactionCommandData = null,
  }) {
    return _then(_$_RPCSignTransactionsCommandData(
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      pathSuffix: freezed == pathSuffix
          ? _value.pathSuffix
          : pathSuffix // ignore: cast_nullable_to_non_nullable
              as String?,
      rpcSignTransactionCommandData: null == rpcSignTransactionCommandData
          ? _value._rpcSignTransactionCommandData
          : rpcSignTransactionCommandData // ignore: cast_nullable_to_non_nullable
              as List<RPCSignTransactionCommandData>,
    ));
  }
}

/// @nodoc

class _$_RPCSignTransactionsCommandData
    extends _RPCSignTransactionsCommandData {
  const _$_RPCSignTransactionsCommandData(
      {required this.serviceName,
      this.pathSuffix,
      required final List<RPCSignTransactionCommandData>
          rpcSignTransactionCommandData})
      : _rpcSignTransactionCommandData = rpcSignTransactionCommandData,
        super._();

  /// Service name to identify the derivation path to use
  @override
  final String serviceName;

  /// Additional information to add to a service derivation path (optional - default to empty)
  @override
  final String? pathSuffix;

  /// - List of transaction's infos
  final List<RPCSignTransactionCommandData> _rpcSignTransactionCommandData;

  /// - List of transaction's infos
  @override
  List<RPCSignTransactionCommandData> get rpcSignTransactionCommandData {
    if (_rpcSignTransactionCommandData is EqualUnmodifiableListView)
      return _rpcSignTransactionCommandData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rpcSignTransactionCommandData);
  }

  @override
  String toString() {
    return 'RPCSignTransactionsCommandData(serviceName: $serviceName, pathSuffix: $pathSuffix, rpcSignTransactionCommandData: $rpcSignTransactionCommandData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCSignTransactionsCommandData &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.pathSuffix, pathSuffix) ||
                other.pathSuffix == pathSuffix) &&
            const DeepCollectionEquality().equals(
                other._rpcSignTransactionCommandData,
                _rpcSignTransactionCommandData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, serviceName, pathSuffix,
      const DeepCollectionEquality().hash(_rpcSignTransactionCommandData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCSignTransactionsCommandDataCopyWith<_$_RPCSignTransactionsCommandData>
      get copyWith => __$$_RPCSignTransactionsCommandDataCopyWithImpl<
          _$_RPCSignTransactionsCommandData>(this, _$identity);
}

abstract class _RPCSignTransactionsCommandData
    extends RPCSignTransactionsCommandData {
  const factory _RPCSignTransactionsCommandData(
      {required final String serviceName,
      final String? pathSuffix,
      required final List<RPCSignTransactionCommandData>
          rpcSignTransactionCommandData}) = _$_RPCSignTransactionsCommandData;
  const _RPCSignTransactionsCommandData._() : super._();

  @override

  /// Service name to identify the derivation path to use
  String get serviceName;
  @override

  /// Additional information to add to a service derivation path (optional - default to empty)
  String? get pathSuffix;
  @override

  /// - List of transaction's infos
  List<RPCSignTransactionCommandData> get rpcSignTransactionCommandData;
  @override
  @JsonKey(ignore: true)
  _$$_RPCSignTransactionsCommandDataCopyWith<_$_RPCSignTransactionsCommandData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RPCSignTransactionsResultData {
  List<RPCSignTransactionResultDetailData> get signedTxs =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCSignTransactionsResultDataCopyWith<RPCSignTransactionsResultData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSignTransactionsResultDataCopyWith<$Res> {
  factory $RPCSignTransactionsResultDataCopyWith(
          RPCSignTransactionsResultData value,
          $Res Function(RPCSignTransactionsResultData) then) =
      _$RPCSignTransactionsResultDataCopyWithImpl<$Res,
          RPCSignTransactionsResultData>;
  @useResult
  $Res call({List<RPCSignTransactionResultDetailData> signedTxs});
}

/// @nodoc
class _$RPCSignTransactionsResultDataCopyWithImpl<$Res,
        $Val extends RPCSignTransactionsResultData>
    implements $RPCSignTransactionsResultDataCopyWith<$Res> {
  _$RPCSignTransactionsResultDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTxs = null,
  }) {
    return _then(_value.copyWith(
      signedTxs: null == signedTxs
          ? _value.signedTxs
          : signedTxs // ignore: cast_nullable_to_non_nullable
              as List<RPCSignTransactionResultDetailData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCSignTransactionsResultDataCopyWith<$Res>
    implements $RPCSignTransactionsResultDataCopyWith<$Res> {
  factory _$$_RPCSignTransactionsResultDataCopyWith(
          _$_RPCSignTransactionsResultData value,
          $Res Function(_$_RPCSignTransactionsResultData) then) =
      __$$_RPCSignTransactionsResultDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<RPCSignTransactionResultDetailData> signedTxs});
}

/// @nodoc
class __$$_RPCSignTransactionsResultDataCopyWithImpl<$Res>
    extends _$RPCSignTransactionsResultDataCopyWithImpl<$Res,
        _$_RPCSignTransactionsResultData>
    implements _$$_RPCSignTransactionsResultDataCopyWith<$Res> {
  __$$_RPCSignTransactionsResultDataCopyWithImpl(
      _$_RPCSignTransactionsResultData _value,
      $Res Function(_$_RPCSignTransactionsResultData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTxs = null,
  }) {
    return _then(_$_RPCSignTransactionsResultData(
      signedTxs: null == signedTxs
          ? _value._signedTxs
          : signedTxs // ignore: cast_nullable_to_non_nullable
              as List<RPCSignTransactionResultDetailData>,
    ));
  }
}

/// @nodoc

class _$_RPCSignTransactionsResultData extends _RPCSignTransactionsResultData {
  const _$_RPCSignTransactionsResultData(
      {required final List<RPCSignTransactionResultDetailData> signedTxs})
      : _signedTxs = signedTxs,
        super._();

  final List<RPCSignTransactionResultDetailData> _signedTxs;
  @override
  List<RPCSignTransactionResultDetailData> get signedTxs {
    if (_signedTxs is EqualUnmodifiableListView) return _signedTxs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signedTxs);
  }

  @override
  String toString() {
    return 'RPCSignTransactionsResultData(signedTxs: $signedTxs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCSignTransactionsResultData &&
            const DeepCollectionEquality()
                .equals(other._signedTxs, _signedTxs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_signedTxs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCSignTransactionsResultDataCopyWith<_$_RPCSignTransactionsResultData>
      get copyWith => __$$_RPCSignTransactionsResultDataCopyWithImpl<
          _$_RPCSignTransactionsResultData>(this, _$identity);
}

abstract class _RPCSignTransactionsResultData
    extends RPCSignTransactionsResultData {
  const factory _RPCSignTransactionsResultData(
          {required final List<RPCSignTransactionResultDetailData> signedTxs}) =
      _$_RPCSignTransactionsResultData;
  const _RPCSignTransactionsResultData._() : super._();

  @override
  List<RPCSignTransactionResultDetailData> get signedTxs;
  @override
  @JsonKey(ignore: true)
  _$$_RPCSignTransactionsResultDataCopyWith<_$_RPCSignTransactionsResultData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RPCSignTransactionCommandData {
  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  Data get data => throw _privateConstructorUsedError;

  /// - Type: transaction type
  String get type => throw _privateConstructorUsedError;

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCSignTransactionCommandDataCopyWith<RPCSignTransactionCommandData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSignTransactionCommandDataCopyWith<$Res> {
  factory $RPCSignTransactionCommandDataCopyWith(
          RPCSignTransactionCommandData value,
          $Res Function(RPCSignTransactionCommandData) then) =
      _$RPCSignTransactionCommandDataCopyWithImpl<$Res,
          RPCSignTransactionCommandData>;
  @useResult
  $Res call({Data data, String type, int version});

  $DataCopyWith<$Res> get data;
}

/// @nodoc
class _$RPCSignTransactionCommandDataCopyWithImpl<$Res,
        $Val extends RPCSignTransactionCommandData>
    implements $RPCSignTransactionCommandDataCopyWith<$Res> {
  _$RPCSignTransactionCommandDataCopyWithImpl(this._value, this._then);

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
abstract class _$$_RPCSignTransactionCommandDataCopyWith<$Res>
    implements $RPCSignTransactionCommandDataCopyWith<$Res> {
  factory _$$_RPCSignTransactionCommandDataCopyWith(
          _$_RPCSignTransactionCommandData value,
          $Res Function(_$_RPCSignTransactionCommandData) then) =
      __$$_RPCSignTransactionCommandDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Data data, String type, int version});

  @override
  $DataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_RPCSignTransactionCommandDataCopyWithImpl<$Res>
    extends _$RPCSignTransactionCommandDataCopyWithImpl<$Res,
        _$_RPCSignTransactionCommandData>
    implements _$$_RPCSignTransactionCommandDataCopyWith<$Res> {
  __$$_RPCSignTransactionCommandDataCopyWithImpl(
      _$_RPCSignTransactionCommandData _value,
      $Res Function(_$_RPCSignTransactionCommandData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_$_RPCSignTransactionCommandData(
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

class _$_RPCSignTransactionCommandData extends _RPCSignTransactionCommandData {
  const _$_RPCSignTransactionCommandData(
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
    return 'RPCSignTransactionCommandData(data: $data, type: $type, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCSignTransactionCommandData &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, type, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCSignTransactionCommandDataCopyWith<_$_RPCSignTransactionCommandData>
      get copyWith => __$$_RPCSignTransactionCommandDataCopyWithImpl<
          _$_RPCSignTransactionCommandData>(this, _$identity);
}

abstract class _RPCSignTransactionCommandData
    extends RPCSignTransactionCommandData {
  const factory _RPCSignTransactionCommandData(
      {required final Data data,
      required final String type,
      required final int version}) = _$_RPCSignTransactionCommandData;
  const _RPCSignTransactionCommandData._() : super._();

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
  _$$_RPCSignTransactionCommandDataCopyWith<_$_RPCSignTransactionCommandData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RPCSignTransactionResultDetailData {
  /// Address: hash of the new generated public key for the given transaction
  String get address => throw _privateConstructorUsedError;

  /// Previous generated public key matching the previous signature
  String get previousPublicKey => throw _privateConstructorUsedError;

  /// Signature from the previous public key
  String get previousSignature => throw _privateConstructorUsedError;

  /// Signature from the device which originated the transaction (used in the Proof of work)
  String get originSignature => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCSignTransactionResultDetailDataCopyWith<
          RPCSignTransactionResultDetailData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSignTransactionResultDetailDataCopyWith<$Res> {
  factory $RPCSignTransactionResultDetailDataCopyWith(
          RPCSignTransactionResultDetailData value,
          $Res Function(RPCSignTransactionResultDetailData) then) =
      _$RPCSignTransactionResultDetailDataCopyWithImpl<$Res,
          RPCSignTransactionResultDetailData>;
  @useResult
  $Res call(
      {String address,
      String previousPublicKey,
      String previousSignature,
      String originSignature});
}

/// @nodoc
class _$RPCSignTransactionResultDetailDataCopyWithImpl<$Res,
        $Val extends RPCSignTransactionResultDetailData>
    implements $RPCSignTransactionResultDetailDataCopyWith<$Res> {
  _$RPCSignTransactionResultDetailDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? previousPublicKey = null,
    Object? previousSignature = null,
    Object? originSignature = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      previousPublicKey: null == previousPublicKey
          ? _value.previousPublicKey
          : previousPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      previousSignature: null == previousSignature
          ? _value.previousSignature
          : previousSignature // ignore: cast_nullable_to_non_nullable
              as String,
      originSignature: null == originSignature
          ? _value.originSignature
          : originSignature // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCSignTransactionResultDetailDataCopyWith<$Res>
    implements $RPCSignTransactionResultDetailDataCopyWith<$Res> {
  factory _$$_RPCSignTransactionResultDetailDataCopyWith(
          _$_RPCSignTransactionResultDetailData value,
          $Res Function(_$_RPCSignTransactionResultDetailData) then) =
      __$$_RPCSignTransactionResultDetailDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String previousPublicKey,
      String previousSignature,
      String originSignature});
}

/// @nodoc
class __$$_RPCSignTransactionResultDetailDataCopyWithImpl<$Res>
    extends _$RPCSignTransactionResultDetailDataCopyWithImpl<$Res,
        _$_RPCSignTransactionResultDetailData>
    implements _$$_RPCSignTransactionResultDetailDataCopyWith<$Res> {
  __$$_RPCSignTransactionResultDetailDataCopyWithImpl(
      _$_RPCSignTransactionResultDetailData _value,
      $Res Function(_$_RPCSignTransactionResultDetailData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? previousPublicKey = null,
    Object? previousSignature = null,
    Object? originSignature = null,
  }) {
    return _then(_$_RPCSignTransactionResultDetailData(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      previousPublicKey: null == previousPublicKey
          ? _value.previousPublicKey
          : previousPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      previousSignature: null == previousSignature
          ? _value.previousSignature
          : previousSignature // ignore: cast_nullable_to_non_nullable
              as String,
      originSignature: null == originSignature
          ? _value.originSignature
          : originSignature // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RPCSignTransactionResultDetailData
    extends _RPCSignTransactionResultDetailData {
  const _$_RPCSignTransactionResultDetailData(
      {required this.address,
      required this.previousPublicKey,
      required this.previousSignature,
      required this.originSignature})
      : super._();

  /// Address: hash of the new generated public key for the given transaction
  @override
  final String address;

  /// Previous generated public key matching the previous signature
  @override
  final String previousPublicKey;

  /// Signature from the previous public key
  @override
  final String previousSignature;

  /// Signature from the device which originated the transaction (used in the Proof of work)
  @override
  final String originSignature;

  @override
  String toString() {
    return 'RPCSignTransactionResultDetailData(address: $address, previousPublicKey: $previousPublicKey, previousSignature: $previousSignature, originSignature: $originSignature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCSignTransactionResultDetailData &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.previousPublicKey, previousPublicKey) ||
                other.previousPublicKey == previousPublicKey) &&
            (identical(other.previousSignature, previousSignature) ||
                other.previousSignature == previousSignature) &&
            (identical(other.originSignature, originSignature) ||
                other.originSignature == originSignature));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, previousPublicKey,
      previousSignature, originSignature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCSignTransactionResultDetailDataCopyWith<
          _$_RPCSignTransactionResultDetailData>
      get copyWith => __$$_RPCSignTransactionResultDetailDataCopyWithImpl<
          _$_RPCSignTransactionResultDetailData>(this, _$identity);
}

abstract class _RPCSignTransactionResultDetailData
    extends RPCSignTransactionResultDetailData {
  const factory _RPCSignTransactionResultDetailData(
          {required final String address,
          required final String previousPublicKey,
          required final String previousSignature,
          required final String originSignature}) =
      _$_RPCSignTransactionResultDetailData;
  const _RPCSignTransactionResultDetailData._() : super._();

  @override

  /// Address: hash of the new generated public key for the given transaction
  String get address;
  @override

  /// Previous generated public key matching the previous signature
  String get previousPublicKey;
  @override

  /// Signature from the previous public key
  String get previousSignature;
  @override

  /// Signature from the device which originated the transaction (used in the Proof of work)
  String get originSignature;
  @override
  @JsonKey(ignore: true)
  _$$_RPCSignTransactionResultDetailDataCopyWith<
          _$_RPCSignTransactionResultDetailData>
      get copyWith => throw _privateConstructorUsedError;
}
