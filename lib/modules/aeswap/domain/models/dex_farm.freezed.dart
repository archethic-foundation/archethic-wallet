// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_farm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexFarm _$DexFarmFromJson(Map<String, dynamic> json) {
  return _DexFarm.fromJson(json);
}

/// @nodoc
mixin _$DexFarm {
  String get farmAddress => throw _privateConstructorUsedError;
  String get poolAddress => throw _privateConstructorUsedError;
  double get apr => throw _privateConstructorUsedError;
  DexToken? get lpToken => throw _privateConstructorUsedError;
  DexPair? get lpTokenPair => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  DexToken? get rewardToken => throw _privateConstructorUsedError;
  double get remainingReward => throw _privateConstructorUsedError;
  double get remainingRewardInFiat => throw _privateConstructorUsedError;
  double get lpTokenDeposited => throw _privateConstructorUsedError;
  int get nbDeposit => throw _privateConstructorUsedError;
  double get estimateLPTokenInFiat => throw _privateConstructorUsedError;
  double get statsRewardDistributed =>
      throw _privateConstructorUsedError; // User info
  double? get depositedAmount => throw _privateConstructorUsedError;
  double? get rewardAmount => throw _privateConstructorUsedError;

  /// Serializes this DexFarm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DexFarm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DexFarmCopyWith<DexFarm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexFarmCopyWith<$Res> {
  factory $DexFarmCopyWith(DexFarm value, $Res Function(DexFarm) then) =
      _$DexFarmCopyWithImpl<$Res, DexFarm>;
  @useResult
  $Res call(
      {String farmAddress,
      String poolAddress,
      double apr,
      DexToken? lpToken,
      DexPair? lpTokenPair,
      DateTime? startDate,
      DateTime? endDate,
      DexToken? rewardToken,
      double remainingReward,
      double remainingRewardInFiat,
      double lpTokenDeposited,
      int nbDeposit,
      double estimateLPTokenInFiat,
      double statsRewardDistributed,
      double? depositedAmount,
      double? rewardAmount});

  $DexTokenCopyWith<$Res>? get lpToken;
  $DexPairCopyWith<$Res>? get lpTokenPair;
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class _$DexFarmCopyWithImpl<$Res, $Val extends DexFarm>
    implements $DexFarmCopyWith<$Res> {
  _$DexFarmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DexFarm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmAddress = null,
    Object? poolAddress = null,
    Object? apr = null,
    Object? lpToken = freezed,
    Object? lpTokenPair = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? rewardToken = freezed,
    Object? remainingReward = null,
    Object? remainingRewardInFiat = null,
    Object? lpTokenDeposited = null,
    Object? nbDeposit = null,
    Object? estimateLPTokenInFiat = null,
    Object? statsRewardDistributed = null,
    Object? depositedAmount = freezed,
    Object? rewardAmount = freezed,
  }) {
    return _then(_value.copyWith(
      farmAddress: null == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String,
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      apr: null == apr
          ? _value.apr
          : apr // ignore: cast_nullable_to_non_nullable
              as double,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpTokenPair: freezed == lpTokenPair
          ? _value.lpTokenPair
          : lpTokenPair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      remainingReward: null == remainingReward
          ? _value.remainingReward
          : remainingReward // ignore: cast_nullable_to_non_nullable
              as double,
      remainingRewardInFiat: null == remainingRewardInFiat
          ? _value.remainingRewardInFiat
          : remainingRewardInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenDeposited: null == lpTokenDeposited
          ? _value.lpTokenDeposited
          : lpTokenDeposited // ignore: cast_nullable_to_non_nullable
              as double,
      nbDeposit: null == nbDeposit
          ? _value.nbDeposit
          : nbDeposit // ignore: cast_nullable_to_non_nullable
              as int,
      estimateLPTokenInFiat: null == estimateLPTokenInFiat
          ? _value.estimateLPTokenInFiat
          : estimateLPTokenInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      statsRewardDistributed: null == statsRewardDistributed
          ? _value.statsRewardDistributed
          : statsRewardDistributed // ignore: cast_nullable_to_non_nullable
              as double,
      depositedAmount: freezed == depositedAmount
          ? _value.depositedAmount
          : depositedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      rewardAmount: freezed == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of DexFarm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get lpToken {
    if (_value.lpToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.lpToken!, (value) {
      return _then(_value.copyWith(lpToken: value) as $Val);
    });
  }

  /// Create a copy of DexFarm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexPairCopyWith<$Res>? get lpTokenPair {
    if (_value.lpTokenPair == null) {
      return null;
    }

    return $DexPairCopyWith<$Res>(_value.lpTokenPair!, (value) {
      return _then(_value.copyWith(lpTokenPair: value) as $Val);
    });
  }

  /// Create a copy of DexFarm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get rewardToken {
    if (_value.rewardToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.rewardToken!, (value) {
      return _then(_value.copyWith(rewardToken: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DexFarmImplCopyWith<$Res> implements $DexFarmCopyWith<$Res> {
  factory _$$DexFarmImplCopyWith(
          _$DexFarmImpl value, $Res Function(_$DexFarmImpl) then) =
      __$$DexFarmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String farmAddress,
      String poolAddress,
      double apr,
      DexToken? lpToken,
      DexPair? lpTokenPair,
      DateTime? startDate,
      DateTime? endDate,
      DexToken? rewardToken,
      double remainingReward,
      double remainingRewardInFiat,
      double lpTokenDeposited,
      int nbDeposit,
      double estimateLPTokenInFiat,
      double statsRewardDistributed,
      double? depositedAmount,
      double? rewardAmount});

  @override
  $DexTokenCopyWith<$Res>? get lpToken;
  @override
  $DexPairCopyWith<$Res>? get lpTokenPair;
  @override
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class __$$DexFarmImplCopyWithImpl<$Res>
    extends _$DexFarmCopyWithImpl<$Res, _$DexFarmImpl>
    implements _$$DexFarmImplCopyWith<$Res> {
  __$$DexFarmImplCopyWithImpl(
      _$DexFarmImpl _value, $Res Function(_$DexFarmImpl) _then)
      : super(_value, _then);

  /// Create a copy of DexFarm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmAddress = null,
    Object? poolAddress = null,
    Object? apr = null,
    Object? lpToken = freezed,
    Object? lpTokenPair = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? rewardToken = freezed,
    Object? remainingReward = null,
    Object? remainingRewardInFiat = null,
    Object? lpTokenDeposited = null,
    Object? nbDeposit = null,
    Object? estimateLPTokenInFiat = null,
    Object? statsRewardDistributed = null,
    Object? depositedAmount = freezed,
    Object? rewardAmount = freezed,
  }) {
    return _then(_$DexFarmImpl(
      farmAddress: null == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String,
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      apr: null == apr
          ? _value.apr
          : apr // ignore: cast_nullable_to_non_nullable
              as double,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpTokenPair: freezed == lpTokenPair
          ? _value.lpTokenPair
          : lpTokenPair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      remainingReward: null == remainingReward
          ? _value.remainingReward
          : remainingReward // ignore: cast_nullable_to_non_nullable
              as double,
      remainingRewardInFiat: null == remainingRewardInFiat
          ? _value.remainingRewardInFiat
          : remainingRewardInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenDeposited: null == lpTokenDeposited
          ? _value.lpTokenDeposited
          : lpTokenDeposited // ignore: cast_nullable_to_non_nullable
              as double,
      nbDeposit: null == nbDeposit
          ? _value.nbDeposit
          : nbDeposit // ignore: cast_nullable_to_non_nullable
              as int,
      estimateLPTokenInFiat: null == estimateLPTokenInFiat
          ? _value.estimateLPTokenInFiat
          : estimateLPTokenInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      statsRewardDistributed: null == statsRewardDistributed
          ? _value.statsRewardDistributed
          : statsRewardDistributed // ignore: cast_nullable_to_non_nullable
              as double,
      depositedAmount: freezed == depositedAmount
          ? _value.depositedAmount
          : depositedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      rewardAmount: freezed == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexFarmImpl extends _DexFarm {
  const _$DexFarmImpl(
      {this.farmAddress = '',
      this.poolAddress = '',
      this.apr = 0,
      this.lpToken,
      this.lpTokenPair,
      this.startDate,
      this.endDate,
      this.rewardToken,
      this.remainingReward = 0,
      this.remainingRewardInFiat = 0,
      this.lpTokenDeposited = 0,
      this.nbDeposit = 0,
      this.estimateLPTokenInFiat = 0,
      this.statsRewardDistributed = 0.0,
      this.depositedAmount,
      this.rewardAmount})
      : super._();

  factory _$DexFarmImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexFarmImplFromJson(json);

  @override
  @JsonKey()
  final String farmAddress;
  @override
  @JsonKey()
  final String poolAddress;
  @override
  @JsonKey()
  final double apr;
  @override
  final DexToken? lpToken;
  @override
  final DexPair? lpTokenPair;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final DexToken? rewardToken;
  @override
  @JsonKey()
  final double remainingReward;
  @override
  @JsonKey()
  final double remainingRewardInFiat;
  @override
  @JsonKey()
  final double lpTokenDeposited;
  @override
  @JsonKey()
  final int nbDeposit;
  @override
  @JsonKey()
  final double estimateLPTokenInFiat;
  @override
  @JsonKey()
  final double statsRewardDistributed;
// User info
  @override
  final double? depositedAmount;
  @override
  final double? rewardAmount;

  @override
  String toString() {
    return 'DexFarm(farmAddress: $farmAddress, poolAddress: $poolAddress, apr: $apr, lpToken: $lpToken, lpTokenPair: $lpTokenPair, startDate: $startDate, endDate: $endDate, rewardToken: $rewardToken, remainingReward: $remainingReward, remainingRewardInFiat: $remainingRewardInFiat, lpTokenDeposited: $lpTokenDeposited, nbDeposit: $nbDeposit, estimateLPTokenInFiat: $estimateLPTokenInFiat, statsRewardDistributed: $statsRewardDistributed, depositedAmount: $depositedAmount, rewardAmount: $rewardAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexFarmImpl &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.apr, apr) || other.apr == apr) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken) &&
            (identical(other.lpTokenPair, lpTokenPair) ||
                other.lpTokenPair == lpTokenPair) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken) &&
            (identical(other.remainingReward, remainingReward) ||
                other.remainingReward == remainingReward) &&
            (identical(other.remainingRewardInFiat, remainingRewardInFiat) ||
                other.remainingRewardInFiat == remainingRewardInFiat) &&
            (identical(other.lpTokenDeposited, lpTokenDeposited) ||
                other.lpTokenDeposited == lpTokenDeposited) &&
            (identical(other.nbDeposit, nbDeposit) ||
                other.nbDeposit == nbDeposit) &&
            (identical(other.estimateLPTokenInFiat, estimateLPTokenInFiat) ||
                other.estimateLPTokenInFiat == estimateLPTokenInFiat) &&
            (identical(other.statsRewardDistributed, statsRewardDistributed) ||
                other.statsRewardDistributed == statsRewardDistributed) &&
            (identical(other.depositedAmount, depositedAmount) ||
                other.depositedAmount == depositedAmount) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      farmAddress,
      poolAddress,
      apr,
      lpToken,
      lpTokenPair,
      startDate,
      endDate,
      rewardToken,
      remainingReward,
      remainingRewardInFiat,
      lpTokenDeposited,
      nbDeposit,
      estimateLPTokenInFiat,
      statsRewardDistributed,
      depositedAmount,
      rewardAmount);

  /// Create a copy of DexFarm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DexFarmImplCopyWith<_$DexFarmImpl> get copyWith =>
      __$$DexFarmImplCopyWithImpl<_$DexFarmImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexFarmImplToJson(
      this,
    );
  }
}

abstract class _DexFarm extends DexFarm {
  const factory _DexFarm(
      {final String farmAddress,
      final String poolAddress,
      final double apr,
      final DexToken? lpToken,
      final DexPair? lpTokenPair,
      final DateTime? startDate,
      final DateTime? endDate,
      final DexToken? rewardToken,
      final double remainingReward,
      final double remainingRewardInFiat,
      final double lpTokenDeposited,
      final int nbDeposit,
      final double estimateLPTokenInFiat,
      final double statsRewardDistributed,
      final double? depositedAmount,
      final double? rewardAmount}) = _$DexFarmImpl;
  const _DexFarm._() : super._();

  factory _DexFarm.fromJson(Map<String, dynamic> json) = _$DexFarmImpl.fromJson;

  @override
  String get farmAddress;
  @override
  String get poolAddress;
  @override
  double get apr;
  @override
  DexToken? get lpToken;
  @override
  DexPair? get lpTokenPair;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  DexToken? get rewardToken;
  @override
  double get remainingReward;
  @override
  double get remainingRewardInFiat;
  @override
  double get lpTokenDeposited;
  @override
  int get nbDeposit;
  @override
  double get estimateLPTokenInFiat;
  @override
  double get statsRewardDistributed; // User info
  @override
  double? get depositedAmount;
  @override
  double? get rewardAmount;

  /// Create a copy of DexFarm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DexFarmImplCopyWith<_$DexFarmImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
