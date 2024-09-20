// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_farm_lock_farm_infos_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetFarmLockFarmInfosResponse _$GetFarmLockFarmInfosResponseFromJson(
    Map<String, dynamic> json) {
  return _GetFarmLockFarmInfosResponse.fromJson(json);
}

/// @nodoc
mixin _$GetFarmLockFarmInfosResponse {
  @JsonKey(name: 'available_levels')
  Map<String, int> get availableLevels => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  int get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  int get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'lp_token_address')
  String get lpTokenAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_rewards')
  double get remainingRewards => throw _privateConstructorUsedError;
  @JsonKey(name: 'reward_token')
  String get rewardToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'rewards_distributed')
  double get rewardsDistributed => throw _privateConstructorUsedError;
  @JsonKey(name: 'lp_tokens_deposited')
  double get lpTokensDeposited => throw _privateConstructorUsedError;
  Map<String, Stats> get stats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetFarmLockFarmInfosResponseCopyWith<GetFarmLockFarmInfosResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetFarmLockFarmInfosResponseCopyWith<$Res> {
  factory $GetFarmLockFarmInfosResponseCopyWith(
          GetFarmLockFarmInfosResponse value,
          $Res Function(GetFarmLockFarmInfosResponse) then) =
      _$GetFarmLockFarmInfosResponseCopyWithImpl<$Res,
          GetFarmLockFarmInfosResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'available_levels') Map<String, int> availableLevels,
      @JsonKey(name: 'start_date') int startDate,
      @JsonKey(name: 'end_date') int endDate,
      @JsonKey(name: 'lp_token_address') String lpTokenAddress,
      @JsonKey(name: 'remaining_rewards') double remainingRewards,
      @JsonKey(name: 'reward_token') String rewardToken,
      @JsonKey(name: 'rewards_distributed') double rewardsDistributed,
      @JsonKey(name: 'lp_tokens_deposited') double lpTokensDeposited,
      Map<String, Stats> stats});
}

/// @nodoc
class _$GetFarmLockFarmInfosResponseCopyWithImpl<$Res,
        $Val extends GetFarmLockFarmInfosResponse>
    implements $GetFarmLockFarmInfosResponseCopyWith<$Res> {
  _$GetFarmLockFarmInfosResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableLevels = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? lpTokenAddress = null,
    Object? remainingRewards = null,
    Object? rewardToken = null,
    Object? rewardsDistributed = null,
    Object? lpTokensDeposited = null,
    Object? stats = null,
  }) {
    return _then(_value.copyWith(
      availableLevels: null == availableLevels
          ? _value.availableLevels
          : availableLevels // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as int,
      lpTokenAddress: null == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      remainingRewards: null == remainingRewards
          ? _value.remainingRewards
          : remainingRewards // ignore: cast_nullable_to_non_nullable
              as double,
      rewardToken: null == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as String,
      rewardsDistributed: null == rewardsDistributed
          ? _value.rewardsDistributed
          : rewardsDistributed // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokensDeposited: null == lpTokensDeposited
          ? _value.lpTokensDeposited
          : lpTokensDeposited // ignore: cast_nullable_to_non_nullable
              as double,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, Stats>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetFarmLockFarmInfosResponseImplCopyWith<$Res>
    implements $GetFarmLockFarmInfosResponseCopyWith<$Res> {
  factory _$$GetFarmLockFarmInfosResponseImplCopyWith(
          _$GetFarmLockFarmInfosResponseImpl value,
          $Res Function(_$GetFarmLockFarmInfosResponseImpl) then) =
      __$$GetFarmLockFarmInfosResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'available_levels') Map<String, int> availableLevels,
      @JsonKey(name: 'start_date') int startDate,
      @JsonKey(name: 'end_date') int endDate,
      @JsonKey(name: 'lp_token_address') String lpTokenAddress,
      @JsonKey(name: 'remaining_rewards') double remainingRewards,
      @JsonKey(name: 'reward_token') String rewardToken,
      @JsonKey(name: 'rewards_distributed') double rewardsDistributed,
      @JsonKey(name: 'lp_tokens_deposited') double lpTokensDeposited,
      Map<String, Stats> stats});
}

