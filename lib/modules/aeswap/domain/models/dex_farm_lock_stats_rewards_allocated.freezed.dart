// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_farm_lock_stats_rewards_allocated.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexFarmLockStatsRemainingRewards _$DexFarmLockStatsRemainingRewardsFromJson(
    Map<String, dynamic> json) {
  return _DexFarmLockStatsRemainingRewards.fromJson(json);
}

/// @nodoc
mixin _$DexFarmLockStatsRemainingRewards {
  double get rewardsAllocated => throw _privateConstructorUsedError;
  int get startPeriod => throw _privateConstructorUsedError;
  int get endPeriod => throw _privateConstructorUsedError;

  /// Serializes this DexFarmLockStatsRemainingRewards to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DexFarmLockStatsRemainingRewards
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DexFarmLockStatsRemainingRewardsCopyWith<DexFarmLockStatsRemainingRewards>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexFarmLockStatsRemainingRewardsCopyWith<$Res> {
  factory $DexFarmLockStatsRemainingRewardsCopyWith(
          DexFarmLockStatsRemainingRewards value,
          $Res Function(DexFarmLockStatsRemainingRewards) then) =
      _$DexFarmLockStatsRemainingRewardsCopyWithImpl<$Res,
          DexFarmLockStatsRemainingRewards>;
  @useResult
  $Res call({double rewardsAllocated, int startPeriod, int endPeriod});
}

/// @nodoc
class _$DexFarmLockStatsRemainingRewardsCopyWithImpl<$Res,
        $Val extends DexFarmLockStatsRemainingRewards>
    implements $DexFarmLockStatsRemainingRewardsCopyWith<$Res> {
  _$DexFarmLockStatsRemainingRewardsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DexFarmLockStatsRemainingRewards
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardsAllocated = null,
    Object? startPeriod = null,
    Object? endPeriod = null,
  }) {
    return _then(_value.copyWith(
      rewardsAllocated: null == rewardsAllocated
          ? _value.rewardsAllocated
          : rewardsAllocated // ignore: cast_nullable_to_non_nullable
              as double,
      startPeriod: null == startPeriod
          ? _value.startPeriod
          : startPeriod // ignore: cast_nullable_to_non_nullable
              as int,
      endPeriod: null == endPeriod
          ? _value.endPeriod
          : endPeriod // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexFarmLockStatsRemainingRewardsImplCopyWith<$Res>
    implements $DexFarmLockStatsRemainingRewardsCopyWith<$Res> {
  factory _$$DexFarmLockStatsRemainingRewardsImplCopyWith(
          _$DexFarmLockStatsRemainingRewardsImpl value,
          $Res Function(_$DexFarmLockStatsRemainingRewardsImpl) then) =
      __$$DexFarmLockStatsRemainingRewardsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double rewardsAllocated, int startPeriod, int endPeriod});
}

/// @nodoc
class __$$DexFarmLockStatsRemainingRewardsImplCopyWithImpl<$Res>
    extends _$DexFarmLockStatsRemainingRewardsCopyWithImpl<$Res,
        _$DexFarmLockStatsRemainingRewardsImpl>
    implements _$$DexFarmLockStatsRemainingRewardsImplCopyWith<$Res> {
  __$$DexFarmLockStatsRemainingRewardsImplCopyWithImpl(
      _$DexFarmLockStatsRemainingRewardsImpl _value,
      $Res Function(_$DexFarmLockStatsRemainingRewardsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DexFarmLockStatsRemainingRewards
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardsAllocated = null,
    Object? startPeriod = null,
    Object? endPeriod = null,
  }) {
    return _then(_$DexFarmLockStatsRemainingRewardsImpl(
      rewardsAllocated: null == rewardsAllocated
          ? _value.rewardsAllocated
          : rewardsAllocated // ignore: cast_nullable_to_non_nullable
              as double,
      startPeriod: null == startPeriod
          ? _value.startPeriod
          : startPeriod // ignore: cast_nullable_to_non_nullable
              as int,
      endPeriod: null == endPeriod
          ? _value.endPeriod
          : endPeriod // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexFarmLockStatsRemainingRewardsImpl
    extends _DexFarmLockStatsRemainingRewards {
  const _$DexFarmLockStatsRemainingRewardsImpl(
      {this.rewardsAllocated = 0.0, this.startPeriod = 0, this.endPeriod = 0})
      : super._();

  factory _$DexFarmLockStatsRemainingRewardsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DexFarmLockStatsRemainingRewardsImplFromJson(json);

  @override
  @JsonKey()
  final double rewardsAllocated;
  @override
  @JsonKey()
  final int startPeriod;
  @override
  @JsonKey()
  final int endPeriod;

  @override
  String toString() {
    return 'DexFarmLockStatsRemainingRewards(rewardsAllocated: $rewardsAllocated, startPeriod: $startPeriod, endPeriod: $endPeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexFarmLockStatsRemainingRewardsImpl &&
            (identical(other.rewardsAllocated, rewardsAllocated) ||
                other.rewardsAllocated == rewardsAllocated) &&
            (identical(other.startPeriod, startPeriod) ||
                other.startPeriod == startPeriod) &&
            (identical(other.endPeriod, endPeriod) ||
                other.endPeriod == endPeriod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, rewardsAllocated, startPeriod, endPeriod);

  /// Create a copy of DexFarmLockStatsRemainingRewards
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DexFarmLockStatsRemainingRewardsImplCopyWith<
          _$DexFarmLockStatsRemainingRewardsImpl>
      get copyWith => __$$DexFarmLockStatsRemainingRewardsImplCopyWithImpl<
          _$DexFarmLockStatsRemainingRewardsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexFarmLockStatsRemainingRewardsImplToJson(
      this,
    );
  }
}

abstract class _DexFarmLockStatsRemainingRewards
    extends DexFarmLockStatsRemainingRewards {
  const factory _DexFarmLockStatsRemainingRewards(
      {final double rewardsAllocated,
      final int startPeriod,
      final int endPeriod}) = _$DexFarmLockStatsRemainingRewardsImpl;
  const _DexFarmLockStatsRemainingRewards._() : super._();

  factory _DexFarmLockStatsRemainingRewards.fromJson(
          Map<String, dynamic> json) =
      _$DexFarmLockStatsRemainingRewardsImpl.fromJson;

  @override
  double get rewardsAllocated;
  @override
  int get startPeriod;
  @override
  int get endPeriod;

  /// Create a copy of DexFarmLockStatsRemainingRewards
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DexFarmLockStatsRemainingRewardsImplCopyWith<
          _$DexFarmLockStatsRemainingRewardsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
