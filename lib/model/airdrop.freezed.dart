// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'airdrop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Airdrop {
  double get personalLPAmount => throw _privateConstructorUsedError;
  bool get isMailFilled => throw _privateConstructorUsedError;
  bool get isMailConfirmed => throw _privateConstructorUsedError;

  /// Create a copy of Airdrop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AirdropCopyWith<Airdrop> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AirdropCopyWith<$Res> {
  factory $AirdropCopyWith(Airdrop value, $Res Function(Airdrop) then) =
      _$AirdropCopyWithImpl<$Res, Airdrop>;
  @useResult
  $Res call({double personalLPAmount, bool isMailFilled, bool isMailConfirmed});
}

/// @nodoc
class _$AirdropCopyWithImpl<$Res, $Val extends Airdrop>
    implements $AirdropCopyWith<$Res> {
  _$AirdropCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Airdrop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? personalLPAmount = null,
    Object? isMailFilled = null,
    Object? isMailConfirmed = null,
  }) {
    return _then(_value.copyWith(
      personalLPAmount: null == personalLPAmount
          ? _value.personalLPAmount
          : personalLPAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isMailFilled: null == isMailFilled
          ? _value.isMailFilled
          : isMailFilled // ignore: cast_nullable_to_non_nullable
              as bool,
      isMailConfirmed: null == isMailConfirmed
          ? _value.isMailConfirmed
          : isMailConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AirdropImplCopyWith<$Res> implements $AirdropCopyWith<$Res> {
  factory _$$AirdropImplCopyWith(
          _$AirdropImpl value, $Res Function(_$AirdropImpl) then) =
      __$$AirdropImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double personalLPAmount, bool isMailFilled, bool isMailConfirmed});
}

/// @nodoc
class __$$AirdropImplCopyWithImpl<$Res>
    extends _$AirdropCopyWithImpl<$Res, _$AirdropImpl>
    implements _$$AirdropImplCopyWith<$Res> {
  __$$AirdropImplCopyWithImpl(
      _$AirdropImpl _value, $Res Function(_$AirdropImpl) _then)
      : super(_value, _then);

  /// Create a copy of Airdrop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? personalLPAmount = null,
    Object? isMailFilled = null,
    Object? isMailConfirmed = null,
  }) {
    return _then(_$AirdropImpl(
      personalLPAmount: null == personalLPAmount
          ? _value.personalLPAmount
          : personalLPAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isMailFilled: null == isMailFilled
          ? _value.isMailFilled
          : isMailFilled // ignore: cast_nullable_to_non_nullable
              as bool,
      isMailConfirmed: null == isMailConfirmed
          ? _value.isMailConfirmed
          : isMailConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AirdropImpl extends _Airdrop {
  const _$AirdropImpl(
      {this.personalLPAmount = 0.0,
      this.isMailFilled = false,
      this.isMailConfirmed = false})
      : super._();

  @override
  @JsonKey()
  final double personalLPAmount;
  @override
  @JsonKey()
  final bool isMailFilled;
  @override
  @JsonKey()
  final bool isMailConfirmed;

  @override
  String toString() {
    return 'Airdrop(personalLPAmount: $personalLPAmount, isMailFilled: $isMailFilled, isMailConfirmed: $isMailConfirmed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirdropImpl &&
            (identical(other.personalLPAmount, personalLPAmount) ||
                other.personalLPAmount == personalLPAmount) &&
            (identical(other.isMailFilled, isMailFilled) ||
                other.isMailFilled == isMailFilled) &&
            (identical(other.isMailConfirmed, isMailConfirmed) ||
                other.isMailConfirmed == isMailConfirmed));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, personalLPAmount, isMailFilled, isMailConfirmed);

  /// Create a copy of Airdrop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AirdropImplCopyWith<_$AirdropImpl> get copyWith =>
      __$$AirdropImplCopyWithImpl<_$AirdropImpl>(this, _$identity);
}

abstract class _Airdrop extends Airdrop {
  const factory _Airdrop(
      {final double personalLPAmount,
      final bool isMailFilled,
      final bool isMailConfirmed}) = _$AirdropImpl;
  const _Airdrop._() : super._();

  @override
  double get personalLPAmount;
  @override
  bool get isMailFilled;
  @override
  bool get isMailConfirmed;

  /// Create a copy of Airdrop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AirdropImplCopyWith<_$AirdropImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