/// @nodoc
class __$$GetFarmLockFarmInfosResponseImplCopyWithImpl<$Res>
    extends _$GetFarmLockFarmInfosResponseCopyWithImpl<$Res,
        _$GetFarmLockFarmInfosResponseImpl>
    implements _$$GetFarmLockFarmInfosResponseImplCopyWith<$Res> {
  __$$GetFarmLockFarmInfosResponseImplCopyWithImpl(
      _$GetFarmLockFarmInfosResponseImpl _value,
      $Res Function(_$GetFarmLockFarmInfosResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableLevels = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? lpTokenAddress = null,
    Object? remainingRewards = null,
    Object? rewardToken = null,
    Object? rewardsDistributed = null,
    Object? lpTokensDeposited = null,
    Object? stats = null,
  }) {
    return _then(_$GetFarmLockFarmInfosResponseImpl(
      availableLevels: null == availableLevels
          ? _value._availableLevels
          : availableLevels // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as int,
      lpTokenAddress: null == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      remainingRewards: null == remainingRewards
          ? _value.remainingRewards
          : remainingRewards // ignore: cast_nullable_to_non_nullable
              as double,
      rewardToken: null == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as String,
      rewardsDistributed: null == rewardsDistributed
          ? _value.rewardsDistributed
          : rewardsDistributed // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokensDeposited: null == lpTokensDeposited
          ? _value.lpTokensDeposited
          : lpTokensDeposited // ignore: cast_nullable_to_non_nullable
              as double,
      stats: null == stats
          ? _value._stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, Stats>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetFarmLockFarmInfosResponseImpl
    implements _GetFarmLockFarmInfosResponse {
  const _$GetFarmLockFarmInfosResponseImpl(
      {@JsonKey(name: 'available_levels')
      required final Map<String, int> availableLevels,
      @JsonKey(name: 'start_date') required this.startDate,
      @JsonKey(name: 'end_date') required this.endDate,
      @JsonKey(name: 'lp_token_address') required this.lpTokenAddress,
      @JsonKey(name: 'remaining_rewards') required this.remainingRewards,
      @JsonKey(name: 'reward_token') required this.rewardToken,
      @JsonKey(name: 'rewards_distributed') required this.rewardsDistributed,
      @JsonKey(name: 'lp_tokens_deposited') required this.lpTokensDeposited,
      required final Map<String, Stats> stats})
      : _availableLevels = availableLevels,
        _stats = stats;

  factory _$GetFarmLockFarmInfosResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetFarmLockFarmInfosResponseImplFromJson(json);

  final Map<String, int> _availableLevels;
  @override
  @JsonKey(name: 'available_levels')
  Map<String, int> get availableLevels {
    if (_availableLevels is EqualUnmodifiableMapView) return _availableLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_availableLevels);
  }

  @override
  @JsonKey(name: 'start_date')
  final int startDate;
  @override
  @JsonKey(name: 'end_date')
  final int endDate;
  @override
  @JsonKey(name: 'lp_token_address')
  final String lpTokenAddress;
  @override
  @JsonKey(name: 'remaining_rewards')
  final double remainingRewards;
  @override
  @JsonKey(name: 'reward_token')
  final String rewardToken;
  @override
  @JsonKey(name: 'rewards_distributed')
  final double rewardsDistributed;
  @override
  @JsonKey(name: 'lp_tokens_deposited')
  final double lpTokensDeposited;
  final Map<String, Stats> _stats;
  @override
  Map<String, Stats> get stats {
    if (_stats is EqualUnmodifiableMapView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stats);
  }

  @override
  String toString() {
    return 'GetFarmLockFarmInfosResponse(availableLevels: $availableLevels, startDate: $startDate, endDate: $endDate, lpTokenAddress: $lpTokenAddress, remainingRewards: $remainingRewards, rewardToken: $rewardToken, rewardsDistributed: $rewardsDistributed, lpTokensDeposited: $lpTokensDeposited, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetFarmLockFarmInfosResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._availableLevels, _availableLevels) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.lpTokenAddress, lpTokenAddress) ||
                other.lpTokenAddress == lpTokenAddress) &&
            (identical(other.remainingRewards, remainingRewards) ||
                other.remainingRewards == remainingRewards) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken) &&
            (identical(other.rewardsDistributed, rewardsDistributed) ||
                other.rewardsDistributed == rewardsDistributed) &&
            (identical(other.lpTokensDeposited, lpTokensDeposited) ||
                other.lpTokensDeposited == lpTokensDeposited) &&
            const DeepCollectionEquality().equals(other._stats, _stats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_availableLevels),
      startDate,
      endDate,
      lpTokenAddress,
      remainingRewards,
      rewardToken,
      rewardsDistributed,
      lpTokensDeposited,
      const DeepCollectionEquality().hash(_stats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetFarmLockFarmInfosResponseImplCopyWith<
          _$GetFarmLockFarmInfosResponseImpl>
      get copyWith => __$$GetFarmLockFarmInfosResponseImplCopyWithImpl<
          _$GetFarmLockFarmInfosResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetFarmLockFarmInfosResponseImplToJson(
      this,
    );
  }
}

abstract class _GetFarmLockFarmInfosResponse
    implements GetFarmLockFarmInfosResponse {
  const factory _GetFarmLockFarmInfosResponse(
      {@JsonKey(name: 'available_levels')
      required final Map<String, int> availableLevels,
      @JsonKey(name: 'start_date') required final int startDate,
      @JsonKey(name: 'end_date') required final int endDate,
      @JsonKey(name: 'lp_token_address') required final String lpTokenAddress,
      @JsonKey(name: 'remaining_rewards')
      required final double remainingRewards,
      @JsonKey(name: 'reward_token') required final String rewardToken,
      @JsonKey(name: 'rewards_distributed')
      required final double rewardsDistributed,
      @JsonKey(name: 'lp_tokens_deposited')
      required final double lpTokensDeposited,
      required final Map<String, Stats>
          stats}) = _$GetFarmLockFarmInfosResponseImpl;

  factory _GetFarmLockFarmInfosResponse.fromJson(Map<String, dynamic> json) =
      _$GetFarmLockFarmInfosResponseImpl.fromJson;

  @override
  @JsonKey(name: 'available_levels')
  Map<String, int> get availableLevels;
  @override
  @JsonKey(name: 'start_date')
  int get startDate;
  @override
  @JsonKey(name: 'end_date')
  int get endDate;
  @override
  @JsonKey(name: 'lp_token_address')
  String get lpTokenAddress;
  @override
  @JsonKey(name: 'remaining_rewards')
  double get remainingRewards;
  @override
  @JsonKey(name: 'reward_token')
  String get rewardToken;
  @override
  @JsonKey(name: 'rewards_distributed')
  double get rewardsDistributed;
  @override
  @JsonKey(name: 'lp_tokens_deposited')
  double get lpTokensDeposited;
  @override
  Map<String, Stats> get stats;
  @override
  @JsonKey(ignore: true)
  _$$GetFarmLockFarmInfosResponseImplCopyWith<
          _$GetFarmLockFarmInfosResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Stats _$StatsFromJson(Map<String, dynamic> json) {
  return _Stats.fromJson(json);
}

/// @nodoc
mixin _$Stats {
  @JsonKey(name: 'deposits_count')
  int get depositsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'lp_tokens_deposited')
  double get lpTokensDeposited => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_rewards')
  List<RemainingRewards> get remainingRewards =>
      throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatsCopyWith<Stats> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsCopyWith<$Res> {
  factory $StatsCopyWith(Stats value, $Res Function(Stats) then) =
      _$StatsCopyWithImpl<$Res, Stats>;
  @useResult
  $Res call(
      {@JsonKey(name: 'deposits_count') int depositsCount,
      @JsonKey(name: 'lp_tokens_deposited') double lpTokensDeposited,
      @JsonKey(name: 'remaining_rewards')
      List<RemainingRewards> remainingRewards,
      double weight});
}

/// @nodoc
class _$StatsCopyWithImpl<$Res, $Val extends Stats>
    implements $StatsCopyWith<$Res> {
  _$StatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? depositsCount = null,
    Object? lpTokensDeposited = null,
    Object? remainingRewards = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      depositsCount: null == depositsCount
          ? _value.depositsCount
          : depositsCount // ignore: cast_nullable_to_non_nullable
              as int,
      lpTokensDeposited: null == lpTokensDeposited
          ? _value.lpTokensDeposited
          : lpTokensDeposited // ignore: cast_nullable_to_non_nullable
              as double,
      remainingRewards: null == remainingRewards
          ? _value.remainingRewards
          : remainingRewards // ignore: cast_nullable_to_non_nullable
              as List<RemainingRewards>,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatsImplCopyWith<$Res> implements $StatsCopyWith<$Res> {
  factory _$$StatsImplCopyWith(
          _$StatsImpl value, $Res Function(_$StatsImpl) then) =
      __$$StatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'deposits_count') int depositsCount,
      @JsonKey(name: 'lp_tokens_deposited') double lpTokensDeposited,
      @JsonKey(name: 'remaining_rewards')
      List<RemainingRewards> remainingRewards,
      double weight});
}

/// @nodoc
class __$$StatsImplCopyWithImpl<$Res>
    extends _$StatsCopyWithImpl<$Res, _$StatsImpl>
    implements _$$StatsImplCopyWith<$Res> {
  __$$StatsImplCopyWithImpl(
      _$StatsImpl _value, $Res Function(_$StatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? depositsCount = null,
    Object? lpTokensDeposited = null,
    Object? remainingRewards = null,
    Object? weight = null,
  }) {
    return _then(_$StatsImpl(
      depositsCount: null == depositsCount
          ? _value.depositsCount
          : depositsCount // ignore: cast_nullable_to_non_nullable
              as int,
      lpTokensDeposited: null == lpTokensDeposited
          ? _value.lpTokensDeposited
          : lpTokensDeposited // ignore: cast_nullable_to_non_nullable
              as double,
      remainingRewards: null == remainingRewards
          ? _value._remainingRewards
          : remainingRewards // ignore: cast_nullable_to_non_nullable
              as List<RemainingRewards>,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatsImpl implements _Stats {
  const _$StatsImpl(
      {@JsonKey(name: 'deposits_count') required this.depositsCount,
      @JsonKey(name: 'lp_tokens_deposited') required this.lpTokensDeposited,
      @JsonKey(name: 'remaining_rewards')
      required final List<RemainingRewards> remainingRewards,
      required this.weight})
      : _remainingRewards = remainingRewards;

  factory _$StatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatsImplFromJson(json);

  @override
  @JsonKey(name: 'deposits_count')
  final int depositsCount;
  @override
  @JsonKey(name: 'lp_tokens_deposited')
  final double lpTokensDeposited;
  final List<RemainingRewards> _remainingRewards;
  @override
  @JsonKey(name: 'remaining_rewards')
  List<RemainingRewards> get remainingRewards {
    if (_remainingRewards is EqualUnmodifiableListView)
      return _remainingRewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remainingRewards);
  }

  @override
  final double weight;

  @override
  String toString() {
    return 'Stats(depositsCount: $depositsCount, lpTokensDeposited: $lpTokensDeposited, remainingRewards: $remainingRewards, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsImpl &&
            (identical(other.depositsCount, depositsCount) ||
                other.depositsCount == depositsCount) &&
            (identical(other.lpTokensDeposited, lpTokensDeposited) ||
                other.lpTokensDeposited == lpTokensDeposited) &&
            const DeepCollectionEquality()
                .equals(other._remainingRewards, _remainingRewards) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, depositsCount, lpTokensDeposited,
      const DeepCollectionEquality().hash(_remainingRewards), weight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsImplCopyWith<_$StatsImpl> get copyWith =>
      __$$StatsImplCopyWithImpl<_$StatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatsImplToJson(
      this,
    );
  }
}

abstract class _Stats implements Stats {
  const factory _Stats(
      {@JsonKey(name: 'deposits_count') required final int depositsCount,
      @JsonKey(name: 'lp_tokens_deposited')
      required final double lpTokensDeposited,
      @JsonKey(name: 'remaining_rewards')
      required final List<RemainingRewards> remainingRewards,
      required final double weight}) = _$StatsImpl;

  factory _Stats.fromJson(Map<String, dynamic> json) = _$StatsImpl.fromJson;

  @override
  @JsonKey(name: 'deposits_count')
  int get depositsCount;
  @override
  @JsonKey(name: 'lp_tokens_deposited')
  double get lpTokensDeposited;
  @override
  @JsonKey(name: 'remaining_rewards')
  List<RemainingRewards> get remainingRewards;
  @override
  double get weight;
  @override
  @JsonKey(ignore: true)
  _$$StatsImplCopyWith<_$StatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RemainingRewards _$RemainingRewardsFromJson(Map<String, dynamic> json) {
  return _RemainingRewards.fromJson(json);
}

/// @nodoc
mixin _$RemainingRewards {
  @JsonKey(name: 'remaining_rewards')
  double get rewards => throw _privateConstructorUsedError;
  int get start => throw _privateConstructorUsedError;
  int get end => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RemainingRewardsCopyWith<RemainingRewards> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemainingRewardsCopyWith<$Res> {
  factory $RemainingRewardsCopyWith(
          RemainingRewards value, $Res Function(RemainingRewards) then) =
      _$RemainingRewardsCopyWithImpl<$Res, RemainingRewards>;
  @useResult
  $Res call(
      {@JsonKey(name: 'remaining_rewards') double rewards, int start, int end});
}

/// @nodoc
class _$RemainingRewardsCopyWithImpl<$Res, $Val extends RemainingRewards>
    implements $RemainingRewardsCopyWith<$Res> {
  _$RemainingRewardsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewards = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      rewards: null == rewards
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as double,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RemainingRewardsImplCopyWith<$Res>
    implements $RemainingRewardsCopyWith<$Res> {
  factory _$$RemainingRewardsImplCopyWith(_$RemainingRewardsImpl value,
          $Res Function(_$RemainingRewardsImpl) then) =
      __$$RemainingRewardsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'remaining_rewards') double rewards, int start, int end});
}

/// @nodoc
class __$$RemainingRewardsImplCopyWithImpl<$Res>
    extends _$RemainingRewardsCopyWithImpl<$Res, _$RemainingRewardsImpl>
    implements _$$RemainingRewardsImplCopyWith<$Res> {
  __$$RemainingRewardsImplCopyWithImpl(_$RemainingRewardsImpl _value,
      $Res Function(_$RemainingRewardsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewards = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$RemainingRewardsImpl(
      rewards: null == rewards
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as double,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemainingRewardsImpl implements _RemainingRewards {
  const _$RemainingRewardsImpl(
      {@JsonKey(name: 'remaining_rewards') required this.rewards,
      required this.start,
      required this.end});

  factory _$RemainingRewardsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemainingRewardsImplFromJson(json);

  @override
  @JsonKey(name: 'remaining_rewards')
  final double rewards;
  @override
  final int start;
  @override
  final int end;

  @override
  String toString() {
    return 'RemainingRewards(rewards: $rewards, start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemainingRewardsImpl &&
            (identical(other.rewards, rewards) || other.rewards == rewards) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rewards, start, end);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemainingRewardsImplCopyWith<_$RemainingRewardsImpl> get copyWith =>
      __$$RemainingRewardsImplCopyWithImpl<_$RemainingRewardsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemainingRewardsImplToJson(
      this,
    );
  }
}

abstract class _RemainingRewards implements RemainingRewards {
  const factory _RemainingRewards(
      {@JsonKey(name: 'remaining_rewards') required final double rewards,
      required final int start,
      required final int end}) = _$RemainingRewardsImpl;

  factory _RemainingRewards.fromJson(Map<String, dynamic> json) =
      _$RemainingRewardsImpl.fromJson;

  @override
  @JsonKey(name: 'remaining_rewards')
  double get rewards;
  @override
  int get start;
  @override
  int get end;
  @override
  @JsonKey(ignore: true)
  _$$RemainingRewardsImplCopyWith<_$RemainingRewardsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
