import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'state.freezed.dart';

enum TransferType { uco, token, nft }

enum TransferProcessStep { form, confirmation }

@freezed
class TransferFormState with _$TransferFormState {
  const factory TransferFormState({
    @Default(TransferType.uco) TransferType transferType,
    required String seed,
    @Default(TransferProcessStep.form) TransferProcessStep transferProcessStep,
    required AsyncValue<double> feeEstimation,
    @Default(false) bool defineMaxAmountInProgress,
    @Default(0.0) double amount,
    // Amount converted in UCO if primary currency is native. Else in fiat currency
    @Default(0.0) double amountConverted,
    required double accountBalance,
    required TransferRecipient recipient,
    AccountToken? accountToken,
    @Default('') String message,
    @Default('') String errorAddressText,
    @Default('') String errorAmountText,
    @Default('') String errorMessageText,
  }) = _TransferFormState;
  const TransferFormState._();

  bool get isControlsOk =>
      errorAddressText == '' && errorAmountText == '' && errorMessageText == '';

  bool get canTransfer =>
      feeEstimation.value != null && feeEstimation.value! > 0;

  bool get showMaxAmountButton {
    final fees = feeEstimation.valueOrNull ?? 0;
    return (amount + fees) < accountBalance;
  }

  double get feeEstimationOrZero => feeEstimation.valueOrNull ?? 0;

  String symbol(BuildContext context) => transferType == TransferType.uco
      ? StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()
      : accountToken!.tokenInformations!.symbol!;
}

@freezed
class TransferRecipient with _$TransferRecipient {
  const TransferRecipient._();
  const factory TransferRecipient.address({
    required Address address,
  }) = _TransferDestinationAddress;
  const factory TransferRecipient.contact({
    required Contact contact,
  }) = _TransferDestinationContact;
  const factory TransferRecipient.unknownContact({
    required String name,
  }) = _TransferDestinationUnknownContact;

  Address? get address => when(
        address: (address) => address,
        contact: (contact) => Address(contact.address),
        unknownContact: (_) => null,
      );

  bool get isAddressValid => (address ?? const Address('')).isValid;
}
