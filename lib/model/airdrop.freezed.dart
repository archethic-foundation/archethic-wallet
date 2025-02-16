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
  int? get personalMultiplier => throw _privateConstructorUsedError;
  double? get personalLPAmount => throw _privateConstructorUsedError;
  double? get personalLPFlexibleAmount => throw _privateConstructorUsedError;
  bool? get isMailConfirmed => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get referralCode => throw _privateConstructorUsedError;

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
      {int? personalMultiplier,
      double? personalLPAmount,
      double? personalLPFlexibleAmount,
      bool? isMailConfirmed,
      String? email,
      String? referralCode});
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
    Object? personalMultiplier = freezed,
    Object? personalLPAmount = freezed,
    Object? personalLPFlexibleAmount = freezed,
    Object? isMailConfirmed = freezed,
    Object? email = freezed,
    Object? referralCode = freezed,
  }) {
    return _then(_value.copyWith(
      personalMultiplier: freezed == personalMultiplier
          ? _value.personalMultiplier
          : personalMultiplier // ignore: cast_nullable_to_non_nullable
              as int?,
      personalLPAmount: freezed == personalLPAmount
          ? _value.personalLPAmount
          : personalLPAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      personalLPFlexibleAmount: freezed == personalLPFlexibleAmount
          ? _value.personalLPFlexibleAmount
          : personalLPFlexibleAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      isMailConfirmed: freezed == isMailConfirmed
          ? _value.isMailConfirmed
          : isMailConfirmed // ignore: cast_nullable_to_non_nullable
              as bool?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {int? personalMultiplier,
      double? personalLPAmount,
      double? personalLPFlexibleAmount,
      bool? isMailConfirmed,
      String? email,
      String? referralCode});
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
    Object? personalMultiplier = freezed,
    Object? personalLPAmount = freezed,
    Object? personalLPFlexibleAmount = freezed,
    Object? isMailConfirmed = freezed,
    Object? email = freezed,
    Object? referralCode = freezed,
  }) {
    return _then(_$AirdropImpl(
      personalMultiplier: freezed == personalMultiplier
          ? _value.personalMultiplier
          : personalMultiplier // ignore: cast_nullable_to_non_nullable
              as int?,
      personalLPAmount: freezed == personalLPAmount
          ? _value.personalLPAmount
          : personalLPAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      personalLPFlexibleAmount: freezed == personalLPFlexibleAmount
          ? _value.personalLPFlexibleAmount
          : personalLPFlexibleAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      isMailConfirmed: freezed == isMailConfirmed
          ? _value.isMailConfirmed
          : isMailConfirmed // ignore: cast_nullable_to_non_nullable
              as bool?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AirdropImpl extends _Airdrop {
  const _$AirdropImpl(
      {this.personalMultiplier,
      this.personalLPAmount,
      this.personalLPFlexibleAmount,
      this.isMailConfirmed,
      this.email,
      this.referralCode})
      : super._();

  @override
  final int? personalMultiplier;
  @override
  final double? personalLPAmount;
  @override
  final double? personalLPFlexibleAmount;
  @override
  final bool? isMailConfirmed;
  @override
  final String? email;
  @override
  final String? referralCode;

  @override
  String toString() {
    return 'Airdrop(personalMultiplier: $personalMultiplier, personalLPAmount: $personalLPAmount, personalLPFlexibleAmount: $personalLPFlexibleAmount, isMailConfirmed: $isMailConfirmed, email: $email, referralCode: $referralCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirdropImpl &&
            (identical(other.personalMultiplier, personalMultiplier) ||
                other.personalMultiplier == personalMultiplier) &&
            (identical(other.personalLPAmount, personalLPAmount) ||
                other.personalLPAmount == personalLPAmount) &&
            (identical(
                    other.personalLPFlexibleAmount, personalLPFlexibleAmount) ||
                other.personalLPFlexibleAmount == personalLPFlexibleAmount) &&
            (identical(other.isMailConfirmed, isMailConfirmed) ||
                other.isMailConfirmed == isMailConfirmed) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      personalMultiplier,
      personalLPAmount,
      personalLPFlexibleAmount,
      isMailConfirmed,
      email,
      referralCode);

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
      {final int? personalMultiplier,
      final double? personalLPAmount,
      final double? personalLPFlexibleAmount,
      final bool? isMailConfirmed,
      final String? email,
      final String? referralCode}) = _$AirdropImpl;
  const _Airdrop._() : super._();

  @override
  int? get personalMultiplier;
  @override
  double? get personalLPAmount;
  @override
  double? get personalLPFlexibleAmount;
  @override
  bool? get isMailConfirmed;
  @override
  String? get email;
  @override
  String? get referralCode;

  /// Create a copy of Airdrop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AirdropImplCopyWith<_$AirdropImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
