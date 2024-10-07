// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_pool_infos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexPoolInfos _$DexPoolInfosFromJson(Map<String, dynamic> json) {
  return _DexPoolInfos.fromJson(json);
}

/// @nodoc
mixin _$DexPoolInfos {
  String get poolAddress => throw _privateConstructorUsedError;
  String get token1Address => throw _privateConstructorUsedError;
  String get token2Address => throw _privateConstructorUsedError;
  double get token1Reserve => throw _privateConstructorUsedError;
  double get token2Reserve => throw _privateConstructorUsedError;
  double get lpTokenSupply => throw _privateConstructorUsedError;
  double get fees => throw _privateConstructorUsedError;
  double get protocolFees => throw _privateConstructorUsedError;
  double get ratioToken1Token2 => throw _privateConstructorUsedError;
  double get ratioToken2Token1 => throw _privateConstructorUsedError;
  double get token1TotalFee => throw _privateConstructorUsedError;
  double get token1TotalVolume => throw _privateConstructorUsedError;
  double get token2TotalFee => throw _privateConstructorUsedError;
  double get token2TotalVolume => throw _privateConstructorUsedError;

  /// Serializes this DexPoolInfos to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DexPoolInfos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DexPoolInfosCopyWith<DexPoolInfos> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexPoolInfosCopyWith<$Res> {
  factory $DexPoolInfosCopyWith(
          DexPoolInfos value, $Res Function(DexPoolInfos) then) =
      _$DexPoolInfosCopyWithImpl<$Res, DexPoolInfos>;
  @useResult
  $Res call(
      {String poolAddress,
      String token1Address,
      String token2Address,
      double token1Reserve,
      double token2Reserve,
      double lpTokenSupply,
      double fees,
      double protocolFees,
      double ratioToken1Token2,
      double ratioToken2Token1,
      double token1TotalFee,
      double token1TotalVolume,
      double token2TotalFee,
      double token2TotalVolume});
}

