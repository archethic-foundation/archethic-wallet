/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/contact.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
class Transfer with _$Transfer {
  const factory Transfer({
    @Default(0.0) double feeEstimation,
    @Default(false) bool canTransfer,
    @Default(0.0) double amount,
    @Default('') String addressRecipient,
    Contact? contactRecipient,
    @Default('') String message,
    @Default(false) bool isMaxSend,
    @Default(false) bool isContact,
    Transaction? transaction,
  }) = _Transfer;
  const Transfer._();
}
