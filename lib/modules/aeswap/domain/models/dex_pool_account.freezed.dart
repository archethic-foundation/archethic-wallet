// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_pool_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DexPoolAccount {
  DexPool get pool => throw _privateConstructorUsedError;
  double get token1Amount => throw _privateConstructorUsedError;
  double get token2Amount => throw _privateConstructorUsedError;

  /// Create a copy of DexPoolAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DexPoolAccountCopyWith<DexPoolAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexPoolAccountCopyWith<$Res> {
  factory $DexPoolAccountCopyWith(
          DexPoolAccount value, $Res Function(DexPoolAccount) then) =
      _$DexPoolAccountCopyWithImpl<$Res, DexPoolAccount>;
  @useResult
  $Res call({DexPool pool, double token1Amount, double token2Amount});

  $DexPoolCopyWith<$Res> get pool;
}

/// @nodoc
class _$DexPoolAccountCopyWithImpl<$Res, $Val extends DexPoolAccount>
    implements $DexPoolAccountCopyWith<$Res> {
  _$DexPoolAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DexPoolAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pool = null,
    Object? token1Amount = null,
    Object? token2Amount = null,
  }) {
    return _then(_value.copyWith(
      pool: null == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool,
      token1Amount: null == token1Amount
          ? _value.token1Amount
          : token1Amount // ignore: cast_nullable_to_non_nullable
              as double,
      token2Amount: null == token2Amount
          ? _value.token2Amount
          : token2Amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of DexPoolAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexPoolCopyWith<$Res> get pool {
    return $DexPoolCopyWith<$Res>(_value.pool, (value) {
      return _then(_value.copyWith(pool: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DexPoolAccountImplCopyWith<$Res>
    implements $DexPoolAccountCopyWith<$Res> {
  factory _$$DexPoolAccountImplCopyWith(_$DexPoolAccountImpl value,
          $Res Function(_$DexPoolAccountImpl) then) =
      __$$DexPoolAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DexPool pool, double token1Amount, double token2Amount});

  @override
  $DexPoolCopyWith<$Res> get pool;
}

/// @nodoc
class __$$DexPoolAccountImplCopyWithImpl<$Res>
    extends _$DexPoolAccountCopyWithImpl<$Res, _$DexPoolAccountImpl>
    implements _$$DexPoolAccountImplCopyWith<$Res> {
  __$$DexPoolAccountImplCopyWithImpl(
      _$DexPoolAccountImpl _value, $Res Function(_$DexPoolAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of DexPoolAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pool = null,
    Object? token1Amount = null,
    Object? token2Amount = null,
  }) {
    return _then(_$DexPoolAccountImpl(
      pool: null == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool,
      token1Amount: null == token1Amount
          ? _value.token1Amount
          : token1Amount // ignore: cast_nullable_to_non_nullable
              as double,
      token2Amount: null == token2Amount
          ? _value.token2Amount
          : token2Amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DexPoolAccountImpl implements _DexPoolAccount {
  const _$DexPoolAccountImpl(
      {this.pool = '', this.token1Amount = 0.0, this.token2Amount = 0.0});

  @override
  @JsonKey()
  final DexPool pool;
  @override
  @JsonKey()
  final double token1Amount;
  @override
  @JsonKey()
  final double token2Amount;

  @override
  String toString() {
    return 'DexPoolAccount(pool: $pool, token1Amount: $token1Amount, token2Amount: $token2Amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexPoolAccountImpl &&
            (identical(other.pool, pool) || other.pool == pool) &&
            (identical(other.token1Amount, token1Amount) ||
                other.token1Amount == token1Amount) &&
            (identical(other.token2Amount, token2Amount) ||
                other.token2Amount == token2Amount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, pool, token1Amount, token2Amount);

  /// Create a copy of DexPoolAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPoolAccountImplCopyWith<_$DexPoolAccountImpl> get copyWith =>
      __$$DexPoolAccountImplCopyWithImpl<_$DexPoolAccountImpl>(
          this, _$identity);
}

abstract class _DexPoolAccount implements DexPoolAccount {
  const factory _DexPoolAccount(
      {final DexPool pool,
      final double token1Amount,
      final double token2Amount}) = _$DexPoolAccountImpl;

  @override
  DexPool get pool;
  @override
  double get token1Amount;
  @override
  double get token2Amount;

  /// Create a copy of DexPoolAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DexPoolAccountImplCopyWith<_$DexPoolAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
