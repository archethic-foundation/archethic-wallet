/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

enum TransferType { uco, token, nft }

enum TransferProcessStep { form, confirmation }

@freezed
class TransferFormData with _$TransferFormData {
  const factory TransferFormData({
    @Default(TransferType.uco) TransferType transferType,
    @Default(TransferProcessStep.form) TransferProcessStep transferProcessStep,
    @Default(0.0) double feeEstimation,
    @Default(false) bool canTransfer,
    @Default(0.0) double amount,
    @Default('') String symbol,
    @Default('') String addressRecipient,
    Contact? contactRecipient,
    AccountToken? accountToken,
    @Default('') String message,
    @Default(false) bool isMaxSend,
    @Default(false) bool isContactKnown,
    @Default('') String errorAddressText,
    @Default('') String errorAmountText,
    @Default('') String errorMessageText,
    Transaction? transaction,
  }) = _TransferFormData;
  const TransferFormData._();

  bool get isControlsOk =>
      errorAddressText == '' && errorAmountText == '' && errorMessageText == '';
}
