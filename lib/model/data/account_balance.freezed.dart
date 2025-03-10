// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AccountBalance _$AccountBalanceFromJson(Map<String, dynamic> json) {
  return _AccountBalance.fromJson(json);
}

/// @nodoc
mixin _$AccountBalance {
// @HiveField(0) required double nativeTokenValue,
// @HiveField(1) required String nativeTokenName,
  @HiveField(5, defaultValue: 0)
  int get tokensFungiblesNb => throw _privateConstructorUsedError;
  @HiveField(6, defaultValue: 0)
  int get nftNb => throw _privateConstructorUsedError;
  @HiveField(7, defaultValue: 0)
  double get totalUSD => throw _privateConstructorUsedError;

  /// Serializes this AccountBalance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountBalanceCopyWith<AccountBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountBalanceCopyWith<$Res> {
  factory $AccountBalanceCopyWith(
          AccountBalance value, $Res Function(AccountBalance) then) =
      _$AccountBalanceCopyWithImpl<$Res, AccountBalance>;
  @useResult
  $Res call(
      {@HiveField(5, defaultValue: 0) int tokensFungiblesNb,
      @HiveField(6, defaultValue: 0) int nftNb,
      @HiveField(7, defaultValue: 0) double totalUSD});
}

/// @nodoc
class _$AccountBalanceCopyWithImpl<$Res, $Val extends AccountBalance>
    implements $AccountBalanceCopyWith<$Res> {
  _$AccountBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokensFungiblesNb = null,
    Object? nftNb = null,
    Object? totalUSD = null,
  }) {
    return _then(_value.copyWith(
      tokensFungiblesNb: null == tokensFungiblesNb
          ? _value.tokensFungiblesNb
          : tokensFungiblesNb // ignore: cast_nullable_to_non_nullable
              as int,
      nftNb: null == nftNb
          ? _value.nftNb
          : nftNb // ignore: cast_nullable_to_non_nullable
              as int,
      totalUSD: null == totalUSD
          ? _value.totalUSD
          : totalUSD // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountBalanceImplCopyWith<$Res>
    implements $AccountBalanceCopyWith<$Res> {
  factory _$$AccountBalanceImplCopyWith(_$AccountBalanceImpl value,
          $Res Function(_$AccountBalanceImpl) then) =
      __$$AccountBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(5, defaultValue: 0) int tokensFungiblesNb,
      @HiveField(6, defaultValue: 0) int nftNb,
      @HiveField(7, defaultValue: 0) double totalUSD});
}

/// @nodoc
class __$$AccountBalanceImplCopyWithImpl<$Res>
    extends _$AccountBalanceCopyWithImpl<$Res, _$AccountBalanceImpl>
    implements _$$AccountBalanceImplCopyWith<$Res> {
  __$$AccountBalanceImplCopyWithImpl(
      _$AccountBalanceImpl _value, $Res Function(_$AccountBalanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokensFungiblesNb = null,
    Object? nftNb = null,
    Object? totalUSD = null,
  }) {
    return _then(_$AccountBalanceImpl(
      tokensFungiblesNb: null == tokensFungiblesNb
          ? _value.tokensFungiblesNb
          : tokensFungiblesNb // ignore: cast_nullable_to_non_nullable
              as int,
      nftNb: null == nftNb
          ? _value.nftNb
          : nftNb // ignore: cast_nullable_to_non_nullable
              as int,
      totalUSD: null == totalUSD
          ? _value.totalUSD
          : totalUSD // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: HiveTypeIds.accountBalance)
class _$AccountBalanceImpl implements _AccountBalance {
  _$AccountBalanceImpl(
      {@HiveField(5, defaultValue: 0) this.tokensFungiblesNb = 0,
      @HiveField(6, defaultValue: 0) this.nftNb = 0,
      @HiveField(7, defaultValue: 0) this.totalUSD = 0});

  factory _$AccountBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountBalanceImplFromJson(json);

// @HiveField(0) required double nativeTokenValue,
// @HiveField(1) required String nativeTokenName,
  @override
  @JsonKey()
  @HiveField(5, defaultValue: 0)
  final int tokensFungiblesNb;
  @override
  @JsonKey()
  @HiveField(6, defaultValue: 0)
  final int nftNb;
  @override
  @JsonKey()
  @HiveField(7, defaultValue: 0)
  final double totalUSD;

  @override
  String toString() {
    return 'AccountBalance(tokensFungiblesNb: $tokensFungiblesNb, nftNb: $nftNb, totalUSD: $totalUSD)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountBalanceImpl &&
            (identical(other.tokensFungiblesNb, tokensFungiblesNb) ||
                other.tokensFungiblesNb == tokensFungiblesNb) &&
            (identical(other.nftNb, nftNb) || other.nftNb == nftNb) &&
            (identical(other.totalUSD, totalUSD) ||
                other.totalUSD == totalUSD));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tokensFungiblesNb, nftNb, totalUSD);

  /// Create a copy of AccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountBalanceImplCopyWith<_$AccountBalanceImpl> get copyWith =>
      __$$AccountBalanceImplCopyWithImpl<_$AccountBalanceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountBalanceImplToJson(
      this,
    );
  }
}

abstract class _AccountBalance implements AccountBalance {
  factory _AccountBalance(
          {@HiveField(5, defaultValue: 0) final int tokensFungiblesNb,
          @HiveField(6, defaultValue: 0) final int nftNb,
          @HiveField(7, defaultValue: 0) final double totalUSD}) =
      _$AccountBalanceImpl;

  factory _AccountBalance.fromJson(Map<String, dynamic> json) =
      _$AccountBalanceImpl.fromJson;

// @HiveField(0) required double nativeTokenValue,
// @HiveField(1) required String nativeTokenName,
  @override
  @HiveField(5, defaultValue: 0)
  int get tokensFungiblesNb;
  @override
  @HiveField(6, defaultValue: 0)
  int get nftNb;
  @override
  @HiveField(7, defaultValue: 0)
  double get totalUSD;

  /// Create a copy of AccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountBalanceImplCopyWith<_$AccountBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
