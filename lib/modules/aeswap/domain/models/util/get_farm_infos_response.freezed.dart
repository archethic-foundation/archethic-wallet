// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_farm_infos_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetFarmInfosResponse _$GetFarmInfosResponseFromJson(Map<String, dynamic> json) {
  return _GetFarmInfosResponse.fromJson(json);
}

/// @nodoc
mixin _$GetFarmInfosResponse {
  @JsonKey(name: 'lp_token_address')
  String get lpTokenAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'reward_token')
  String get rewardToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  int get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  int get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_reward')
  double? get remainingReward => throw _privateConstructorUsedError;
  @JsonKey(name: 'lp_token_deposited')
  double get lpTokenDeposited => throw _privateConstructorUsedError;
  @JsonKey(name: 'nb_deposit')
  int get nbDeposit => throw _privateConstructorUsedError;
  Stats get stats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetFarmInfosResponseCopyWith<GetFarmInfosResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetFarmInfosResponseCopyWith<$Res> {
  factory $GetFarmInfosResponseCopyWith(GetFarmInfosResponse value,
          $Res Function(GetFarmInfosResponse) then) =
      _$GetFarmInfosResponseCopyWithImpl<$Res, GetFarmInfosResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'lp_token_address') String lpTokenAddress,
      @JsonKey(name: 'reward_token') String rewardToken,
      @JsonKey(name: 'start_date') int startDate,
      @JsonKey(name: 'end_date') int endDate,
      @JsonKey(name: 'remaining_reward') double? remainingReward,
      @JsonKey(name: 'lp_token_deposited') double lpTokenDeposited,
      @JsonKey(name: 'nb_deposit') int nbDeposit,
      Stats stats});

  $StatsCopyWith<$Res> get stats;
}

