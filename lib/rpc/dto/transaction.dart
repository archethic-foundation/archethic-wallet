/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/rpc/dto/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

/// Represents a transaction, blockchain agnostic.
@freezed
class TransactionDTO with _$TransactionDTO {
  const TransactionDTO._();
  // const factory TransactionDTO.transfer({
  //   required TransferDTO transfer,
  // }) = _TransactionDTOTransfer;

  const factory TransactionDTO.token({
    required TokenDTO token,
  }) = _TransactionDTOToken;

  // const factory TransactionDTO.keychain({
  //   required String seed,
  //   required String name,
  // }) = _TransactionDTOKeychain;

  factory TransactionDTO.fromJson(Map<String, dynamic> json) =>
      _$TransactionDTOFromJson(json);
}
