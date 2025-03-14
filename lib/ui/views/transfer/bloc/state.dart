import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

enum TransferType { uco, token, nft }

enum TransferProcessStep { form, confirmation }

@freezed
class TransferFormState with _$TransferFormState {
  const factory TransferFormState({
    TransferType? transferType,
    @Default(TransferProcessStep.form) TransferProcessStep transferProcessStep,

    // TODO(reddwarf03): too complicated to manage by hand in [TransferFormNotifier]. Use a small dedicated [FutureProvider] (3)
    required AsyncValue<double> feeEstimation,
    @Default(false) bool defineMaxAmountInProgress,
    @Default(0.0) double amount,
    required TransferRecipient recipient,
    AEToken? aeToken,
    AccountToken? accountToken,
    @Default('') String tokenId,
    @Default('') String message,
    @Default('') String errorAddressText,
    @Default('') String errorAmountText,
    @Default('') String errorMessageText,
  }) = _TransferFormState;
  const TransferFormState._();

  bool get isControlsOk =>
      errorAddressText == '' && errorAmountText == '' && errorMessageText == '';

  bool get canTransfer =>
      feeEstimation.value != null && feeEstimation.value! > 0 && isControlsOk;

  double get feeEstimationOrZero => feeEstimation.valueOrNull ?? 0;

  String symbol(BuildContext context) {
    if (transferType == null) {
      return '';
    }

    return transferType == TransferType.uco
        ? AccountBalance.cryptoCurrencyLabel
        : aeToken!.isLpToken == true
            ? 'LP Token'
            : aeToken!.symbol;
  }

  String symbolFees(BuildContext context) => AccountBalance.cryptoCurrencyLabel;
}

@freezed
class TransferRecipient with _$TransferRecipient {
  factory TransferRecipient.fromJson(Map<String, dynamic> json) =>
      _$TransferRecipientFromJson(json);
  const TransferRecipient._();
  const factory TransferRecipient.address({
    @AddressJsonConverter() required Address address,
  }) = _TransferDestinationAddress;
  const factory TransferRecipient.account({
    @AccountConverter() required Account account,
  }) = _TransferDestinationContact;
  const factory TransferRecipient.unknownContact({
    required String name,
  }) = _TransferDestinationUnknownContact;

  Address? get address => when(
        address: (address) => address,
        account: (account) => Address(address: account.genesisAddress),
        unknownContact: (_) => null,
      );

  bool get isAddressValid => (address ?? const Address(address: '')).isValid();
}
