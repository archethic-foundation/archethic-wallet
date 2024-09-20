// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexToken _$DexTokenFromJson(Map<String, dynamic> json) {
  return _DexToken.fromJson(json);
}

/// @nodoc
mixin _$DexToken {
  String get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  double get reserve => throw _privateConstructorUsedError;
  double get supply => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  bool get isLpToken => throw _privateConstructorUsedError;
  DexPair? get lpTokenPair => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DexTokenCopyWith<DexToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexTokenCopyWith<$Res> {
  factory $DexTokenCopyWith(DexToken value, $Res Function(DexToken) then) =
      _$DexTokenCopyWithImpl<$Res, DexToken>;
  @useResult
  $Res call(
      {String name,
      String? address,
      String? icon,
      String symbol,
      double balance,
      double reserve,
      double supply,
      bool isVerified,
      bool isLpToken,
      DexPair? lpTokenPair});

  $DexPairCopyWith<$Res>? get lpTokenPair;
}

/// @nodoc
class _$DexTokenCopyWithImpl<$Res, $Val extends DexToken>
    implements $DexTokenCopyWith<$Res> {
  _$DexTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = freezed,
    Object? icon = freezed,
    Object? symbol = null,
    Object? balance = null,
    Object? reserve = null,
    Object? supply = null,
    Object? isVerified = null,
    Object? isLpToken = null,
    Object? lpTokenPair = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      reserve: null == reserve
          ? _value.reserve
          : reserve // ignore: cast_nullable_to_non_nullable
              as double,
      supply: null == supply
          ? _value.supply
          : supply // ignore: cast_nullable_to_non_nullable
              as double,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isLpToken: null == isLpToken
          ? _value.isLpToken
          : isLpToken // ignore: cast_nullable_to_non_nullable
              as bool,
      lpTokenPair: freezed == lpTokenPair
          ? _value.lpTokenPair
          : lpTokenPair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
    ) as $Val);
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
}

/// @nodoc
abstract class _$$DexTokenImplCopyWith<$Res>
    implements $DexTokenCopyWith<$Res> {
  factory _$$DexTokenImplCopyWith(
          _$DexTokenImpl value, $Res Function(_$DexTokenImpl) then) =
      __$$DexTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? address,
      String? icon,
      String symbol,
      double balance,
      double reserve,
      double supply,
      bool isVerified,
      bool isLpToken,
      DexPair? lpTokenPair});

  @override
  $DexPairCopyWith<$Res>? get lpTokenPair;
}

/// @nodoc
class __$$DexTokenImplCopyWithImpl<$Res>
    extends _$DexTokenCopyWithImpl<$Res, _$DexTokenImpl>
    implements _$$DexTokenImplCopyWith<$Res> {
  __$$DexTokenImplCopyWithImpl(
      _$DexTokenImpl _value, $Res Function(_$DexTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = freezed,
    Object? icon = freezed,
    Object? symbol = null,
    Object? balance = null,
    Object? reserve = null,
    Object? supply = null,
    Object? isVerified = null,
    Object? isLpToken = null,
    Object? lpTokenPair = freezed,
  }) {
    return _then(_$DexTokenImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      reserve: null == reserve
          ? _value.reserve
          : reserve // ignore: cast_nullable_to_non_nullable
              as double,
      supply: null == supply
          ? _value.supply
          : supply // ignore: cast_nullable_to_non_nullable
              as double,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isLpToken: null == isLpToken
          ? _value.isLpToken
          : isLpToken // ignore: cast_nullable_to_non_nullable
              as bool,
      lpTokenPair: freezed == lpTokenPair
          ? _value.lpTokenPair
          : lpTokenPair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexTokenImpl extends _DexToken {
  const _$DexTokenImpl(
      {this.name = '',
      this.address,
      this.icon,
      this.symbol = '',
      this.balance = 0.0,
      this.reserve = 0.0,
      this.supply = 0.0,
      this.isVerified = false,
      this.isLpToken = false,
      this.lpTokenPair})
      : super._();

  factory _$DexTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexTokenImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  final String? address;
  @override
  final String? icon;
  @override
  @JsonKey()
  final String symbol;
  @override
  @JsonKey()
  final double balance;
  @override
  @JsonKey()
  final double reserve;
  @override
  @JsonKey()
  final double supply;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  @JsonKey()
  final bool isLpToken;
  @override
  final DexPair? lpTokenPair;

  @override
  String toString() {
    return 'DexToken(name: $name, address: $address, icon: $icon, symbol: $symbol, balance: $balance, reserve: $reserve, supply: $supply, isVerified: $isVerified, isLpToken: $isLpToken, lpTokenPair: $lpTokenPair)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexTokenImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.reserve, reserve) || other.reserve == reserve) &&
            (identical(other.supply, supply) || other.supply == supply) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isLpToken, isLpToken) ||
                other.isLpToken == isLpToken) &&
            (identical(other.lpTokenPair, lpTokenPair) ||
                other.lpTokenPair == lpTokenPair));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, address, icon, symbol,
      balance, reserve, supply, isVerified, isLpToken, lpTokenPair);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexTokenImplCopyWith<_$DexTokenImpl> get copyWith =>
      __$$DexTokenImplCopyWithImpl<_$DexTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexTokenImplToJson(
      this,
    );
  }
}

abstract class _DexToken extends DexToken {
  const factory _DexToken(
      {final String name,
      final String? address,
      final String? icon,
      final String symbol,
      final double balance,
      final double reserve,
      final double supply,
      final bool isVerified,
      final bool isLpToken,
      final DexPair? lpTokenPair}) = _$DexTokenImpl;
  const _DexToken._() : super._();

  factory _DexToken.fromJson(Map<String, dynamic> json) =
      _$DexTokenImpl.fromJson;

  @override
  String get name;
  @override
  String? get address;
  @override
  String? get icon;
  @override
  String get symbol;
  @override
  double get balance;
  @override
  double get reserve;
  @override
  double get supply;
  @override
  bool get isVerified;
  @override
  bool get isLpToken;
  @override
  DexPair? get lpTokenPair;
  @override
  @JsonKey(ignore: true)
  _$$DexTokenImplCopyWith<_$DexTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
