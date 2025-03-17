import 'package:aewallet/domain/models/core/failures.dart';
import 'package:email_validator/email_validator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum AirdropProcessStep {
  welcome,
  joinWaitlist,
  confirmEmail,
  supportEcosystem,
  sign,
  congrats
}

@freezed
class AirdropReferralStepData with _$AirdropReferralStepData {
  const factory AirdropReferralStepData({
    required int maxReferrals,
    required int lpTokensLocked,
  }) = _AirdropReferralStepData;
}

@freezed
class AirdropPersonalStepData with _$AirdropPersonalStepData {
  const factory AirdropPersonalStepData({
    required int lpTokensLocked,
    required String personalMultiplier,
  }) = _AirdropPersonalStepData;
}

final airdropReferralStepDataList = [
  const AirdropReferralStepData(maxReferrals: 0, lpTokensLocked: 0),
  const AirdropReferralStepData(maxReferrals: 1, lpTokensLocked: 1),
  const AirdropReferralStepData(maxReferrals: 2, lpTokensLocked: 5),
  const AirdropReferralStepData(maxReferrals: 3, lpTokensLocked: 20),
  const AirdropReferralStepData(maxReferrals: 5, lpTokensLocked: 60),
  const AirdropReferralStepData(
    maxReferrals: 10,
    lpTokensLocked: 150,
  ),
  const AirdropReferralStepData(
    maxReferrals: 20,
    lpTokensLocked: 300,
  ),
  const AirdropReferralStepData(
    maxReferrals: 40,
    lpTokensLocked: 500,
  ),
  const AirdropReferralStepData(
    maxReferrals: 100,
    lpTokensLocked: 750,
  ),
  const AirdropReferralStepData(
    maxReferrals: 1000,
    lpTokensLocked: 1000,
  ),
];

final airdropPersonalStepDataList = [
  const AirdropPersonalStepData(
    lpTokensLocked: 0,
    personalMultiplier: '0x',
  ),
  const AirdropPersonalStepData(
    lpTokensLocked: 1,
    personalMultiplier: '1x',
  ),
  const AirdropPersonalStepData(
    lpTokensLocked: 5,
    personalMultiplier: '2x',
  ),
  const AirdropPersonalStepData(
    lpTokensLocked: 20,
    personalMultiplier: '3x',
  ),
  const AirdropPersonalStepData(
    lpTokensLocked: 60,
    personalMultiplier: '5x',
  ),
  const AirdropPersonalStepData(
    lpTokensLocked: 150,
    personalMultiplier: '8x',
  ),
  const AirdropPersonalStepData(
    lpTokensLocked: 300,
    personalMultiplier: '13x',
  ),
  const AirdropPersonalStepData(
    lpTokensLocked: 500,
    personalMultiplier: '21x',
  ),
  const AirdropPersonalStepData(
    lpTokensLocked: 750,
    personalMultiplier: '34x',
  ),
  const AirdropPersonalStepData(
    lpTokensLocked: 1000,
    personalMultiplier: '55x',
  ),
];

@freezed
class AirdropFormState with _$AirdropFormState {
  const factory AirdropFormState({
    AirdropProcessStep? airdropProcessStep,
    String? mailAddress,
    String? referralCodeProvided,
    @Default(false) bool confirmOnlyOneAirdrop,
    @Default(false) bool confirmNotMultipleRegistrations,
    @Default(false) bool confirmPrivacyPolicy,
    @Default(false) bool joinWaitlistInProgress,
    @Default(false) bool checkConfirmInProgress,
    @Default(0.0) double personalLP,
    @Default(0.0) double personalLPFlexible,
    @Default(0) int personalMultiplier,
    @Default(0) int referralMultiplier,
    @Default(0) int referralsRegistered,
    @Default(0) int referralsParticipant,
    String? referralCode,
    String? resendConfirmationEmailInfo,
    @Default(0.0) double actualLPFiatValue,
    @Default(false) bool loading,
    Failure? failure,
  }) = _AirdropFormState;
  const AirdropFormState._();

  int get totalUserMultiplier => personalMultiplier + referralMultiplier;

  bool get isItemsConfirmed =>
      confirmOnlyOneAirdrop == true &&
      confirmNotMultipleRegistrations == true &&
      confirmPrivacyPolicy == true &&
      failure == null &&
      mailAddress != null &&
      mailAddress!.isNotEmpty &&
      EmailValidator.validate(mailAddress!) &&
      !mailAddress!.contains('+');

  int get referralsParticipantMax {
    return airdropReferralStepDataList
        .lastWhere(
          (data) => data.lpTokensLocked <= personalLP,
          orElse: () => airdropReferralStepDataList.first,
        )
        .maxReferrals;
  }
}