/// @nodoc
class _$DexPoolInfosCopyWithImpl<$Res, $Val extends DexPoolInfos>
    implements $DexPoolInfosCopyWith<$Res> {
  _$DexPoolInfosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DexPoolInfos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddress = null,
    Object? token1Address = null,
    Object? token2Address = null,
    Object? token1Reserve = null,
    Object? token2Reserve = null,
    Object? lpTokenSupply = null,
    Object? fees = null,
    Object? protocolFees = null,
    Object? ratioToken1Token2 = null,
    Object? ratioToken2Token1 = null,
    Object? token1TotalFee = null,
    Object? token1TotalVolume = null,
    Object? token2TotalFee = null,
    Object? token2TotalVolume = null,
  }) {
    return _then(_value.copyWith(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      token1Address: null == token1Address
          ? _value.token1Address
          : token1Address // ignore: cast_nullable_to_non_nullable
              as String,
      token2Address: null == token2Address
          ? _value.token2Address
          : token2Address // ignore: cast_nullable_to_non_nullable
              as String,
      token1Reserve: null == token1Reserve
          ? _value.token1Reserve
          : token1Reserve // ignore: cast_nullable_to_non_nullable
              as double,
      token2Reserve: null == token2Reserve
          ? _value.token2Reserve
          : token2Reserve // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenSupply: null == lpTokenSupply
          ? _value.lpTokenSupply
          : lpTokenSupply // ignore: cast_nullable_to_non_nullable
              as double,
      fees: null == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as double,
      protocolFees: null == protocolFees
          ? _value.protocolFees
          : protocolFees // ignore: cast_nullable_to_non_nullable
              as double,
      ratioToken1Token2: null == ratioToken1Token2
          ? _value.ratioToken1Token2
          : ratioToken1Token2 // ignore: cast_nullable_to_non_nullable
              as double,
      ratioToken2Token1: null == ratioToken2Token1
          ? _value.ratioToken2Token1
          : ratioToken2Token1 // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalFee: null == token1TotalFee
          ? _value.token1TotalFee
          : token1TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalVolume: null == token1TotalVolume
          ? _value.token1TotalVolume
          : token1TotalVolume // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalFee: null == token2TotalFee
          ? _value.token2TotalFee
          : token2TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalVolume: null == token2TotalVolume
          ? _value.token2TotalVolume
          : token2TotalVolume // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexPoolInfosImplCopyWith<$Res>
    implements $DexPoolInfosCopyWith<$Res> {
  factory _$$DexPoolInfosImplCopyWith(
          _$DexPoolInfosImpl value, $Res Function(_$DexPoolInfosImpl) then) =
      __$$DexPoolInfosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String poolAddress,
      String token1Address,
      String token2Address,
      double token1Reserve,
      double token2Reserve,
      double lpTokenSupply,
      double fees,
      double protocolFees,
      double ratioToken1Token2,
      double ratioToken2Token1,
      double token1TotalFee,
      double token1TotalVolume,
      double token2TotalFee,
      double token2TotalVolume});
}

/// @nodoc
class __$$DexPoolInfosImplCopyWithImpl<$Res>
    extends _$DexPoolInfosCopyWithImpl<$Res, _$DexPoolInfosImpl>
    implements _$$DexPoolInfosImplCopyWith<$Res> {
  __$$DexPoolInfosImplCopyWithImpl(
      _$DexPoolInfosImpl _value, $Res Function(_$DexPoolInfosImpl) _then)
      : super(_value, _then);

  /// Create a copy of DexPoolInfos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddress = null,
    Object? token1Address = null,
    Object? token2Address = null,
    Object? token1Reserve = null,
    Object? token2Reserve = null,
    Object? lpTokenSupply = null,
    Object? fees = null,
    Object? protocolFees = null,
    Object? ratioToken1Token2 = null,
    Object? ratioToken2Token1 = null,
    Object? token1TotalFee = null,
    Object? token1TotalVolume = null,
    Object? token2TotalFee = null,
    Object? token2TotalVolume = null,
  }) {
    return _then(_$DexPoolInfosImpl(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      token1Address: null == token1Address
          ? _value.token1Address
          : token1Address // ignore: cast_nullable_to_non_nullable
              as String,
      token2Address: null == token2Address
          ? _value.token2Address
          : token2Address // ignore: cast_nullable_to_non_nullable
              as String,
      token1Reserve: null == token1Reserve
          ? _value.token1Reserve
          : token1Reserve // ignore: cast_nullable_to_non_nullable
              as double,
      token2Reserve: null == token2Reserve
          ? _value.token2Reserve
          : token2Reserve // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenSupply: null == lpTokenSupply
          ? _value.lpTokenSupply
          : lpTokenSupply // ignore: cast_nullable_to_non_nullable
              as double,
      fees: null == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as double,
      protocolFees: null == protocolFees
          ? _value.protocolFees
          : protocolFees // ignore: cast_nullable_to_non_nullable
              as double,
      ratioToken1Token2: null == ratioToken1Token2
          ? _value.ratioToken1Token2
          : ratioToken1Token2 // ignore: cast_nullable_to_non_nullable
              as double,
      ratioToken2Token1: null == ratioToken2Token1
          ? _value.ratioToken2Token1
          : ratioToken2Token1 // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalFee: null == token1TotalFee
          ? _value.token1TotalFee
          : token1TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalVolume: null == token1TotalVolume
          ? _value.token1TotalVolume
          : token1TotalVolume // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalFee: null == token2TotalFee
          ? _value.token2TotalFee
          : token2TotalFee // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalVolume: null == token2TotalVolume
          ? _value.token2TotalVolume
          : token2TotalVolume // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexPoolInfosImpl extends _DexPoolInfos {
  const _$DexPoolInfosImpl(
      {required this.poolAddress,
      required this.token1Address,
      required this.token2Address,
      required this.token1Reserve,
      required this.token2Reserve,
      required this.lpTokenSupply,
      required this.fees,
      required this.protocolFees,
      required this.ratioToken1Token2,
      required this.ratioToken2Token1,
      required this.token1TotalFee,
      required this.token1TotalVolume,
      required this.token2TotalFee,
      required this.token2TotalVolume})
      : super._();

  factory _$DexPoolInfosImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexPoolInfosImplFromJson(json);

  @override
  final String poolAddress;
  @override
  final String token1Address;
  @override
  final String token2Address;
  @override
  final double token1Reserve;
  @override
  final double token2Reserve;
  @override
  final double lpTokenSupply;
  @override
  final double fees;
  @override
  final double protocolFees;
  @override
  final double ratioToken1Token2;
  @override
  final double ratioToken2Token1;
  @override
  final double token1TotalFee;
  @override
  final double token1TotalVolume;
  @override
  final double token2TotalFee;
  @override
  final double token2TotalVolume;

  @override
  String toString() {
    return 'DexPoolInfos(poolAddress: $poolAddress, token1Address: $token1Address, token2Address: $token2Address, token1Reserve: $token1Reserve, token2Reserve: $token2Reserve, lpTokenSupply: $lpTokenSupply, fees: $fees, protocolFees: $protocolFees, ratioToken1Token2: $ratioToken1Token2, ratioToken2Token1: $ratioToken2Token1, token1TotalFee: $token1TotalFee, token1TotalVolume: $token1TotalVolume, token2TotalFee: $token2TotalFee, token2TotalVolume: $token2TotalVolume)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexPoolInfosImpl &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.token1Address, token1Address) ||
                other.token1Address == token1Address) &&
            (identical(other.token2Address, token2Address) ||
                other.token2Address == token2Address) &&
            (identical(other.token1Reserve, token1Reserve) ||
                other.token1Reserve == token1Reserve) &&
            (identical(other.token2Reserve, token2Reserve) ||
                other.token2Reserve == token2Reserve) &&
            (identical(other.lpTokenSupply, lpTokenSupply) ||
                other.lpTokenSupply == lpTokenSupply) &&
            (identical(other.fees, fees) || other.fees == fees) &&
            (identical(other.protocolFees, protocolFees) ||
                other.protocolFees == protocolFees) &&
            (identical(other.ratioToken1Token2, ratioToken1Token2) ||
                other.ratioToken1Token2 == ratioToken1Token2) &&
            (identical(other.ratioToken2Token1, ratioToken2Token1) ||
                other.ratioToken2Token1 == ratioToken2Token1) &&
            (identical(other.token1TotalFee, token1TotalFee) ||
                other.token1TotalFee == token1TotalFee) &&
            (identical(other.token1TotalVolume, token1TotalVolume) ||
                other.token1TotalVolume == token1TotalVolume) &&
            (identical(other.token2TotalFee, token2TotalFee) ||
                other.token2TotalFee == token2TotalFee) &&
            (identical(other.token2TotalVolume, token2TotalVolume) ||
                other.token2TotalVolume == token2TotalVolume));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      poolAddress,
      token1Address,
      token2Address,
      token1Reserve,
      token2Reserve,
      lpTokenSupply,
      fees,
      protocolFees,
      ratioToken1Token2,
      ratioToken2Token1,
      token1TotalFee,
      token1TotalVolume,
      token2TotalFee,
      token2TotalVolume);

  /// Create a copy of DexPoolInfos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPoolInfosImplCopyWith<_$DexPoolInfosImpl> get copyWith =>
      __$$DexPoolInfosImplCopyWithImpl<_$DexPoolInfosImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexPoolInfosImplToJson(
      this,
    );
  }
}

