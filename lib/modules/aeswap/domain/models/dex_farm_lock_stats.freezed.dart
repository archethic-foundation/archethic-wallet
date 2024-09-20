// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_farm_lock_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexFarmLockStats _$DexFarmLockStatsFromJson(Map<String, dynamic> json) {
  return _DexFarmLockStats.fromJson(json);
}

/// @nodoc
mixin _$DexFarmLockStats {
  int get depositsCount => throw _privateConstructorUsedError;
  double get lpTokensDeposited => throw _privateConstructorUsedError;
  List<DexFarmLockStatsRemainingRewards> get remainingRewards =>
      throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  double get aprEstimation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DexFarmLockStatsCopyWith<DexFarmLockStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexFarmLockStatsCopyWith<$Res> {
  factory $DexFarmLockStatsCopyWith(
          DexFarmLockStats value, $Res Function(DexFarmLockStats) then) =
      _$DexFarmLockStatsCopyWithImpl<$Res, DexFarmLockStats>;
  @useResult
  $Res call(
      {int depositsCount,
      double lpTokensDeposited,
      List<DexFarmLockStatsRemainingRewards> remainingRewards,
      double weight,
      double aprEstimation});
}

/// @nodoc
class _$DexFarmLockStatsCopyWithImpl<$Res, $Val extends DexFarmLockStats>
    implements $DexFarmLockStatsCopyWith<$Res> {
  _$DexFarmLockStatsCopyWithImpl(this._value, this._then);

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
    Object? aprEstimation = null,
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
              as List<DexFarmLockStatsRemainingRewards>,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      aprEstimation: null == aprEstimation
          ? _value.aprEstimation
          : aprEstimation // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexFarmLockStatsImplCopyWith<$Res>
    implements $DexFarmLockStatsCopyWith<$Res> {
  factory _$$DexFarmLockStatsImplCopyWith(_$DexFarmLockStatsImpl value,
          $Res Function(_$DexFarmLockStatsImpl) then) =
      __$$DexFarmLockStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int depositsCount,
      double lpTokensDeposited,
      List<DexFarmLockStatsRemainingRewards> remainingRewards,
      double weight,
      double aprEstimation});
}

/// @nodoc
class __$$DexFarmLockStatsImplCopyWithImpl<$Res>
    extends _$DexFarmLockStatsCopyWithImpl<$Res, _$DexFarmLockStatsImpl>
    implements _$$DexFarmLockStatsImplCopyWith<$Res> {
  __$$DexFarmLockStatsImplCopyWithImpl(_$DexFarmLockStatsImpl _value,
      $Res Function(_$DexFarmLockStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? depositsCount = null,
    Object? lpTokensDeposited = null,
    Object? remainingRewards = null,
    Object? weight = null,
    Object? aprEstimation = null,
  }) {
    return _then(_$DexFarmLockStatsImpl(
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
              as List<DexFarmLockStatsRemainingRewards>,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      aprEstimation: null == aprEstimation
          ? _value.aprEstimation
          : aprEstimation // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexFarmLockStatsImpl extends _DexFarmLockStats {
  const _$DexFarmLockStatsImpl(
      {this.depositsCount = 0,
      this.lpTokensDeposited = 0.0,
      final List<DexFarmLockStatsRemainingRewards> remainingRewards = const [],
      this.weight = 0.0,
      this.aprEstimation = 0.0})
      : _remainingRewards = remainingRewards,
        super._();

  factory _$DexFarmLockStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexFarmLockStatsImplFromJson(json);

  @override
  @JsonKey()
  final int depositsCount;
  @override
  @JsonKey()
  final double lpTokensDeposited;
  final List<DexFarmLockStatsRemainingRewards> _remainingRewards;
  @override
  @JsonKey()
  List<DexFarmLockStatsRemainingRewards> get remainingRewards {
    if (_remainingRewards is EqualUnmodifiableListView)
      return _remainingRewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remainingRewards);
  }

  @override
  @JsonKey()
  final double weight;
  @override
  @JsonKey()
  final double aprEstimation;

  @override
  String toString() {
    return 'DexFarmLockStats(depositsCount: $depositsCount, lpTokensDeposited: $lpTokensDeposited, remainingRewards: $remainingRewards, weight: $weight, aprEstimation: $aprEstimation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexFarmLockStatsImpl &&
            (identical(other.depositsCount, depositsCount) ||
                other.depositsCount == depositsCount) &&
            (identical(other.lpTokensDeposited, lpTokensDeposited) ||
                other.lpTokensDeposited == lpTokensDeposited) &&
            const DeepCollectionEquality()
                .equals(other._remainingRewards, _remainingRewards) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.aprEstimation, aprEstimation) ||
                other.aprEstimation == aprEstimation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      depositsCount,
      lpTokensDeposited,
      const DeepCollectionEquality().hash(_remainingRewards),
      weight,
      aprEstimation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexFarmLockStatsImplCopyWith<_$DexFarmLockStatsImpl> get copyWith =>
      __$$DexFarmLockStatsImplCopyWithImpl<_$DexFarmLockStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexFarmLockStatsImplToJson(
      this,
    );
  }
}

abstract class _DexFarmLockStats extends DexFarmLockStats {
  const factory _DexFarmLockStats(
      {final int depositsCount,
      final double lpTokensDeposited,
      final List<DexFarmLockStatsRemainingRewards> remainingRewards,
      final double weight,
      final double aprEstimation}) = _$DexFarmLockStatsImpl;
  const _DexFarmLockStats._() : super._();

  factory _DexFarmLockStats.fromJson(Map<String, dynamic> json) =
      _$DexFarmLockStatsImpl.fromJson;

  @override
  int get depositsCount;
  @override
  double get lpTokensDeposited;
  @override
  List<DexFarmLockStatsRemainingRewards> get remainingRewards;
  @override
  double get weight;
  @override
  double get aprEstimation;
  @override
  @JsonKey(ignore: true)
  _$$DexFarmLockStatsImplCopyWith<_$DexFarmLockStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