/// @nodoc
class _$GetFarmInfosResponseCopyWithImpl<$Res,
        $Val extends GetFarmInfosResponse>
    implements $GetFarmInfosResponseCopyWith<$Res> {
  _$GetFarmInfosResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lpTokenAddress = null,
    Object? rewardToken = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? remainingReward = freezed,
    Object? lpTokenDeposited = null,
    Object? nbDeposit = null,
    Object? stats = null,
  }) {
    return _then(_value.copyWith(
      lpTokenAddress: null == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      rewardToken: null == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as int,
      remainingReward: freezed == remainingReward
          ? _value.remainingReward
          : remainingReward // ignore: cast_nullable_to_non_nullable
              as double?,
      lpTokenDeposited: null == lpTokenDeposited
          ? _value.lpTokenDeposited
          : lpTokenDeposited // ignore: cast_nullable_to_non_nullable
              as double,
      nbDeposit: null == nbDeposit
          ? _value.nbDeposit
          : nbDeposit // ignore: cast_nullable_to_non_nullable
              as int,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Stats,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StatsCopyWith<$Res> get stats {
    return $StatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetFarmInfosResponseImplCopyWith<$Res>
    implements $GetFarmInfosResponseCopyWith<$Res> {
  factory _$$GetFarmInfosResponseImplCopyWith(_$GetFarmInfosResponseImpl value,
          $Res Function(_$GetFarmInfosResponseImpl) then) =
      __$$GetFarmInfosResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'lp_token_address') String lpTokenAddress,
      @JsonKey(name: 'reward_token') String rewardToken,
      @JsonKey(name: 'start_date') int startDate,
      @JsonKey(name: 'end_date') int endDate,
      @JsonKey(name: 'remaining_reward') double? remainingReward,
      @JsonKey(name: 'lp_token_deposited') double lpTokenDeposited,
      @JsonKey(name: 'nb_deposit') int nbDeposit,
      Stats stats});

  @override
  $StatsCopyWith<$Res> get stats;
}

/// @nodoc
class __$$GetFarmInfosResponseImplCopyWithImpl<$Res>
    extends _$GetFarmInfosResponseCopyWithImpl<$Res, _$GetFarmInfosResponseImpl>
    implements _$$GetFarmInfosResponseImplCopyWith<$Res> {
  __$$GetFarmInfosResponseImplCopyWithImpl(_$GetFarmInfosResponseImpl _value,
      $Res Function(_$GetFarmInfosResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lpTokenAddress = null,
    Object? rewardToken = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? remainingReward = freezed,
    Object? lpTokenDeposited = null,
    Object? nbDeposit = null,
    Object? stats = null,
  }) {
    return _then(_$GetFarmInfosResponseImpl(
      lpTokenAddress: null == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      rewardToken: null == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as int,
      remainingReward: freezed == remainingReward
          ? _value.remainingReward
          : remainingReward // ignore: cast_nullable_to_non_nullable
              as double?,
      lpTokenDeposited: null == lpTokenDeposited
          ? _value.lpTokenDeposited
          : lpTokenDeposited // ignore: cast_nullable_to_non_nullable
              as double,
      nbDeposit: null == nbDeposit
          ? _value.nbDeposit
          : nbDeposit // ignore: cast_nullable_to_non_nullable
              as int,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Stats,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetFarmInfosResponseImpl implements _GetFarmInfosResponse {
  const _$GetFarmInfosResponseImpl(
      {@JsonKey(name: 'lp_token_address') required this.lpTokenAddress,
      @JsonKey(name: 'reward_token') required this.rewardToken,
      @JsonKey(name: 'start_date') required this.startDate,
      @JsonKey(name: 'end_date') required this.endDate,
      @JsonKey(name: 'remaining_reward') this.remainingReward,
      @JsonKey(name: 'lp_token_deposited') required this.lpTokenDeposited,
      @JsonKey(name: 'nb_deposit') required this.nbDeposit,
      required this.stats});

  factory _$GetFarmInfosResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetFarmInfosResponseImplFromJson(json);

  @override
  @JsonKey(name: 'lp_token_address')
  final String lpTokenAddress;
  @override
  @JsonKey(name: 'reward_token')
  final String rewardToken;
  @override
  @JsonKey(name: 'start_date')
  final int startDate;
  @override
  @JsonKey(name: 'end_date')
  final int endDate;
  @override
  @JsonKey(name: 'remaining_reward')
  final double? remainingReward;
  @override
  @JsonKey(name: 'lp_token_deposited')
  final double lpTokenDeposited;
  @override
  @JsonKey(name: 'nb_deposit')
  final int nbDeposit;
  @override
  final Stats stats;

  @override
  String toString() {
    return 'GetFarmInfosResponse(lpTokenAddress: $lpTokenAddress, rewardToken: $rewardToken, startDate: $startDate, endDate: $endDate, remainingReward: $remainingReward, lpTokenDeposited: $lpTokenDeposited, nbDeposit: $nbDeposit, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetFarmInfosResponseImpl &&
            (identical(other.lpTokenAddress, lpTokenAddress) ||
                other.lpTokenAddress == lpTokenAddress) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.remainingReward, remainingReward) ||
                other.remainingReward == remainingReward) &&
            (identical(other.lpTokenDeposited, lpTokenDeposited) ||
                other.lpTokenDeposited == lpTokenDeposited) &&
            (identical(other.nbDeposit, nbDeposit) ||
                other.nbDeposit == nbDeposit) &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lpTokenAddress, rewardToken,
      startDate, endDate, remainingReward, lpTokenDeposited, nbDeposit, stats);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetFarmInfosResponseImplCopyWith<_$GetFarmInfosResponseImpl>
      get copyWith =>
          __$$GetFarmInfosResponseImplCopyWithImpl<_$GetFarmInfosResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetFarmInfosResponseImplToJson(
      this,
    );
  }
}

abstract class _GetFarmInfosResponse implements GetFarmInfosResponse {
  const factory _GetFarmInfosResponse(
      {@JsonKey(name: 'lp_token_address') required final String lpTokenAddress,
      @JsonKey(name: 'reward_token') required final String rewardToken,
      @JsonKey(name: 'start_date') required final int startDate,
      @JsonKey(name: 'end_date') required final int endDate,
      @JsonKey(name: 'remaining_reward') final double? remainingReward,
      @JsonKey(name: 'lp_token_deposited')
      required final double lpTokenDeposited,
      @JsonKey(name: 'nb_deposit') required final int nbDeposit,
      required final Stats stats}) = _$GetFarmInfosResponseImpl;

  factory _GetFarmInfosResponse.fromJson(Map<String, dynamic> json) =
      _$GetFarmInfosResponseImpl.fromJson;

  @override
  @JsonKey(name: 'lp_token_address')
  String get lpTokenAddress;
  @override
  @JsonKey(name: 'reward_token')
  String get rewardToken;
  @override
  @JsonKey(name: 'start_date')
  int get startDate;
  @override
  @JsonKey(name: 'end_date')
  int get endDate;
  @override
  @JsonKey(name: 'remaining_reward')
  double? get remainingReward;
  @override
  @JsonKey(name: 'lp_token_deposited')
  double get lpTokenDeposited;
  @override
  @JsonKey(name: 'nb_deposit')
  int get nbDeposit;
  @override
  Stats get stats;
  @override
  @JsonKey(ignore: true)
  _$$GetFarmInfosResponseImplCopyWith<_$GetFarmInfosResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Stats _$StatsFromJson(Map<String, dynamic> json) {
  return _Stats.fromJson(json);
}

/// @nodoc
mixin _$Stats {
  @JsonKey(name: 'reward_distributed')
  double get rewardDistributed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatsCopyWith<Stats> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsCopyWith<$Res> {
  factory $StatsCopyWith(Stats value, $Res Function(Stats) then) =
      _$StatsCopyWithImpl<$Res, Stats>;
  @useResult
  $Res call({@JsonKey(name: 'reward_distributed') double rewardDistributed});
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
    Object? rewardDistributed = null,
  }) {
    return _then(_value.copyWith(
      rewardDistributed: null == rewardDistributed
          ? _value.rewardDistributed
          : rewardDistributed // ignore: cast_nullable_to_non_nullable
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
  $Res call({@JsonKey(name: 'reward_distributed') double rewardDistributed});
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
    Object? rewardDistributed = null,
  }) {
    return _then(_$StatsImpl(
      rewardDistributed: null == rewardDistributed
          ? _value.rewardDistributed
          : rewardDistributed // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatsImpl implements _Stats {
  const _$StatsImpl(
      {@JsonKey(name: 'reward_distributed') required this.rewardDistributed});

  factory _$StatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatsImplFromJson(json);

  @override
  @JsonKey(name: 'reward_distributed')
  final double rewardDistributed;

  @override
  String toString() {
    return 'Stats(rewardDistributed: $rewardDistributed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsImpl &&
            (identical(other.rewardDistributed, rewardDistributed) ||
                other.rewardDistributed == rewardDistributed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rewardDistributed);

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
      {@JsonKey(name: 'reward_distributed')
      required final double rewardDistributed}) = _$StatsImpl;

  factory _Stats.fromJson(Map<String, dynamic> json) = _$StatsImpl.fromJson;

  @override
  @JsonKey(name: 'reward_distributed')
  double get rewardDistributed;
  @override
  @JsonKey(ignore: true)
  _$$StatsImplCopyWith<_$StatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
