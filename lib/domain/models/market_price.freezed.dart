// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MarketPrice {
  double get amount => throw _privateConstructorUsedError;
  int get lastLoading => throw _privateConstructorUsedError;
  bool get useOracle => throw _privateConstructorUsedError;

  /// Create a copy of MarketPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MarketPrice
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$MarketPriceImplCopyWith<$Res>
    implements $MarketPriceCopyWith<$Res> {
  factory _$$MarketPriceImplCopyWith(
          _$MarketPriceImpl value, $Res Function(_$MarketPriceImpl) then) =
      __$$MarketPriceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, int lastLoading, bool useOracle});
}

/// @nodoc
class __$$MarketPriceImplCopyWithImpl<$Res>
    extends _$MarketPriceCopyWithImpl<$Res, _$MarketPriceImpl>
    implements _$$MarketPriceImplCopyWith<$Res> {
  __$$MarketPriceImplCopyWithImpl(
      _$MarketPriceImpl _value, $Res Function(_$MarketPriceImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarketPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? lastLoading = null,
    Object? useOracle = null,
  }) {
    return _then(_$MarketPriceImpl(
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

class _$MarketPriceImpl extends _MarketPrice {
  const _$MarketPriceImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketPriceImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.lastLoading, lastLoading) ||
                other.lastLoading == lastLoading) &&
            (identical(other.useOracle, useOracle) ||
                other.useOracle == useOracle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, lastLoading, useOracle);

  /// Create a copy of MarketPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketPriceImplCopyWith<_$MarketPriceImpl> get copyWith =>
      __$$MarketPriceImplCopyWithImpl<_$MarketPriceImpl>(this, _$identity);
}

abstract class _MarketPrice extends MarketPrice {
  const factory _MarketPrice(
      {required final double amount,
      required final int lastLoading,
      required final bool useOracle}) = _$MarketPriceImpl;
  const _MarketPrice._() : super._();

  @override
  double get amount;
  @override
  int get lastLoading;
  @override
  bool get useOracle;

  /// Create a copy of MarketPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketPriceImplCopyWith<_$MarketPriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
