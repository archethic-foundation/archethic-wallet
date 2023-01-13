/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/domain/models/transfer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

/// Represents a transaction, blockchain agnostic.
@freezed
class Transaction with _$Transaction {
  const Transaction._();
  const factory Transaction.transfer({
    required Transfer transfer,
  }) = _TransactionTransfer;

  const factory Transaction.token({
    required Token token,
  }) = _TransactionToken;

  const factory Transaction.keychain({
    required String seed,
    required String name,
  }) = _TransactionKeychain;
}