abstract class _DexPoolInfos extends DexPoolInfos {
  const factory _DexPoolInfos(
      {required final String poolAddress,
      required final String token1Address,
      required final String token2Address,
      required final double token1Reserve,
      required final double token2Reserve,
      required final double lpTokenSupply,
      required final double fees,
      required final double protocolFees,
      required final double ratioToken1Token2,
      required final double ratioToken2Token1,
      required final double token1TotalFee,
      required final double token1TotalVolume,
      required final double token2TotalFee,
      required final double token2TotalVolume}) = _$DexPoolInfosImpl;
  const _DexPoolInfos._() : super._();

  factory _DexPoolInfos.fromJson(Map<String, dynamic> json) =
      _$DexPoolInfosImpl.fromJson;

  @override
  String get poolAddress;
  @override
  String get token1Address;
  @override
  String get token2Address;
  @override
  double get token1Reserve;
  @override
  double get token2Reserve;
  @override
  double get lpTokenSupply;
  @override
  double get fees;
  @override
  double get protocolFees;
  @override
  double get ratioToken1Token2;
  @override
  double get ratioToken2Token1;
  @override
  double get token1TotalFee;
  @override
  double get token1TotalVolume;
  @override
  double get token2TotalFee;
  @override
  double get token2TotalVolume;

