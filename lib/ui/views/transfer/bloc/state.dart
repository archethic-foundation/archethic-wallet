/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
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
    @Default(0.0) double feeEstimation,
    @Default(false) bool canTransfer,
    @Default(0.0) double amount,
    required double accountBalance,
    required TransferRecipient recipient,
    AccountToken? accountToken,
    @Default('') String message,
    @Default('') String errorAddressText,
    @Default('') String errorAmountText,
    @Default('') String errorMessageText,
    Transaction? transaction,
  }) = _TransferFormState;
  const TransferFormState._();

  bool get isControlsOk =>
      errorAddressText == '' && errorAmountText == '' && errorMessageText == '';

  bool get isMaxAmount => (amount + feeEstimation) >= accountBalance;

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
}
