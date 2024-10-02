// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FarmLockFormBalances {
  double get token1Balance => throw _privateConstructorUsedError;
  double get token2Balance => throw _privateConstructorUsedError;
  double get lpTokenBalance => throw _privateConstructorUsedError;

  /// Create a copy of FarmLockFormBalances
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FarmLockFormBalancesCopyWith<FarmLockFormBalances> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmLockFormBalancesCopyWith<$Res> {
  factory $FarmLockFormBalancesCopyWith(FarmLockFormBalances value,
          $Res Function(FarmLockFormBalances) then) =
      _$FarmLockFormBalancesCopyWithImpl<$Res, FarmLockFormBalances>;
  @useResult
  $Res call(
      {double token1Balance, double token2Balance, double lpTokenBalance});
}

/// @nodoc
class _$FarmLockFormBalancesCopyWithImpl<$Res,
        $Val extends FarmLockFormBalances>
    implements $FarmLockFormBalancesCopyWith<$Res> {
  _$FarmLockFormBalancesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FarmLockFormBalances
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1Balance = null,
    Object? token2Balance = null,
    Object? lpTokenBalance = null,
  }) {
    return _then(_value.copyWith(
      token1Balance: null == token1Balance
          ? _value.token1Balance
          : token1Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token2Balance: null == token2Balance
          ? _value.token2Balance
          : token2Balance // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FarmLockFormBalancesImplCopyWith<$Res>
    implements $FarmLockFormBalancesCopyWith<$Res> {
  factory _$$FarmLockFormBalancesImplCopyWith(_$FarmLockFormBalancesImpl value,
          $Res Function(_$FarmLockFormBalancesImpl) then) =
      __$$FarmLockFormBalancesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double token1Balance, double token2Balance, double lpTokenBalance});
}

/// @nodoc
class __$$FarmLockFormBalancesImplCopyWithImpl<$Res>
    extends _$FarmLockFormBalancesCopyWithImpl<$Res, _$FarmLockFormBalancesImpl>
    implements _$$FarmLockFormBalancesImplCopyWith<$Res> {
  __$$FarmLockFormBalancesImplCopyWithImpl(_$FarmLockFormBalancesImpl _value,
      $Res Function(_$FarmLockFormBalancesImpl) _then)
      : super(_value, _then);

  /// Create a copy of FarmLockFormBalances
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1Balance = null,
    Object? token2Balance = null,
    Object? lpTokenBalance = null,
  }) {
    return _then(_$FarmLockFormBalancesImpl(
      token1Balance: null == token1Balance
          ? _value.token1Balance
          : token1Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token2Balance: null == token2Balance
          ? _value.token2Balance
          : token2Balance // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$FarmLockFormBalancesImpl extends _FarmLockFormBalances {
  const _$FarmLockFormBalancesImpl(
      {this.token1Balance = 0.0,
      this.token2Balance = 0.0,
      this.lpTokenBalance = 0.0})
      : super._();

  @override
  @JsonKey()
  final double token1Balance;
  @override
  @JsonKey()
  final double token2Balance;
  @override
  @JsonKey()
  final double lpTokenBalance;

  @override
  String toString() {
    return 'FarmLockFormBalances(token1Balance: $token1Balance, token2Balance: $token2Balance, lpTokenBalance: $lpTokenBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmLockFormBalancesImpl &&
            (identical(other.token1Balance, token1Balance) ||
                other.token1Balance == token1Balance) &&
            (identical(other.token2Balance, token2Balance) ||
                other.token2Balance == token2Balance) &&
            (identical(other.lpTokenBalance, lpTokenBalance) ||
                other.lpTokenBalance == lpTokenBalance));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, token1Balance, token2Balance, lpTokenBalance);

  /// Create a copy of FarmLockFormBalances
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmLockFormBalancesImplCopyWith<_$FarmLockFormBalancesImpl>
      get copyWith =>
          __$$FarmLockFormBalancesImplCopyWithImpl<_$FarmLockFormBalancesImpl>(
              this, _$identity);
}

abstract class _FarmLockFormBalances extends FarmLockFormBalances {
  const factory _FarmLockFormBalances(
      {final double token1Balance,
      final double token2Balance,
      final double lpTokenBalance}) = _$FarmLockFormBalancesImpl;
  const _FarmLockFormBalances._() : super._();

  @override
  double get token1Balance;
  @override
  double get token2Balance;
  @override
  double get lpTokenBalance;

  /// Create a copy of FarmLockFormBalances
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FarmLockFormBalancesImplCopyWith<_$FarmLockFormBalancesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FarmLockFormSummary {
  double get farmedTokensCapital => throw _privateConstructorUsedError;
  double get farmedTokensCapitalInFiat => throw _privateConstructorUsedError;
  double get farmedTokensRewards => throw _privateConstructorUsedError;
  double get farmedTokensRewardsInFiat => throw _privateConstructorUsedError;

  /// Create a copy of FarmLockFormSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FarmLockFormSummaryCopyWith<FarmLockFormSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmLockFormSummaryCopyWith<$Res> {
  factory $FarmLockFormSummaryCopyWith(
          FarmLockFormSummary value, $Res Function(FarmLockFormSummary) then) =
      _$FarmLockFormSummaryCopyWithImpl<$Res, FarmLockFormSummary>;
  @useResult
  $Res call(
      {double farmedTokensCapital,
      double farmedTokensCapitalInFiat,
      double farmedTokensRewards,
      double farmedTokensRewardsInFiat});
}

/// @nodoc
class _$FarmLockFormSummaryCopyWithImpl<$Res, $Val extends FarmLockFormSummary>
    implements $FarmLockFormSummaryCopyWith<$Res> {
  _$FarmLockFormSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FarmLockFormSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmedTokensCapital = null,
    Object? farmedTokensCapitalInFiat = null,
    Object? farmedTokensRewards = null,
    Object? farmedTokensRewardsInFiat = null,
  }) {
    return _then(_value.copyWith(
      farmedTokensCapital: null == farmedTokensCapital
          ? _value.farmedTokensCapital
          : farmedTokensCapital // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensCapitalInFiat: null == farmedTokensCapitalInFiat
          ? _value.farmedTokensCapitalInFiat
          : farmedTokensCapitalInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensRewards: null == farmedTokensRewards
          ? _value.farmedTokensRewards
          : farmedTokensRewards // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensRewardsInFiat: null == farmedTokensRewardsInFiat
          ? _value.farmedTokensRewardsInFiat
          : farmedTokensRewardsInFiat // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FarmLockFormSummaryImplCopyWith<$Res>
    implements $FarmLockFormSummaryCopyWith<$Res> {
  factory _$$FarmLockFormSummaryImplCopyWith(_$FarmLockFormSummaryImpl value,
          $Res Function(_$FarmLockFormSummaryImpl) then) =
      __$$FarmLockFormSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double farmedTokensCapital,
      double farmedTokensCapitalInFiat,
      double farmedTokensRewards,
      double farmedTokensRewardsInFiat});
}

/// @nodoc
class __$$FarmLockFormSummaryImplCopyWithImpl<$Res>
    extends _$FarmLockFormSummaryCopyWithImpl<$Res, _$FarmLockFormSummaryImpl>
    implements _$$FarmLockFormSummaryImplCopyWith<$Res> {
  __$$FarmLockFormSummaryImplCopyWithImpl(_$FarmLockFormSummaryImpl _value,
      $Res Function(_$FarmLockFormSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of FarmLockFormSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? farmedTokensCapital = null,
    Object? farmedTokensCapitalInFiat = null,
    Object? farmedTokensRewards = null,
    Object? farmedTokensRewardsInFiat = null,
  }) {
    return _then(_$FarmLockFormSummaryImpl(
      farmedTokensCapital: null == farmedTokensCapital
          ? _value.farmedTokensCapital
          : farmedTokensCapital // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensCapitalInFiat: null == farmedTokensCapitalInFiat
          ? _value.farmedTokensCapitalInFiat
          : farmedTokensCapitalInFiat // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensRewards: null == farmedTokensRewards
          ? _value.farmedTokensRewards
          : farmedTokensRewards // ignore: cast_nullable_to_non_nullable
              as double,
      farmedTokensRewardsInFiat: null == farmedTokensRewardsInFiat
          ? _value.farmedTokensRewardsInFiat
          : farmedTokensRewardsInFiat // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$FarmLockFormSummaryImpl extends _FarmLockFormSummary {
  const _$FarmLockFormSummaryImpl(
      {this.farmedTokensCapital = 0.0,
      this.farmedTokensCapitalInFiat = 0.0,
      this.farmedTokensRewards = 0.0,
      this.farmedTokensRewardsInFiat = 0.0})
      : super._();

  @override
  @JsonKey()
  final double farmedTokensCapital;
  @override
  @JsonKey()
  final double farmedTokensCapitalInFiat;
  @override
  @JsonKey()
  final double farmedTokensRewards;
  @override
  @JsonKey()
  final double farmedTokensRewardsInFiat;

  @override
  String toString() {
    return 'FarmLockFormSummary(farmedTokensCapital: $farmedTokensCapital, farmedTokensCapitalInFiat: $farmedTokensCapitalInFiat, farmedTokensRewards: $farmedTokensRewards, farmedTokensRewardsInFiat: $farmedTokensRewardsInFiat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmLockFormSummaryImpl &&
            (identical(other.farmedTokensCapital, farmedTokensCapital) ||
                other.farmedTokensCapital == farmedTokensCapital) &&
            (identical(other.farmedTokensCapitalInFiat,
                    farmedTokensCapitalInFiat) ||
                other.farmedTokensCapitalInFiat == farmedTokensCapitalInFiat) &&
            (identical(other.farmedTokensRewards, farmedTokensRewards) ||
                other.farmedTokensRewards == farmedTokensRewards) &&
            (identical(other.farmedTokensRewardsInFiat,
                    farmedTokensRewardsInFiat) ||
                other.farmedTokensRewardsInFiat == farmedTokensRewardsInFiat));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      farmedTokensCapital,
      farmedTokensCapitalInFiat,
      farmedTokensRewards,
      farmedTokensRewardsInFiat);

  /// Create a copy of FarmLockFormSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmLockFormSummaryImplCopyWith<_$FarmLockFormSummaryImpl> get copyWith =>
      __$$FarmLockFormSummaryImplCopyWithImpl<_$FarmLockFormSummaryImpl>(
          this, _$identity);
}

abstract class _FarmLockFormSummary extends FarmLockFormSummary {
  const factory _FarmLockFormSummary(
      {final double farmedTokensCapital,
      final double farmedTokensCapitalInFiat,
      final double farmedTokensRewards,
      final double farmedTokensRewardsInFiat}) = _$FarmLockFormSummaryImpl;
  const _FarmLockFormSummary._() : super._();

  @override
  double get farmedTokensCapital;
  @override
  double get farmedTokensCapitalInFiat;
  @override
  double get farmedTokensRewards;
  @override
  double get farmedTokensRewardsInFiat;

  /// Create a copy of FarmLockFormSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FarmLockFormSummaryImplCopyWith<_$FarmLockFormSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
