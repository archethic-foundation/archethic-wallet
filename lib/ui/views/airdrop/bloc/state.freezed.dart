// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AirdropFormState {
  AirdropProcessStep get airdropProcessStep =>
      throw _privateConstructorUsedError;
  String? get mailAddress => throw _privateConstructorUsedError;
  bool get confirmOnlyOneAirdrop => throw _privateConstructorUsedError;
  bool get confirmNotMultipleRegistrations =>
      throw _privateConstructorUsedError;
  bool get confirmPrivacyPolicy => throw _privateConstructorUsedError;
  bool get joinWaitlistInProgress => throw _privateConstructorUsedError;
  double get personalLP => throw _privateConstructorUsedError;
  String? get resendConfirmationEmailInfo => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  /// Create a copy of AirdropFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AirdropFormStateCopyWith<AirdropFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AirdropFormStateCopyWith<$Res> {
  factory $AirdropFormStateCopyWith(
          AirdropFormState value, $Res Function(AirdropFormState) then) =
      _$AirdropFormStateCopyWithImpl<$Res, AirdropFormState>;
  @useResult
  $Res call(
      {AirdropProcessStep airdropProcessStep,
      String? mailAddress,
      bool confirmOnlyOneAirdrop,
      bool confirmNotMultipleRegistrations,
      bool confirmPrivacyPolicy,
      bool joinWaitlistInProgress,
      double personalLP,
      String? resendConfirmationEmailInfo,
      Failure? failure});

  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$AirdropFormStateCopyWithImpl<$Res, $Val extends AirdropFormState>
    implements $AirdropFormStateCopyWith<$Res> {
  _$AirdropFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AirdropFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? airdropProcessStep = null,
    Object? mailAddress = freezed,
    Object? confirmOnlyOneAirdrop = null,
    Object? confirmNotMultipleRegistrations = null,
    Object? confirmPrivacyPolicy = null,
    Object? joinWaitlistInProgress = null,
    Object? personalLP = null,
    Object? resendConfirmationEmailInfo = freezed,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      airdropProcessStep: null == airdropProcessStep
          ? _value.airdropProcessStep
          : airdropProcessStep // ignore: cast_nullable_to_non_nullable
              as AirdropProcessStep,
      mailAddress: freezed == mailAddress
          ? _value.mailAddress
          : mailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmOnlyOneAirdrop: null == confirmOnlyOneAirdrop
          ? _value.confirmOnlyOneAirdrop
          : confirmOnlyOneAirdrop // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmNotMultipleRegistrations: null == confirmNotMultipleRegistrations
          ? _value.confirmNotMultipleRegistrations
          : confirmNotMultipleRegistrations // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmPrivacyPolicy: null == confirmPrivacyPolicy
          ? _value.confirmPrivacyPolicy
          : confirmPrivacyPolicy // ignore: cast_nullable_to_non_nullable
              as bool,
      joinWaitlistInProgress: null == joinWaitlistInProgress
          ? _value.joinWaitlistInProgress
          : joinWaitlistInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      personalLP: null == personalLP
          ? _value.personalLP
          : personalLP // ignore: cast_nullable_to_non_nullable
              as double,
      resendConfirmationEmailInfo: freezed == resendConfirmationEmailInfo
          ? _value.resendConfirmationEmailInfo
          : resendConfirmationEmailInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ) as $Val);
  }

  /// Create a copy of AirdropFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $FailureCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AirdropFormStateImplCopyWith<$Res>
    implements $AirdropFormStateCopyWith<$Res> {
  factory _$$AirdropFormStateImplCopyWith(_$AirdropFormStateImpl value,
          $Res Function(_$AirdropFormStateImpl) then) =
      __$$AirdropFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AirdropProcessStep airdropProcessStep,
      String? mailAddress,
      bool confirmOnlyOneAirdrop,
      bool confirmNotMultipleRegistrations,
      bool confirmPrivacyPolicy,
      bool joinWaitlistInProgress,
      double personalLP,
      String? resendConfirmationEmailInfo,
      Failure? failure});

  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$AirdropFormStateImplCopyWithImpl<$Res>
    extends _$AirdropFormStateCopyWithImpl<$Res, _$AirdropFormStateImpl>
    implements _$$AirdropFormStateImplCopyWith<$Res> {
  __$$AirdropFormStateImplCopyWithImpl(_$AirdropFormStateImpl _value,
      $Res Function(_$AirdropFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AirdropFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? airdropProcessStep = null,
    Object? mailAddress = freezed,
    Object? confirmOnlyOneAirdrop = null,
    Object? confirmNotMultipleRegistrations = null,
    Object? confirmPrivacyPolicy = null,
    Object? joinWaitlistInProgress = null,
    Object? personalLP = null,
    Object? resendConfirmationEmailInfo = freezed,
    Object? failure = freezed,
  }) {
    return _then(_$AirdropFormStateImpl(
      airdropProcessStep: null == airdropProcessStep
          ? _value.airdropProcessStep
          : airdropProcessStep // ignore: cast_nullable_to_non_nullable
              as AirdropProcessStep,
      mailAddress: freezed == mailAddress
          ? _value.mailAddress
          : mailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmOnlyOneAirdrop: null == confirmOnlyOneAirdrop
          ? _value.confirmOnlyOneAirdrop
          : confirmOnlyOneAirdrop // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmNotMultipleRegistrations: null == confirmNotMultipleRegistrations
          ? _value.confirmNotMultipleRegistrations
          : confirmNotMultipleRegistrations // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmPrivacyPolicy: null == confirmPrivacyPolicy
          ? _value.confirmPrivacyPolicy
          : confirmPrivacyPolicy // ignore: cast_nullable_to_non_nullable
              as bool,
      joinWaitlistInProgress: null == joinWaitlistInProgress
          ? _value.joinWaitlistInProgress
          : joinWaitlistInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      personalLP: null == personalLP
          ? _value.personalLP
          : personalLP // ignore: cast_nullable_to_non_nullable
              as double,
      resendConfirmationEmailInfo: freezed == resendConfirmationEmailInfo
          ? _value.resendConfirmationEmailInfo
          : resendConfirmationEmailInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$AirdropFormStateImpl extends _AirdropFormState {
  const _$AirdropFormStateImpl(
      {this.airdropProcessStep = AirdropProcessStep.welcome,
      this.mailAddress,
      this.confirmOnlyOneAirdrop = false,
      this.confirmNotMultipleRegistrations = false,
      this.confirmPrivacyPolicy = false,
      this.joinWaitlistInProgress = false,
      this.personalLP = 0.0,
      this.resendConfirmationEmailInfo,
      this.failure})
      : super._();

  @override
  @JsonKey()
  final AirdropProcessStep airdropProcessStep;
  @override
  final String? mailAddress;
  @override
  @JsonKey()
  final bool confirmOnlyOneAirdrop;
  @override
  @JsonKey()
  final bool confirmNotMultipleRegistrations;
  @override
  @JsonKey()
  final bool confirmPrivacyPolicy;
  @override
  @JsonKey()
  final bool joinWaitlistInProgress;
  @override
  @JsonKey()
  final double personalLP;
  @override
  final String? resendConfirmationEmailInfo;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'AirdropFormState(airdropProcessStep: $airdropProcessStep, mailAddress: $mailAddress, confirmOnlyOneAirdrop: $confirmOnlyOneAirdrop, confirmNotMultipleRegistrations: $confirmNotMultipleRegistrations, confirmPrivacyPolicy: $confirmPrivacyPolicy, joinWaitlistInProgress: $joinWaitlistInProgress, personalLP: $personalLP, resendConfirmationEmailInfo: $resendConfirmationEmailInfo, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirdropFormStateImpl &&
            (identical(other.airdropProcessStep, airdropProcessStep) ||
                other.airdropProcessStep == airdropProcessStep) &&
            (identical(other.mailAddress, mailAddress) ||
                other.mailAddress == mailAddress) &&
            (identical(other.confirmOnlyOneAirdrop, confirmOnlyOneAirdrop) ||
                other.confirmOnlyOneAirdrop == confirmOnlyOneAirdrop) &&
            (identical(other.confirmNotMultipleRegistrations,
                    confirmNotMultipleRegistrations) ||
                other.confirmNotMultipleRegistrations ==
                    confirmNotMultipleRegistrations) &&
            (identical(other.confirmPrivacyPolicy, confirmPrivacyPolicy) ||
                other.confirmPrivacyPolicy == confirmPrivacyPolicy) &&
            (identical(other.joinWaitlistInProgress, joinWaitlistInProgress) ||
                other.joinWaitlistInProgress == joinWaitlistInProgress) &&
            (identical(other.personalLP, personalLP) ||
                other.personalLP == personalLP) &&
            (identical(other.resendConfirmationEmailInfo,
                    resendConfirmationEmailInfo) ||
                other.resendConfirmationEmailInfo ==
                    resendConfirmationEmailInfo) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      airdropProcessStep,
      mailAddress,
      confirmOnlyOneAirdrop,
      confirmNotMultipleRegistrations,
      confirmPrivacyPolicy,
      joinWaitlistInProgress,
      personalLP,
      resendConfirmationEmailInfo,
      failure);

  /// Create a copy of AirdropFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AirdropFormStateImplCopyWith<_$AirdropFormStateImpl> get copyWith =>
      __$$AirdropFormStateImplCopyWithImpl<_$AirdropFormStateImpl>(
          this, _$identity);
}

abstract class _AirdropFormState extends AirdropFormState {
  const factory _AirdropFormState(
      {final AirdropProcessStep airdropProcessStep,
      final String? mailAddress,
      final bool confirmOnlyOneAirdrop,
      final bool confirmNotMultipleRegistrations,
      final bool confirmPrivacyPolicy,
      final bool joinWaitlistInProgress,
      final double personalLP,
      final String? resendConfirmationEmailInfo,
      final Failure? failure}) = _$AirdropFormStateImpl;
  const _AirdropFormState._() : super._();

  @override
  AirdropProcessStep get airdropProcessStep;
  @override
  String? get mailAddress;
  @override
  bool get confirmOnlyOneAirdrop;
  @override
  bool get confirmNotMultipleRegistrations;
  @override
  bool get confirmPrivacyPolicy;
  @override
  bool get joinWaitlistInProgress;
  @override
  double get personalLP;
  @override
  String? get resendConfirmationEmailInfo;
  @override
  Failure? get failure;

  /// Create a copy of AirdropFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AirdropFormStateImplCopyWith<_$AirdropFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
