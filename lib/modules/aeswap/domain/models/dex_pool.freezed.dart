// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_pool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexPool _$DexPoolFromJson(Map<String, dynamic> json) {
  return _DexPool.fromJson(json);
}

/// @nodoc
mixin _$DexPool {
  String get poolAddress => throw _privateConstructorUsedError;
  DexToken get lpToken => throw _privateConstructorUsedError;
  DexPair get pair => throw _privateConstructorUsedError;
  bool get lpTokenInUserBalance => throw _privateConstructorUsedError;

  /// Serializes this DexPool to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DexPool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DexPoolCopyWith<DexPool> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexPoolCopyWith<$Res> {
  factory $DexPoolCopyWith(DexPool value, $Res Function(DexPool) then) =
      _$DexPoolCopyWithImpl<$Res, DexPool>;
  @useResult
  $Res call(
      {String poolAddress,
      DexToken lpToken,
      DexPair pair,
      bool lpTokenInUserBalance});

  $DexTokenCopyWith<$Res> get lpToken;
  $DexPairCopyWith<$Res> get pair;
}

/// @nodoc
class _$DexPoolCopyWithImpl<$Res, $Val extends DexPool>
    implements $DexPoolCopyWith<$Res> {
  _$DexPoolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DexPool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddress = null,
    Object? lpToken = null,
    Object? pair = null,
    Object? lpTokenInUserBalance = null,
  }) {
    return _then(_value.copyWith(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lpToken: null == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken,
      pair: null == pair
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as DexPair,
      lpTokenInUserBalance: null == lpTokenInUserBalance
          ? _value.lpTokenInUserBalance
          : lpTokenInUserBalance // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of DexPool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res> get lpToken {
    return $DexTokenCopyWith<$Res>(_value.lpToken, (value) {
      return _then(_value.copyWith(lpToken: value) as $Val);
    });
  }

  /// Create a copy of DexPool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexPairCopyWith<$Res> get pair {
    return $DexPairCopyWith<$Res>(_value.pair, (value) {
      return _then(_value.copyWith(pair: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DexPoolImplCopyWith<$Res> implements $DexPoolCopyWith<$Res> {
  factory _$$DexPoolImplCopyWith(
          _$DexPoolImpl value, $Res Function(_$DexPoolImpl) then) =
      __$$DexPoolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String poolAddress,
      DexToken lpToken,
      DexPair pair,
      bool lpTokenInUserBalance});

  @override
  $DexTokenCopyWith<$Res> get lpToken;
  @override
  $DexPairCopyWith<$Res> get pair;
}

/// @nodoc
class __$$DexPoolImplCopyWithImpl<$Res>
    extends _$DexPoolCopyWithImpl<$Res, _$DexPoolImpl>
    implements _$$DexPoolImplCopyWith<$Res> {
  __$$DexPoolImplCopyWithImpl(
      _$DexPoolImpl _value, $Res Function(_$DexPoolImpl) _then)
      : super(_value, _then);

  /// Create a copy of DexPool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddress = null,
    Object? lpToken = null,
    Object? pair = null,
    Object? lpTokenInUserBalance = null,
  }) {
    return _then(_$DexPoolImpl(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      lpToken: null == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken,
      pair: null == pair
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as DexPair,
      lpTokenInUserBalance: null == lpTokenInUserBalance
          ? _value.lpTokenInUserBalance
          : lpTokenInUserBalance // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexPoolImpl extends _DexPool {
  const _$DexPoolImpl(
      {required this.poolAddress,
      required this.lpToken,
      required this.pair,
      required this.lpTokenInUserBalance})
      : super._();

  factory _$DexPoolImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexPoolImplFromJson(json);

  @override
  final String poolAddress;
  @override
  final DexToken lpToken;
  @override
  final DexPair pair;
  @override
  final bool lpTokenInUserBalance;

  @override
  String toString() {
    return 'DexPool(poolAddress: $poolAddress, lpToken: $lpToken, pair: $pair, lpTokenInUserBalance: $lpTokenInUserBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexPoolImpl &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken) &&
            (identical(other.pair, pair) || other.pair == pair) &&
            (identical(other.lpTokenInUserBalance, lpTokenInUserBalance) ||
                other.lpTokenInUserBalance == lpTokenInUserBalance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, poolAddress, lpToken, pair, lpTokenInUserBalance);

  /// Create a copy of DexPool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPoolImplCopyWith<_$DexPoolImpl> get copyWith =>
      __$$DexPoolImplCopyWithImpl<_$DexPoolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexPoolImplToJson(
      this,
    );
  }
}

abstract class _DexPool extends DexPool {
  const factory _DexPool(
      {required final String poolAddress,
      required final DexToken lpToken,
      required final DexPair pair,
      required final bool lpTokenInUserBalance}) = _$DexPoolImpl;
  const _DexPool._() : super._();

  factory _DexPool.fromJson(Map<String, dynamic> json) = _$DexPoolImpl.fromJson;

  @override
  String get poolAddress;
  @override
  DexToken get lpToken;
  @override
  DexPair get pair;
  @override
  bool get lpTokenInUserBalance;

  /// Create a copy of DexPool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DexPoolImplCopyWith<_$DexPoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
