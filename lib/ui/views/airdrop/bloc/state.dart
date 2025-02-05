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
class AirdropFormState with _$AirdropFormState {
  const factory AirdropFormState({
    @Default(AirdropProcessStep.welcome) AirdropProcessStep airdropProcessStep,
    String? mailAddress,
    @Default(false) bool confirmOnlyOneAirdrop,
    @Default(false) bool confirmNotMultipleRegistrations,
    @Default(false) bool confirmPrivacyPolicy,
    @Default(false) bool joinWaitlistInProgress,
    @Default(0.0) double personalLP,
    String? resendConfirmationEmailInfo,
    Failure? failure,
  }) = _AirdropFormState;
  const AirdropFormState._();

  bool get isItemsConfirmed =>
      confirmOnlyOneAirdrop == true &&
      confirmNotMultipleRegistrations == true &&
      confirmPrivacyPolicy == true &&
      failure == null &&
      mailAddress != null &&
      mailAddress!.isNotEmpty &&
      EmailValidator.validate(mailAddress!);
}
