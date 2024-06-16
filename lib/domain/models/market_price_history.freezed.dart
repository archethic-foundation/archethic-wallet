// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_price_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PriceHistoryValue _$PriceHistoryValueFromJson(Map<String, dynamic> json) {
  return _PriceHistoryValue.fromJson(json);
}

/// @nodoc
mixin _$PriceHistoryValue {
  num get price => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceHistoryValueCopyWith<PriceHistoryValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceHistoryValueCopyWith<$Res> {
  factory $PriceHistoryValueCopyWith(
          PriceHistoryValue value, $Res Function(PriceHistoryValue) then) =
      _$PriceHistoryValueCopyWithImpl<$Res, PriceHistoryValue>;
  @useResult
  $Res call({num price, DateTime time});
}

/// @nodoc
class _$PriceHistoryValueCopyWithImpl<$Res, $Val extends PriceHistoryValue>
    implements $PriceHistoryValueCopyWith<$Res> {
  _$PriceHistoryValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceHistoryValueImplCopyWith<$Res>
    implements $PriceHistoryValueCopyWith<$Res> {
  factory _$$PriceHistoryValueImplCopyWith(_$PriceHistoryValueImpl value,
          $Res Function(_$PriceHistoryValueImpl) then) =
      __$$PriceHistoryValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({num price, DateTime time});
}

/// @nodoc
class __$$PriceHistoryValueImplCopyWithImpl<$Res>
    extends _$PriceHistoryValueCopyWithImpl<$Res, _$PriceHistoryValueImpl>
    implements _$$PriceHistoryValueImplCopyWith<$Res> {
  __$$PriceHistoryValueImplCopyWithImpl(_$PriceHistoryValueImpl _value,
      $Res Function(_$PriceHistoryValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? time = null,
  }) {
    return _then(_$PriceHistoryValueImpl(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceHistoryValueImpl implements _PriceHistoryValue {
  const _$PriceHistoryValueImpl({required this.price, required this.time});

  factory _$PriceHistoryValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceHistoryValueImplFromJson(json);

  @override
  final num price;
  @override
  final DateTime time;

  @override
  String toString() {
    return 'PriceHistoryValue(price: $price, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceHistoryValueImpl &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, price, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceHistoryValueImplCopyWith<_$PriceHistoryValueImpl> get copyWith =>
      __$$PriceHistoryValueImplCopyWithImpl<_$PriceHistoryValueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceHistoryValueImplToJson(
      this,
    );
  }
}

abstract class _PriceHistoryValue implements PriceHistoryValue {
  const factory _PriceHistoryValue(
      {required final num price,
      required final DateTime time}) = _$PriceHistoryValueImpl;

  factory _PriceHistoryValue.fromJson(Map<String, dynamic> json) =
      _$PriceHistoryValueImpl.fromJson;

  @override
  num get price;
  @override
  DateTime get time;
  @override
  @JsonKey(ignore: true)
  _$$PriceHistoryValueImplCopyWith<_$PriceHistoryValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
