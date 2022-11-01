// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'market_price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MarketPrice {
  double get amount => throw _privateConstructorUsedError;
  int get lastLoading => throw _privateConstructorUsedError;
  bool get useOracle => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MarketPriceCopyWith<MarketPrice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketPriceCopyWith<$Res> {
  factory $MarketPriceCopyWith(
          MarketPrice value, $Res Function(MarketPrice) then) =
      _$MarketPriceCopyWithImpl<$Res, MarketPrice>;
  @useResult
  $Res call({double amount, int lastLoading, bool useOracle});
}

/// @nodoc
class _$MarketPriceCopyWithImpl<$Res, $Val extends MarketPrice>
    implements $MarketPriceCopyWith<$Res> {
  _$MarketPriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? lastLoading = null,
    Object? useOracle = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      lastLoading: null == lastLoading
          ? _value.lastLoading
          : lastLoading // ignore: cast_nullable_to_non_nullable
              as int,
      useOracle: null == useOracle
          ? _value.useOracle
          : useOracle // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MarketPriceCopyWith<$Res>
    implements $MarketPriceCopyWith<$Res> {
  factory _$$_MarketPriceCopyWith(
          _$_MarketPrice value, $Res Function(_$_MarketPrice) then) =
      __$$_MarketPriceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, int lastLoading, bool useOracle});
}

/// @nodoc
class __$$_MarketPriceCopyWithImpl<$Res>
    extends _$MarketPriceCopyWithImpl<$Res, _$_MarketPrice>
    implements _$$_MarketPriceCopyWith<$Res> {
  __$$_MarketPriceCopyWithImpl(
      _$_MarketPrice _value, $Res Function(_$_MarketPrice) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? lastLoading = null,
    Object? useOracle = null,
  }) {
    return _then(_$_MarketPrice(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      lastLoading: null == lastLoading
          ? _value.lastLoading
          : lastLoading // ignore: cast_nullable_to_non_nullable
              as int,
      useOracle: null == useOracle
          ? _value.useOracle
          : useOracle // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_MarketPrice extends _MarketPrice {
  const _$_MarketPrice(
      {required this.amount,
      required this.lastLoading,
      required this.useOracle})
      : super._();

  @override
  final double amount;
  @override
  final int lastLoading;
  @override
  final bool useOracle;

  @override
  String toString() {
    return 'MarketPrice(amount: $amount, lastLoading: $lastLoading, useOracle: $useOracle)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MarketPrice &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.lastLoading, lastLoading) ||
                other.lastLoading == lastLoading) &&
            (identical(other.useOracle, useOracle) ||
                other.useOracle == useOracle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, lastLoading, useOracle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MarketPriceCopyWith<_$_MarketPrice> get copyWith =>
      __$$_MarketPriceCopyWithImpl<_$_MarketPrice>(this, _$identity);
}

abstract class _MarketPrice extends MarketPrice {
  const factory _MarketPrice(
      {required final double amount,
      required final int lastLoading,
      required final bool useOracle}) = _$_MarketPrice;
  const _MarketPrice._() : super._();

  @override
  double get amount;
  @override
  int get lastLoading;
  @override
  bool get useOracle;
  @override
  @JsonKey(ignore: true)
  _$$_MarketPriceCopyWith<_$_MarketPrice> get copyWith =>
      throw _privateConstructorUsedError;
}
