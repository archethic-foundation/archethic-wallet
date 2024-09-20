// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_farm_lock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexFarmLock _$DexFarmLockFromJson(Map<String, dynamic> json) {
  return _DexFarmLock.fromJson(json);
}

/// @nodoc
mixin _$DexFarmLock {
  String get farmAddress => throw _privateConstructorUsedError;
  String get poolAddress => throw _privateConstructorUsedError;
  double get remainingReward => throw _privateConstructorUsedError;
  double get remainingRewardInFiat => throw _privateConstructorUsedError;
  double get rewardDistributed => throw _privateConstructorUsedError;
  double get lpTokensDeposited => throw _privateConstructorUsedError;
  DexToken? get lpToken => throw _privateConstructorUsedError;
  DexPair? get lpTokenPair => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  DexToken? get rewardToken => throw _privateConstructorUsedError;
  double get apr => throw _privateConstructorUsedError;
  double get estimateLPTokenInFiat => throw _privateConstructorUsedError;
  Map<String, int> get availableLevels => throw _privateConstructorUsedError;
  Map<String, DexFarmLockStats> get stats => throw _privateConstructorUsedError;
  Map<String, DexFarmLockUserInfos> get userInfos =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DexFarmLockCopyWith<DexFarmLock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexFarmLockCopyWith<$Res> {
  factory $DexFarmLockCopyWith(
          DexFarmLock value, $Res Function(DexFarmLock) then) =
      _$DexFarmLockCopyWithImpl<$Res, DexFarmLock>;
  @useResult
  $Res call(
      {String farmAddress,
      String poolAddress,
      double remainingReward,
      double remainingRewardInFiat,
      double rewardDistributed,
      double lpTokensDeposited,
      DexToken? lpToken,
      DexPair? lpTokenPair,
      DateTime? startDate,
      DateTime? endDate,
      DexToken? rewardToken,
      double apr,
      double estimateLPTokenInFiat,
      Map<String, int> availableLevels,
      Map<String, DexFarmLockStats> stats,
      Map<String, DexFarmLockUserInfos> userInfos});

  $DexTokenCopyWith<$Res>? get lpToken;
  $DexPairCopyWith<$Res>? get lpTokenPair;
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class _$DexFarmLockCopyWithImpl<$Res, $Val extends DexFarmLock>
    implements $DexFarmLockCopyWith<$Res> {
  _$DexFarmLockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmAddress = null,
    Object? poolAddress = null,
    Object? remainingReward = null,
    Object? remainingRewardInFiat = null,
    Object? rewardDistributed = null,
    Object? lpTokensDeposited = null,
    Object? lpToken = freezed,
    Object? lpTokenPair = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? rewardToken = freezed,
    Object? apr = null,
    Object? estimateLPTokenInFiat = null,
    Object? availableLevels = null,
    Object? stats = null,
    Object? userInfos = null,
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
      remainingReward: null == remainingReward
          ? _value.remainingReward
          : remainingReward // ignore: cast_nullable_to_non_nullable
              as double,
      remainingRewardInFiat: null == remainingRewardInFiat
          ? _value.remainingRewardInFiat
          : remainingRewardInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      rewardDistributed: null == rewardDistributed
          ? _value.rewardDistributed
          : rewardDistributed // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokensDeposited: null == lpTokensDeposited
          ? _value.lpTokensDeposited
          : lpTokensDeposited // ignore: cast_nullable_to_non_nullable
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
      apr: null == apr
          ? _value.apr
          : apr // ignore: cast_nullable_to_non_nullable
              as double,
      estimateLPTokenInFiat: null == estimateLPTokenInFiat
          ? _value.estimateLPTokenInFiat
          : estimateLPTokenInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      availableLevels: null == availableLevels
          ? _value.availableLevels
          : availableLevels // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, DexFarmLockStats>,
      userInfos: null == userInfos
          ? _value.userInfos
          : userInfos // ignore: cast_nullable_to_non_nullable
              as Map<String, DexFarmLockUserInfos>,
    ) as $Val);
  }

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
abstract class _$$DexFarmLockImplCopyWith<$Res>
    implements $DexFarmLockCopyWith<$Res> {
  factory _$$DexFarmLockImplCopyWith(
          _$DexFarmLockImpl value, $Res Function(_$DexFarmLockImpl) then) =
      __$$DexFarmLockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String farmAddress,
      String poolAddress,
      double remainingReward,
      double remainingRewardInFiat,
      double rewardDistributed,
      double lpTokensDeposited,
      DexToken? lpToken,
      DexPair? lpTokenPair,
      DateTime? startDate,
      DateTime? endDate,
      DexToken? rewardToken,
      double apr,
      double estimateLPTokenInFiat,
      Map<String, int> availableLevels,
      Map<String, DexFarmLockStats> stats,
      Map<String, DexFarmLockUserInfos> userInfos});

  @override
  $DexTokenCopyWith<$Res>? get lpToken;
  @override
  $DexPairCopyWith<$Res>? get lpTokenPair;
  @override
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class __$$DexFarmLockImplCopyWithImpl<$Res>
    extends _$DexFarmLockCopyWithImpl<$Res, _$DexFarmLockImpl>
    implements _$$DexFarmLockImplCopyWith<$Res> {
  __$$DexFarmLockImplCopyWithImpl(
      _$DexFarmLockImpl _value, $Res Function(_$DexFarmLockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmAddress = null,
    Object? poolAddress = null,
    Object? remainingReward = null,
    Object? remainingRewardInFiat = null,
    Object? rewardDistributed = null,
    Object? lpTokensDeposited = null,
    Object? lpToken = freezed,
    Object? lpTokenPair = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? rewardToken = freezed,
    Object? apr = null,
    Object? estimateLPTokenInFiat = null,
    Object? availableLevels = null,
    Object? stats = null,
    Object? userInfos = null,
  }) {
    return _then(_$DexFarmLockImpl(
      farmAddress: null == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String,
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      remainingReward: null == remainingReward
          ? _value.remainingReward
          : remainingReward // ignore: cast_nullable_to_non_nullable
              as double,
      remainingRewardInFiat: null == remainingRewardInFiat
          ? _value.remainingRewardInFiat
          : remainingRewardInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      rewardDistributed: null == rewardDistributed
          ? _value.rewardDistributed
          : rewardDistributed // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokensDeposited: null == lpTokensDeposited
          ? _value.lpTokensDeposited
          : lpTokensDeposited // ignore: cast_nullable_to_non_nullable
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
      apr: null == apr
          ? _value.apr
          : apr // ignore: cast_nullable_to_non_nullable
              as double,
      estimateLPTokenInFiat: null == estimateLPTokenInFiat
          ? _value.estimateLPTokenInFiat
          : estimateLPTokenInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      availableLevels: null == availableLevels
          ? _value._availableLevels
          : availableLevels // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      stats: null == stats
          ? _value._stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, DexFarmLockStats>,
      userInfos: null == userInfos
          ? _value._userInfos
          : userInfos // ignore: cast_nullable_to_non_nullable
              as Map<String, DexFarmLockUserInfos>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexFarmLockImpl extends _DexFarmLock {
  const _$DexFarmLockImpl(
      {this.farmAddress = '',
      this.poolAddress = '',
      this.remainingReward = 0.0,
      this.remainingRewardInFiat = 0.0,
      this.rewardDistributed = 0.0,
      this.lpTokensDeposited = 0.0,
      this.lpToken,
      this.lpTokenPair,
      this.startDate,
      this.endDate,
      this.rewardToken,
      this.apr = 0,
      this.estimateLPTokenInFiat = 0,
      final Map<String, int> availableLevels = const {},
      final Map<String, DexFarmLockStats> stats = const {},
      final Map<String, DexFarmLockUserInfos> userInfos = const {}})
      : _availableLevels = availableLevels,
        _stats = stats,
        _userInfos = userInfos,
        super._();

  factory _$DexFarmLockImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexFarmLockImplFromJson(json);

  @override
  @JsonKey()
  final String farmAddress;
  @override
  @JsonKey()
  final String poolAddress;
  @override
  @JsonKey()
  final double remainingReward;
  @override
  @JsonKey()
  final double remainingRewardInFiat;
  @override
  @JsonKey()
  final double rewardDistributed;
  @override
  @JsonKey()
  final double lpTokensDeposited;
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
  final double apr;
  @override
  @JsonKey()
  final double estimateLPTokenInFiat;
  final Map<String, int> _availableLevels;
  @override
  @JsonKey()
  Map<String, int> get availableLevels {
    if (_availableLevels is EqualUnmodifiableMapView) return _availableLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_availableLevels);
  }

  final Map<String, DexFarmLockStats> _stats;
  @override
  @JsonKey()
  Map<String, DexFarmLockStats> get stats {
    if (_stats is EqualUnmodifiableMapView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stats);
  }

  final Map<String, DexFarmLockUserInfos> _userInfos;
  @override
  @JsonKey()
  Map<String, DexFarmLockUserInfos> get userInfos {
    if (_userInfos is EqualUnmodifiableMapView) return _userInfos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userInfos);
  }

  @override
  String toString() {
    return 'DexFarmLock(farmAddress: $farmAddress, poolAddress: $poolAddress, remainingReward: $remainingReward, remainingRewardInFiat: $remainingRewardInFiat, rewardDistributed: $rewardDistributed, lpTokensDeposited: $lpTokensDeposited, lpToken: $lpToken, lpTokenPair: $lpTokenPair, startDate: $startDate, endDate: $endDate, rewardToken: $rewardToken, apr: $apr, estimateLPTokenInFiat: $estimateLPTokenInFiat, availableLevels: $availableLevels, stats: $stats, userInfos: $userInfos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexFarmLockImpl &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.remainingReward, remainingReward) ||
                other.remainingReward == remainingReward) &&
            (identical(other.remainingRewardInFiat, remainingRewardInFiat) ||
                other.remainingRewardInFiat == remainingRewardInFiat) &&
            (identical(other.rewardDistributed, rewardDistributed) ||
                other.rewardDistributed == rewardDistributed) &&
            (identical(other.lpTokensDeposited, lpTokensDeposited) ||
                other.lpTokensDeposited == lpTokensDeposited) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken) &&
            (identical(other.lpTokenPair, lpTokenPair) ||
                other.lpTokenPair == lpTokenPair) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken) &&
            (identical(other.apr, apr) || other.apr == apr) &&
            (identical(other.estimateLPTokenInFiat, estimateLPTokenInFiat) ||
                other.estimateLPTokenInFiat == estimateLPTokenInFiat) &&
            const DeepCollectionEquality()
                .equals(other._availableLevels, _availableLevels) &&
            const DeepCollectionEquality().equals(other._stats, _stats) &&
            const DeepCollectionEquality()
                .equals(other._userInfos, _userInfos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      farmAddress,
      poolAddress,
      remainingReward,
      remainingRewardInFiat,
      rewardDistributed,
      lpTokensDeposited,
      lpToken,
      lpTokenPair,
      startDate,
      endDate,
      rewardToken,
      apr,
      estimateLPTokenInFiat,
      const DeepCollectionEquality().hash(_availableLevels),
      const DeepCollectionEquality().hash(_stats),
      const DeepCollectionEquality().hash(_userInfos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexFarmLockImplCopyWith<_$DexFarmLockImpl> get copyWith =>
      __$$DexFarmLockImplCopyWithImpl<_$DexFarmLockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexFarmLockImplToJson(
      this,
    );
  }
}

abstract class _DexFarmLock extends DexFarmLock {
  const factory _DexFarmLock(
      {final String farmAddress,
      final String poolAddress,
      final double remainingReward,
      final double remainingRewardInFiat,
      final double rewardDistributed,
      final double lpTokensDeposited,
      final DexToken? lpToken,
      final DexPair? lpTokenPair,
      final DateTime? startDate,
      final DateTime? endDate,
      final DexToken? rewardToken,
      final double apr,
      final double estimateLPTokenInFiat,
      final Map<String, int> availableLevels,
      final Map<String, DexFarmLockStats> stats,
      final Map<String, DexFarmLockUserInfos> userInfos}) = _$DexFarmLockImpl;
  const _DexFarmLock._() : super._();

  factory _DexFarmLock.fromJson(Map<String, dynamic> json) =
      _$DexFarmLockImpl.fromJson;

  @override
  String get farmAddress;
  @override
  String get poolAddress;
  @override
  double get remainingReward;
  @override
  double get remainingRewardInFiat;
  @override
  double get rewardDistributed;
  @override
  double get lpTokensDeposited;
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
  double get apr;
  @override
  double get estimateLPTokenInFiat;
  @override
  Map<String, int> get availableLevels;
  @override
  Map<String, DexFarmLockStats> get stats;
  @override
  Map<String, DexFarmLockUserInfos> get userInfos;
  @override
  @JsonKey(ignore: true)
  _$$DexFarmLockImplCopyWith<_$DexFarmLockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