  /// Create a copy of DexPoolInfos
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DexPoolInfosImplCopyWith<_$DexPoolInfosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DexPoolStats _$DexPoolStatsFromJson(Map<String, dynamic> json) {
  return _DexPoolStats.fromJson(json);
}

/// @nodoc
mixin _$DexPoolStats {
  double get token1TotalVolume24h => throw _privateConstructorUsedError;
  double get token2TotalVolume24h => throw _privateConstructorUsedError;
  double get token1TotalVolume7d => throw _privateConstructorUsedError;
  double get token2TotalVolume7d => throw _privateConstructorUsedError;
  double get token1TotalFee24h => throw _privateConstructorUsedError;
  double get token2TotalFee24h => throw _privateConstructorUsedError;
  double get fee24h => throw _privateConstructorUsedError;
  double get feeAllTime => throw _privateConstructorUsedError;
  double get volume24h => throw _privateConstructorUsedError;
  double get volume7d => throw _privateConstructorUsedError;
  double get volumeAllTime => throw _privateConstructorUsedError;

  /// Serializes this DexPoolStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DexPoolStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DexPoolStatsCopyWith<DexPoolStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexPoolStatsCopyWith<$Res> {
  factory $DexPoolStatsCopyWith(
          DexPoolStats value, $Res Function(DexPoolStats) then) =
      _$DexPoolStatsCopyWithImpl<$Res, DexPoolStats>;
  @useResult
  $Res call(
      {double token1TotalVolume24h,
      double token2TotalVolume24h,
      double token1TotalVolume7d,
      double token2TotalVolume7d,
      double token1TotalFee24h,
      double token2TotalFee24h,
      double fee24h,
      double feeAllTime,
      double volume24h,
      double volume7d,
      double volumeAllTime});
}

/// @nodoc
class _$DexPoolStatsCopyWithImpl<$Res, $Val extends DexPoolStats>
    implements $DexPoolStatsCopyWith<$Res> {
  _$DexPoolStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DexPoolStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1TotalVolume24h = null,
    Object? token2TotalVolume24h = null,
    Object? token1TotalVolume7d = null,
    Object? token2TotalVolume7d = null,
    Object? token1TotalFee24h = null,
    Object? token2TotalFee24h = null,
    Object? fee24h = null,
    Object? feeAllTime = null,
    Object? volume24h = null,
    Object? volume7d = null,
    Object? volumeAllTime = null,
  }) {
    return _then(_value.copyWith(
      token1TotalVolume24h: null == token1TotalVolume24h
          ? _value.token1TotalVolume24h
          : token1TotalVolume24h // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalVolume24h: null == token2TotalVolume24h
          ? _value.token2TotalVolume24h
          : token2TotalVolume24h // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalVolume7d: null == token1TotalVolume7d
          ? _value.token1TotalVolume7d
          : token1TotalVolume7d // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalVolume7d: null == token2TotalVolume7d
          ? _value.token2TotalVolume7d
          : token2TotalVolume7d // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalFee24h: null == token1TotalFee24h
          ? _value.token1TotalFee24h
          : token1TotalFee24h // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalFee24h: null == token2TotalFee24h
          ? _value.token2TotalFee24h
          : token2TotalFee24h // ignore: cast_nullable_to_non_nullable
              as double,
      fee24h: null == fee24h
          ? _value.fee24h
          : fee24h // ignore: cast_nullable_to_non_nullable
              as double,
      feeAllTime: null == feeAllTime
          ? _value.feeAllTime
          : feeAllTime // ignore: cast_nullable_to_non_nullable
              as double,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as double,
      volume7d: null == volume7d
          ? _value.volume7d
          : volume7d // ignore: cast_nullable_to_non_nullable
              as double,
      volumeAllTime: null == volumeAllTime
          ? _value.volumeAllTime
          : volumeAllTime // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexPoolStatsImplCopyWith<$Res>
    implements $DexPoolStatsCopyWith<$Res> {
  factory _$$DexPoolStatsImplCopyWith(
          _$DexPoolStatsImpl value, $Res Function(_$DexPoolStatsImpl) then) =
      __$$DexPoolStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double token1TotalVolume24h,
      double token2TotalVolume24h,
      double token1TotalVolume7d,
      double token2TotalVolume7d,
      double token1TotalFee24h,
      double token2TotalFee24h,
      double fee24h,
      double feeAllTime,
      double volume24h,
      double volume7d,
      double volumeAllTime});
}

/// @nodoc
class __$$DexPoolStatsImplCopyWithImpl<$Res>
    extends _$DexPoolStatsCopyWithImpl<$Res, _$DexPoolStatsImpl>
    implements _$$DexPoolStatsImplCopyWith<$Res> {
  __$$DexPoolStatsImplCopyWithImpl(
      _$DexPoolStatsImpl _value, $Res Function(_$DexPoolStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DexPoolStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1TotalVolume24h = null,
    Object? token2TotalVolume24h = null,
    Object? token1TotalVolume7d = null,
    Object? token2TotalVolume7d = null,
    Object? token1TotalFee24h = null,
    Object? token2TotalFee24h = null,
    Object? fee24h = null,
    Object? feeAllTime = null,
    Object? volume24h = null,
    Object? volume7d = null,
    Object? volumeAllTime = null,
  }) {
    return _then(_$DexPoolStatsImpl(
      token1TotalVolume24h: null == token1TotalVolume24h
          ? _value.token1TotalVolume24h
          : token1TotalVolume24h // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalVolume24h: null == token2TotalVolume24h
          ? _value.token2TotalVolume24h
          : token2TotalVolume24h // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalVolume7d: null == token1TotalVolume7d
          ? _value.token1TotalVolume7d
          : token1TotalVolume7d // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalVolume7d: null == token2TotalVolume7d
          ? _value.token2TotalVolume7d
          : token2TotalVolume7d // ignore: cast_nullable_to_non_nullable
              as double,
      token1TotalFee24h: null == token1TotalFee24h
          ? _value.token1TotalFee24h
          : token1TotalFee24h // ignore: cast_nullable_to_non_nullable
              as double,
      token2TotalFee24h: null == token2TotalFee24h
          ? _value.token2TotalFee24h
          : token2TotalFee24h // ignore: cast_nullable_to_non_nullable
              as double,
      fee24h: null == fee24h
          ? _value.fee24h
          : fee24h // ignore: cast_nullable_to_non_nullable
              as double,
      feeAllTime: null == feeAllTime
          ? _value.feeAllTime
          : feeAllTime // ignore: cast_nullable_to_non_nullable
              as double,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as double,
      volume7d: null == volume7d
          ? _value.volume7d
          : volume7d // ignore: cast_nullable_to_non_nullable
              as double,
      volumeAllTime: null == volumeAllTime
          ? _value.volumeAllTime
          : volumeAllTime // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexPoolStatsImpl extends _DexPoolStats {
  const _$DexPoolStatsImpl(
      {required this.token1TotalVolume24h,
      required this.token2TotalVolume24h,
      required this.token1TotalVolume7d,
      required this.token2TotalVolume7d,
      required this.token1TotalFee24h,
      required this.token2TotalFee24h,
      required this.fee24h,
      required this.feeAllTime,
      required this.volume24h,
      required this.volume7d,
      required this.volumeAllTime})
      : super._();

  factory _$DexPoolStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexPoolStatsImplFromJson(json);

  @override
  final double token1TotalVolume24h;
  @override
  final double token2TotalVolume24h;
  @override
  final double token1TotalVolume7d;
  @override
  final double token2TotalVolume7d;
  @override
  final double token1TotalFee24h;
  @override
  final double token2TotalFee24h;
  @override
  final double fee24h;
  @override
  final double feeAllTime;
  @override
  final double volume24h;
  @override
  final double volume7d;
  @override
  final double volumeAllTime;

  @override
  String toString() {
    return 'DexPoolStats(token1TotalVolume24h: $token1TotalVolume24h, token2TotalVolume24h: $token2TotalVolume24h, token1TotalVolume7d: $token1TotalVolume7d, token2TotalVolume7d: $token2TotalVolume7d, token1TotalFee24h: $token1TotalFee24h, token2TotalFee24h: $token2TotalFee24h, fee24h: $fee24h, feeAllTime: $feeAllTime, volume24h: $volume24h, volume7d: $volume7d, volumeAllTime: $volumeAllTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexPoolStatsImpl &&
            (identical(other.token1TotalVolume24h, token1TotalVolume24h) ||
                other.token1TotalVolume24h == token1TotalVolume24h) &&
            (identical(other.token2TotalVolume24h, token2TotalVolume24h) ||
                other.token2TotalVolume24h == token2TotalVolume24h) &&
            (identical(other.token1TotalVolume7d, token1TotalVolume7d) ||
                other.token1TotalVolume7d == token1TotalVolume7d) &&
            (identical(other.token2TotalVolume7d, token2TotalVolume7d) ||
                other.token2TotalVolume7d == token2TotalVolume7d) &&
            (identical(other.token1TotalFee24h, token1TotalFee24h) ||
                other.token1TotalFee24h == token1TotalFee24h) &&
            (identical(other.token2TotalFee24h, token2TotalFee24h) ||
                other.token2TotalFee24h == token2TotalFee24h) &&
            (identical(other.fee24h, fee24h) || other.fee24h == fee24h) &&
            (identical(other.feeAllTime, feeAllTime) ||
                other.feeAllTime == feeAllTime) &&
            (identical(other.volume24h, volume24h) ||
                other.volume24h == volume24h) &&
            (identical(other.volume7d, volume7d) ||
                other.volume7d == volume7d) &&
            (identical(other.volumeAllTime, volumeAllTime) ||
                other.volumeAllTime == volumeAllTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      token1TotalVolume24h,
      token2TotalVolume24h,
      token1TotalVolume7d,
      token2TotalVolume7d,
      token1TotalFee24h,
      token2TotalFee24h,
      fee24h,
      feeAllTime,
      volume24h,
      volume7d,
      volumeAllTime);

  /// Create a copy of DexPoolStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPoolStatsImplCopyWith<_$DexPoolStatsImpl> get copyWith =>
      __$$DexPoolStatsImplCopyWithImpl<_$DexPoolStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexPoolStatsImplToJson(
      this,
    );
  }
}

abstract class _DexPoolStats extends DexPoolStats {
  const factory _DexPoolStats(
      {required final double token1TotalVolume24h,
      required final double token2TotalVolume24h,
      required final double token1TotalVolume7d,
      required final double token2TotalVolume7d,
      required final double token1TotalFee24h,
      required final double token2TotalFee24h,
      required final double fee24h,
      required final double feeAllTime,
      required final double volume24h,
      required final double volume7d,
      required final double volumeAllTime}) = _$DexPoolStatsImpl;
  const _DexPoolStats._() : super._();

  factory _DexPoolStats.fromJson(Map<String, dynamic> json) =
      _$DexPoolStatsImpl.fromJson;

  @override
  double get token1TotalVolume24h;
  @override
  double get token2TotalVolume24h;
  @override
  double get token1TotalVolume7d;
  @override
  double get token2TotalVolume7d;
  @override
  double get token1TotalFee24h;
  @override
  double get token2TotalFee24h;
  @override
  double get fee24h;
  @override
  double get feeAllTime;
  @override
  double get volume24h;
  @override
  double get volume7d;
  @override
  double get volumeAllTime;

  /// Create a copy of DexPoolStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DexPoolStatsImplCopyWith<_$DexPoolStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
