// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_farm_lock_user_infos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexFarmLockUserInfos _$DexFarmLockUserInfosFromJson(Map<String, dynamic> json) {
  return _DexFarmLockUserInfos.fromJson(json);
}

/// @nodoc
mixin _$DexFarmLockUserInfos {
  String get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get rewardAmount => throw _privateConstructorUsedError;
  int? get start => throw _privateConstructorUsedError;
  int? get end => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  double get apr => throw _privateConstructorUsedError;

  /// Serializes this DexFarmLockUserInfos to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DexFarmLockUserInfos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DexFarmLockUserInfosCopyWith<DexFarmLockUserInfos> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexFarmLockUserInfosCopyWith<$Res> {
  factory $DexFarmLockUserInfosCopyWith(DexFarmLockUserInfos value,
          $Res Function(DexFarmLockUserInfos) then) =
      _$DexFarmLockUserInfosCopyWithImpl<$Res, DexFarmLockUserInfos>;
  @useResult
  $Res call(
      {String id,
      double amount,
      double rewardAmount,
      int? start,
      int? end,
      String level,
      double apr});
}

/// @nodoc
class _$DexFarmLockUserInfosCopyWithImpl<$Res,
        $Val extends DexFarmLockUserInfos>
    implements $DexFarmLockUserInfosCopyWith<$Res> {
  _$DexFarmLockUserInfosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DexFarmLockUserInfos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? rewardAmount = null,
    Object? start = freezed,
    Object? end = freezed,
    Object? level = null,
    Object? apr = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      rewardAmount: null == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      apr: null == apr
          ? _value.apr
          : apr // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexFarmLockUserInfosImplCopyWith<$Res>
    implements $DexFarmLockUserInfosCopyWith<$Res> {
  factory _$$DexFarmLockUserInfosImplCopyWith(_$DexFarmLockUserInfosImpl value,
          $Res Function(_$DexFarmLockUserInfosImpl) then) =
      __$$DexFarmLockUserInfosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double amount,
      double rewardAmount,
      int? start,
      int? end,
      String level,
      double apr});
}

/// @nodoc
class __$$DexFarmLockUserInfosImplCopyWithImpl<$Res>
    extends _$DexFarmLockUserInfosCopyWithImpl<$Res, _$DexFarmLockUserInfosImpl>
    implements _$$DexFarmLockUserInfosImplCopyWith<$Res> {
  __$$DexFarmLockUserInfosImplCopyWithImpl(_$DexFarmLockUserInfosImpl _value,
      $Res Function(_$DexFarmLockUserInfosImpl) _then)
      : super(_value, _then);

  /// Create a copy of DexFarmLockUserInfos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? rewardAmount = null,
    Object? start = freezed,
    Object? end = freezed,
    Object? level = null,
    Object? apr = null,
  }) {
    return _then(_$DexFarmLockUserInfosImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      rewardAmount: null == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      apr: null == apr
          ? _value.apr
          : apr // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexFarmLockUserInfosImpl extends _DexFarmLockUserInfos {
  const _$DexFarmLockUserInfosImpl(
      {this.id = '',
      this.amount = 0.0,
      this.rewardAmount = 0.0,
      this.start,
      this.end,
      this.level = '',
      this.apr = 0.0})
      : super._();

  factory _$DexFarmLockUserInfosImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexFarmLockUserInfosImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final double amount;
  @override
  @JsonKey()
  final double rewardAmount;
  @override
  final int? start;
  @override
  final int? end;
  @override
  @JsonKey()
  final String level;
  @override
  @JsonKey()
  final double apr;

  @override
  String toString() {
    return 'DexFarmLockUserInfos(id: $id, amount: $amount, rewardAmount: $rewardAmount, start: $start, end: $end, level: $level, apr: $apr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexFarmLockUserInfosImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.apr, apr) || other.apr == apr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, amount, rewardAmount, start, end, level, apr);

  /// Create a copy of DexFarmLockUserInfos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DexFarmLockUserInfosImplCopyWith<_$DexFarmLockUserInfosImpl>
      get copyWith =>
          __$$DexFarmLockUserInfosImplCopyWithImpl<_$DexFarmLockUserInfosImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexFarmLockUserInfosImplToJson(
      this,
    );
  }
}

abstract class _DexFarmLockUserInfos extends DexFarmLockUserInfos {
  const factory _DexFarmLockUserInfos(
      {final String id,
      final double amount,
      final double rewardAmount,
      final int? start,
      final int? end,
      final String level,
      final double apr}) = _$DexFarmLockUserInfosImpl;
  const _DexFarmLockUserInfos._() : super._();

  factory _DexFarmLockUserInfos.fromJson(Map<String, dynamic> json) =
      _$DexFarmLockUserInfosImpl.fromJson;

  @override
  String get id;
  @override
  double get amount;
  @override
  double get rewardAmount;
  @override
  int? get start;
  @override
  int? get end;
  @override
  String get level;
  @override
  double get apr;

  /// Create a copy of DexFarmLockUserInfos
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DexFarmLockUserInfosImplCopyWith<_$DexFarmLockUserInfosImpl>
      get copyWith => throw _privateConstructorUsedError;
}
