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
mixin _$AirdropReferralStepData {
  int get maxReferrals => throw _privateConstructorUsedError;
  int get lpTokensLocked => throw _privateConstructorUsedError;

  /// Create a copy of AirdropReferralStepData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AirdropReferralStepDataCopyWith<AirdropReferralStepData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AirdropReferralStepDataCopyWith<$Res> {
  factory $AirdropReferralStepDataCopyWith(AirdropReferralStepData value,
          $Res Function(AirdropReferralStepData) then) =
      _$AirdropReferralStepDataCopyWithImpl<$Res, AirdropReferralStepData>;
  @useResult
  $Res call({int maxReferrals, int lpTokensLocked});
}

/// @nodoc
class _$AirdropReferralStepDataCopyWithImpl<$Res,
        $Val extends AirdropReferralStepData>
    implements $AirdropReferralStepDataCopyWith<$Res> {
  _$AirdropReferralStepDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AirdropReferralStepData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxReferrals = null,
    Object? lpTokensLocked = null,
  }) {
    return _then(_value.copyWith(
      maxReferrals: null == maxReferrals
          ? _value.maxReferrals
          : maxReferrals // ignore: cast_nullable_to_non_nullable
              as int,
      lpTokensLocked: null == lpTokensLocked
          ? _value.lpTokensLocked
          : lpTokensLocked // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AirdropReferralStepDataImplCopyWith<$Res>
    implements $AirdropReferralStepDataCopyWith<$Res> {
  factory _$$AirdropReferralStepDataImplCopyWith(
          _$AirdropReferralStepDataImpl value,
          $Res Function(_$AirdropReferralStepDataImpl) then) =
      __$$AirdropReferralStepDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int maxReferrals, int lpTokensLocked});
}

/// @nodoc
class __$$AirdropReferralStepDataImplCopyWithImpl<$Res>
    extends _$AirdropReferralStepDataCopyWithImpl<$Res,
        _$AirdropReferralStepDataImpl>
    implements _$$AirdropReferralStepDataImplCopyWith<$Res> {
  __$$AirdropReferralStepDataImplCopyWithImpl(
      _$AirdropReferralStepDataImpl _value,
      $Res Function(_$AirdropReferralStepDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AirdropReferralStepData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxReferrals = null,
    Object? lpTokensLocked = null,
  }) {
    return _then(_$AirdropReferralStepDataImpl(
      maxReferrals: null == maxReferrals
          ? _value.maxReferrals
          : maxReferrals // ignore: cast_nullable_to_non_nullable
              as int,
      lpTokensLocked: null == lpTokensLocked
          ? _value.lpTokensLocked
          : lpTokensLocked // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AirdropReferralStepDataImpl implements _AirdropReferralStepData {
  const _$AirdropReferralStepDataImpl(
      {required this.maxReferrals, required this.lpTokensLocked});

  @override
  final int maxReferrals;
  @override
  final int lpTokensLocked;

  @override
  String toString() {
    return 'AirdropReferralStepData(maxReferrals: $maxReferrals, lpTokensLocked: $lpTokensLocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirdropReferralStepDataImpl &&
            (identical(other.maxReferrals, maxReferrals) ||
                other.maxReferrals == maxReferrals) &&
            (identical(other.lpTokensLocked, lpTokensLocked) ||
                other.lpTokensLocked == lpTokensLocked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, maxReferrals, lpTokensLocked);

  /// Create a copy of AirdropReferralStepData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AirdropReferralStepDataImplCopyWith<_$AirdropReferralStepDataImpl>
      get copyWith => __$$AirdropReferralStepDataImplCopyWithImpl<
          _$AirdropReferralStepDataImpl>(this, _$identity);
}

abstract class _AirdropReferralStepData implements AirdropReferralStepData {
  const factory _AirdropReferralStepData(
      {required final int maxReferrals,
      required final int lpTokensLocked}) = _$AirdropReferralStepDataImpl;

  @override
  int get maxReferrals;
  @override
  int get lpTokensLocked;

  /// Create a copy of AirdropReferralStepData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AirdropReferralStepDataImplCopyWith<_$AirdropReferralStepDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AirdropPersonalStepData {
  int get lpTokensLocked => throw _privateConstructorUsedError;
  String get personalMultiplier => throw _privateConstructorUsedError;

  /// Create a copy of AirdropPersonalStepData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AirdropPersonalStepDataCopyWith<AirdropPersonalStepData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AirdropPersonalStepDataCopyWith<$Res> {
  factory $AirdropPersonalStepDataCopyWith(AirdropPersonalStepData value,
          $Res Function(AirdropPersonalStepData) then) =
      _$AirdropPersonalStepDataCopyWithImpl<$Res, AirdropPersonalStepData>;
  @useResult
  $Res call({int lpTokensLocked, String personalMultiplier});
}

/// @nodoc
class _$AirdropPersonalStepDataCopyWithImpl<$Res,
        $Val extends AirdropPersonalStepData>
    implements $AirdropPersonalStepDataCopyWith<$Res> {
  _$AirdropPersonalStepDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AirdropPersonalStepData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lpTokensLocked = null,
    Object? personalMultiplier = null,
  }) {
    return _then(_value.copyWith(
      lpTokensLocked: null == lpTokensLocked
          ? _value.lpTokensLocked
          : lpTokensLocked // ignore: cast_nullable_to_non_nullable
              as int,
      personalMultiplier: null == personalMultiplier
          ? _value.personalMultiplier
          : personalMultiplier // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AirdropPersonalStepDataImplCopyWith<$Res>
    implements $AirdropPersonalStepDataCopyWith<$Res> {
  factory _$$AirdropPersonalStepDataImplCopyWith(
          _$AirdropPersonalStepDataImpl value,
          $Res Function(_$AirdropPersonalStepDataImpl) then) =
      __$$AirdropPersonalStepDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int lpTokensLocked, String personalMultiplier});
}

/// @nodoc
class __$$AirdropPersonalStepDataImplCopyWithImpl<$Res>
    extends _$AirdropPersonalStepDataCopyWithImpl<$Res,
        _$AirdropPersonalStepDataImpl>
    implements _$$AirdropPersonalStepDataImplCopyWith<$Res> {
  __$$AirdropPersonalStepDataImplCopyWithImpl(
      _$AirdropPersonalStepDataImpl _value,
      $Res Function(_$AirdropPersonalStepDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AirdropPersonalStepData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lpTokensLocked = null,
    Object? personalMultiplier = null,
  }) {
    return _then(_$AirdropPersonalStepDataImpl(
      lpTokensLocked: null == lpTokensLocked
          ? _value.lpTokensLocked
          : lpTokensLocked // ignore: cast_nullable_to_non_nullable
              as int,
      personalMultiplier: null == personalMultiplier
          ? _value.personalMultiplier
          : personalMultiplier // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AirdropPersonalStepDataImpl implements _AirdropPersonalStepData {
  const _$AirdropPersonalStepDataImpl(
      {required this.lpTokensLocked, required this.personalMultiplier});

  @override
  final int lpTokensLocked;
  @override
  final String personalMultiplier;

  @override
  String toString() {
    return 'AirdropPersonalStepData(lpTokensLocked: $lpTokensLocked, personalMultiplier: $personalMultiplier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirdropPersonalStepDataImpl &&
            (identical(other.lpTokensLocked, lpTokensLocked) ||
                other.lpTokensLocked == lpTokensLocked) &&
            (identical(other.personalMultiplier, personalMultiplier) ||
                other.personalMultiplier == personalMultiplier));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, lpTokensLocked, personalMultiplier);

  /// Create a copy of AirdropPersonalStepData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AirdropPersonalStepDataImplCopyWith<_$AirdropPersonalStepDataImpl>
      get copyWith => __$$AirdropPersonalStepDataImplCopyWithImpl<
          _$AirdropPersonalStepDataImpl>(this, _$identity);
}

abstract class _AirdropPersonalStepData implements AirdropPersonalStepData {
  const factory _AirdropPersonalStepData(
          {required final int lpTokensLocked,
          required final String personalMultiplier}) =
      _$AirdropPersonalStepDataImpl;

  @override
  int get lpTokensLocked;
  @override
  String get personalMultiplier;

  /// Create a copy of AirdropPersonalStepData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AirdropPersonalStepDataImplCopyWith<_$AirdropPersonalStepDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AirdropFormState {
  AirdropProcessStep? get airdropProcessStep =>
      throw _privateConstructorUsedError;
  String? get mailAddress => throw _privateConstructorUsedError;
  String? get referralCodeProvided => throw _privateConstructorUsedError;
  bool get confirmOnlyOneAirdrop => throw _privateConstructorUsedError;
  bool get confirmNotMultipleRegistrations =>
      throw _privateConstructorUsedError;
  bool get confirmPrivacyPolicy => throw _privateConstructorUsedError;
  bool get joinWaitlistInProgress => throw _privateConstructorUsedError;
  bool get checkConfirmInProgress => throw _privateConstructorUsedError;
  double get personalLP => throw _privateConstructorUsedError;
  double get personalLPFlexible => throw _privateConstructorUsedError;
  int get personalMultiplier => throw _privateConstructorUsedError;
  int get referralMultiplier => throw _privateConstructorUsedError;
  int get referralsRegistered => throw _privateConstructorUsedError;
  int get referralsParticipant => throw _privateConstructorUsedError;
  String? get referralCode => throw _privateConstructorUsedError;
  String? get resendConfirmationEmailInfo => throw _privateConstructorUsedError;
  double get actualLPFiatValue => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
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
      {AirdropProcessStep? airdropProcessStep,
      String? mailAddress,
      String? referralCodeProvided,
      bool confirmOnlyOneAirdrop,
      bool confirmNotMultipleRegistrations,
      bool confirmPrivacyPolicy,
      bool joinWaitlistInProgress,
      bool checkConfirmInProgress,
      double personalLP,
      double personalLPFlexible,
      int personalMultiplier,
      int referralMultiplier,
      int referralsRegistered,
      int referralsParticipant,
      String? referralCode,
      String? resendConfirmationEmailInfo,
      double actualLPFiatValue,
      bool loading,
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
    Object? airdropProcessStep = freezed,
    Object? mailAddress = freezed,
    Object? referralCodeProvided = freezed,
    Object? confirmOnlyOneAirdrop = null,
    Object? confirmNotMultipleRegistrations = null,
    Object? confirmPrivacyPolicy = null,
    Object? joinWaitlistInProgress = null,
    Object? checkConfirmInProgress = null,
    Object? personalLP = null,
    Object? personalLPFlexible = null,
    Object? personalMultiplier = null,
    Object? referralMultiplier = null,
    Object? referralsRegistered = null,
    Object? referralsParticipant = null,
    Object? referralCode = freezed,
    Object? resendConfirmationEmailInfo = freezed,
    Object? actualLPFiatValue = null,
    Object? loading = null,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      airdropProcessStep: freezed == airdropProcessStep
          ? _value.airdropProcessStep
          : airdropProcessStep // ignore: cast_nullable_to_non_nullable
              as AirdropProcessStep?,
      mailAddress: freezed == mailAddress
          ? _value.mailAddress
          : mailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCodeProvided: freezed == referralCodeProvided
          ? _value.referralCodeProvided
          : referralCodeProvided // ignore: cast_nullable_to_non_nullable
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
      checkConfirmInProgress: null == checkConfirmInProgress
          ? _value.checkConfirmInProgress
          : checkConfirmInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      personalLP: null == personalLP
          ? _value.personalLP
          : personalLP // ignore: cast_nullable_to_non_nullable
              as double,
      personalLPFlexible: null == personalLPFlexible
          ? _value.personalLPFlexible
          : personalLPFlexible // ignore: cast_nullable_to_non_nullable
              as double,
      personalMultiplier: null == personalMultiplier
          ? _value.personalMultiplier
          : personalMultiplier // ignore: cast_nullable_to_non_nullable
              as int,
      referralMultiplier: null == referralMultiplier
          ? _value.referralMultiplier
          : referralMultiplier // ignore: cast_nullable_to_non_nullable
              as int,
      referralsRegistered: null == referralsRegistered
          ? _value.referralsRegistered
          : referralsRegistered // ignore: cast_nullable_to_non_nullable
              as int,
      referralsParticipant: null == referralsParticipant
          ? _value.referralsParticipant
          : referralsParticipant // ignore: cast_nullable_to_non_nullable
              as int,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
      resendConfirmationEmailInfo: freezed == resendConfirmationEmailInfo
          ? _value.resendConfirmationEmailInfo
          : resendConfirmationEmailInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      actualLPFiatValue: null == actualLPFiatValue
          ? _value.actualLPFiatValue
          : actualLPFiatValue // ignore: cast_nullable_to_non_nullable
              as double,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {AirdropProcessStep? airdropProcessStep,
      String? mailAddress,
      String? referralCodeProvided,
      bool confirmOnlyOneAirdrop,
      bool confirmNotMultipleRegistrations,
      bool confirmPrivacyPolicy,
      bool joinWaitlistInProgress,
      bool checkConfirmInProgress,
      double personalLP,
      double personalLPFlexible,
      int personalMultiplier,
      int referralMultiplier,
      int referralsRegistered,
      int referralsParticipant,
      String? referralCode,
      String? resendConfirmationEmailInfo,
      double actualLPFiatValue,
      bool loading,
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
    Object? airdropProcessStep = freezed,
    Object? mailAddress = freezed,
    Object? referralCodeProvided = freezed,
    Object? confirmOnlyOneAirdrop = null,
    Object? confirmNotMultipleRegistrations = null,
    Object? confirmPrivacyPolicy = null,
    Object? joinWaitlistInProgress = null,
    Object? checkConfirmInProgress = null,
    Object? personalLP = null,
    Object? personalLPFlexible = null,
    Object? personalMultiplier = null,
    Object? referralMultiplier = null,
    Object? referralsRegistered = null,
    Object? referralsParticipant = null,
    Object? referralCode = freezed,
    Object? resendConfirmationEmailInfo = freezed,
    Object? actualLPFiatValue = null,
    Object? loading = null,
    Object? failure = freezed,
  }) {
    return _then(_$AirdropFormStateImpl(
      airdropProcessStep: freezed == airdropProcessStep
          ? _value.airdropProcessStep
          : airdropProcessStep // ignore: cast_nullable_to_non_nullable
              as AirdropProcessStep?,
      mailAddress: freezed == mailAddress
          ? _value.mailAddress
          : mailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCodeProvided: freezed == referralCodeProvided
          ? _value.referralCodeProvided
          : referralCodeProvided // ignore: cast_nullable_to_non_nullable
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
      checkConfirmInProgress: null == checkConfirmInProgress
          ? _value.checkConfirmInProgress
          : checkConfirmInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      personalLP: null == personalLP
          ? _value.personalLP
          : personalLP // ignore: cast_nullable_to_non_nullable
              as double,
      personalLPFlexible: null == personalLPFlexible
          ? _value.personalLPFlexible
          : personalLPFlexible // ignore: cast_nullable_to_non_nullable
              as double,
      personalMultiplier: null == personalMultiplier
          ? _value.personalMultiplier
          : personalMultiplier // ignore: cast_nullable_to_non_nullable
              as int,
      referralMultiplier: null == referralMultiplier
          ? _value.referralMultiplier
          : referralMultiplier // ignore: cast_nullable_to_non_nullable
              as int,
      referralsRegistered: null == referralsRegistered
          ? _value.referralsRegistered
          : referralsRegistered // ignore: cast_nullable_to_non_nullable
              as int,
      referralsParticipant: null == referralsParticipant
          ? _value.referralsParticipant
          : referralsParticipant // ignore: cast_nullable_to_non_nullable
              as int,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
      resendConfirmationEmailInfo: freezed == resendConfirmationEmailInfo
          ? _value.resendConfirmationEmailInfo
          : resendConfirmationEmailInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      actualLPFiatValue: null == actualLPFiatValue
          ? _value.actualLPFiatValue
          : actualLPFiatValue // ignore: cast_nullable_to_non_nullable
              as double,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {this.airdropProcessStep,
      this.mailAddress,
      this.referralCodeProvided,
      this.confirmOnlyOneAirdrop = false,
      this.confirmNotMultipleRegistrations = false,
      this.confirmPrivacyPolicy = false,
      this.joinWaitlistInProgress = false,
      this.checkConfirmInProgress = false,
      this.personalLP = 0.0,
      this.personalLPFlexible = 0.0,
      this.personalMultiplier = 0,
      this.referralMultiplier = 0,
      this.referralsRegistered = 0,
      this.referralsParticipant = 0,
      this.referralCode,
      this.resendConfirmationEmailInfo,
      this.actualLPFiatValue = 0.0,
      this.loading = false,
      this.failure})
      : super._();

  @override
  final AirdropProcessStep? airdropProcessStep;
  @override
  final String? mailAddress;
  @override
  final String? referralCodeProvided;
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
  final bool checkConfirmInProgress;
  @override
  @JsonKey()
  final double personalLP;
  @override
  @JsonKey()
  final double personalLPFlexible;
  @override
  @JsonKey()
  final int personalMultiplier;
  @override
  @JsonKey()
  final int referralMultiplier;
  @override
  @JsonKey()
  final int referralsRegistered;
  @override
  @JsonKey()
  final int referralsParticipant;
  @override
  final String? referralCode;
  @override
  final String? resendConfirmationEmailInfo;
  @override
  @JsonKey()
  final double actualLPFiatValue;
  @override
  @JsonKey()
  final bool loading;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'AirdropFormState(airdropProcessStep: $airdropProcessStep, mailAddress: $mailAddress, referralCodeProvided: $referralCodeProvided, confirmOnlyOneAirdrop: $confirmOnlyOneAirdrop, confirmNotMultipleRegistrations: $confirmNotMultipleRegistrations, confirmPrivacyPolicy: $confirmPrivacyPolicy, joinWaitlistInProgress: $joinWaitlistInProgress, checkConfirmInProgress: $checkConfirmInProgress, personalLP: $personalLP, personalLPFlexible: $personalLPFlexible, personalMultiplier: $personalMultiplier, referralMultiplier: $referralMultiplier, referralsRegistered: $referralsRegistered, referralsParticipant: $referralsParticipant, referralCode: $referralCode, resendConfirmationEmailInfo: $resendConfirmationEmailInfo, actualLPFiatValue: $actualLPFiatValue, loading: $loading, failure: $failure)';
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
            (identical(other.referralCodeProvided, referralCodeProvided) ||
                other.referralCodeProvided == referralCodeProvided) &&
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
            (identical(other.checkConfirmInProgress, checkConfirmInProgress) ||
                other.checkConfirmInProgress == checkConfirmInProgress) &&
            (identical(other.personalLP, personalLP) ||
                other.personalLP == personalLP) &&
            (identical(other.personalLPFlexible, personalLPFlexible) ||
                other.personalLPFlexible == personalLPFlexible) &&
            (identical(other.personalMultiplier, personalMultiplier) ||
                other.personalMultiplier == personalMultiplier) &&
            (identical(other.referralMultiplier, referralMultiplier) ||
                other.referralMultiplier == referralMultiplier) &&
            (identical(other.referralsRegistered, referralsRegistered) ||
                other.referralsRegistered == referralsRegistered) &&
            (identical(other.referralsParticipant, referralsParticipant) ||
                other.referralsParticipant == referralsParticipant) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.resendConfirmationEmailInfo,
                    resendConfirmationEmailInfo) ||
                other.resendConfirmationEmailInfo ==
                    resendConfirmationEmailInfo) &&
            (identical(other.actualLPFiatValue, actualLPFiatValue) ||
                other.actualLPFiatValue == actualLPFiatValue) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        airdropProcessStep,
        mailAddress,
        referralCodeProvided,
        confirmOnlyOneAirdrop,
        confirmNotMultipleRegistrations,
        confirmPrivacyPolicy,
        joinWaitlistInProgress,
        checkConfirmInProgress,
        personalLP,
        personalLPFlexible,
        personalMultiplier,
        referralMultiplier,
        referralsRegistered,
        referralsParticipant,
        referralCode,
        resendConfirmationEmailInfo,
        actualLPFiatValue,
        loading,
        failure
      ]);

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
      {final AirdropProcessStep? airdropProcessStep,
      final String? mailAddress,
      final String? referralCodeProvided,
      final bool confirmOnlyOneAirdrop,
      final bool confirmNotMultipleRegistrations,
      final bool confirmPrivacyPolicy,
      final bool joinWaitlistInProgress,
      final bool checkConfirmInProgress,
      final double personalLP,
      final double personalLPFlexible,
      final int personalMultiplier,
      final int referralMultiplier,
      final int referralsRegistered,
      final int referralsParticipant,
      final String? referralCode,
      final String? resendConfirmationEmailInfo,
      final double actualLPFiatValue,
      final bool loading,
      final Failure? failure}) = _$AirdropFormStateImpl;
  const _AirdropFormState._() : super._();

  @override
  AirdropProcessStep? get airdropProcessStep;
  @override
  String? get mailAddress;
  @override
  String? get referralCodeProvided;
  @override
  bool get confirmOnlyOneAirdrop;
  @override
  bool get confirmNotMultipleRegistrations;
  @override
  bool get confirmPrivacyPolicy;
  @override
  bool get joinWaitlistInProgress;
  @override
  bool get checkConfirmInProgress;
  @override
  double get personalLP;
  @override
  double get personalLPFlexible;
  @override
  int get personalMultiplier;
  @override
  int get referralMultiplier;
  @override
  int get referralsRegistered;
  @override
  int get referralsParticipant;
  @override
  String? get referralCode;
  @override
  String? get resendConfirmationEmailInfo;
  @override
  double get actualLPFiatValue;
  @override
  bool get loading;
  @override
  Failure? get failure;

  /// Create a copy of AirdropFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AirdropFormStateImplCopyWith<_$AirdropFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
