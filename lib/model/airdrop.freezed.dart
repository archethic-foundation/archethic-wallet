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
  dynamic get isFarming => throw _privateConstructorUsedError;
  dynamic get isMailFilled => throw _privateConstructorUsedError;
  int? get currentStep => throw _privateConstructorUsedError;
  int? get personalMultiplier => throw _privateConstructorUsedError;
  double get currentAirdropValue => throw _privateConstructorUsedError;

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
  $Res call(
      {dynamic isFarming,
      dynamic isMailFilled,
      int? currentStep,
      int? personalMultiplier,
      double currentAirdropValue});
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
    Object? isFarming = freezed,
    Object? isMailFilled = freezed,
    Object? currentStep = freezed,
    Object? personalMultiplier = freezed,
    Object? currentAirdropValue = null,
  }) {
    return _then(_value.copyWith(
      isFarming: freezed == isFarming
          ? _value.isFarming
          : isFarming // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isMailFilled: freezed == isMailFilled
          ? _value.isMailFilled
          : isMailFilled // ignore: cast_nullable_to_non_nullable
              as dynamic,
      currentStep: freezed == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int?,
      personalMultiplier: freezed == personalMultiplier
          ? _value.personalMultiplier
          : personalMultiplier // ignore: cast_nullable_to_non_nullable
              as int?,
      currentAirdropValue: null == currentAirdropValue
          ? _value.currentAirdropValue
          : currentAirdropValue // ignore: cast_nullable_to_non_nullable
              as double,
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
  $Res call(
      {dynamic isFarming,
      dynamic isMailFilled,
      int? currentStep,
      int? personalMultiplier,
      double currentAirdropValue});
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
    Object? isFarming = freezed,
    Object? isMailFilled = freezed,
    Object? currentStep = freezed,
    Object? personalMultiplier = freezed,
    Object? currentAirdropValue = null,
  }) {
    return _then(_$AirdropImpl(
      isFarming: freezed == isFarming ? _value.isFarming! : isFarming,
      isMailFilled:
          freezed == isMailFilled ? _value.isMailFilled! : isMailFilled,
      currentStep: freezed == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int?,
      personalMultiplier: freezed == personalMultiplier
          ? _value.personalMultiplier
          : personalMultiplier // ignore: cast_nullable_to_non_nullable
              as int?,
      currentAirdropValue: null == currentAirdropValue
          ? _value.currentAirdropValue
          : currentAirdropValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$AirdropImpl extends _Airdrop {
  const _$AirdropImpl(
      {this.isFarming = false,
      this.isMailFilled = false,
      this.currentStep,
      this.personalMultiplier,
      this.currentAirdropValue = 0})
      : super._();

  @override
  @JsonKey()
  final dynamic isFarming;
  @override
  @JsonKey()
  final dynamic isMailFilled;
  @override
  final int? currentStep;
  @override
  final int? personalMultiplier;
  @override
  @JsonKey()
  final double currentAirdropValue;

  @override
  String toString() {
    return 'Airdrop(isFarming: $isFarming, isMailFilled: $isMailFilled, currentStep: $currentStep, personalMultiplier: $personalMultiplier, currentAirdropValue: $currentAirdropValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirdropImpl &&
            const DeepCollectionEquality().equals(other.isFarming, isFarming) &&
            const DeepCollectionEquality()
                .equals(other.isMailFilled, isMailFilled) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.personalMultiplier, personalMultiplier) ||
                other.personalMultiplier == personalMultiplier) &&
            (identical(other.currentAirdropValue, currentAirdropValue) ||
                other.currentAirdropValue == currentAirdropValue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isFarming),
      const DeepCollectionEquality().hash(isMailFilled),
      currentStep,
      personalMultiplier,
      currentAirdropValue);

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
      {final dynamic isFarming,
      final dynamic isMailFilled,
      final int? currentStep,
      final int? personalMultiplier,
      final double currentAirdropValue}) = _$AirdropImpl;
  const _Airdrop._() : super._();

  @override
  dynamic get isFarming;
  @override
  dynamic get isMailFilled;
  @override
  int? get currentStep;
  @override
  int? get personalMultiplier;
  @override
  double get currentAirdropValue;

  /// Create a copy of Airdrop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AirdropImplCopyWith<_$AirdropImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
