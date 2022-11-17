/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:freezed_annotation/freezed_annotation.dart';

/// [TransactionInputWithTxAddress] represents the inputs from the transaction with transaction address.

part 'transaction_input_with_tx_address.freezed.dart';
part 'transaction_input_with_tx_address.g.dart';

@freezed
class TransactionInputWithTxAddress with _$TransactionInputWithTxAddress {
  const factory TransactionInputWithTxAddress({
    /// Transaction address
    @Default('') String txAddress,

    /// Amount: asset amount
    @Default(0) int amount,

    /// From: transaction which send the amount of assets
    @Default('') String from,

    /// token address: address of the token if the type is token
    String? tokenAddress,

    /// Spent: determines if the input has been spent
    @Default(true) bool spent,

    /// Timestamp: Date time when the inputs was generated
    @Default(0) int timestamp,

    /// Type: UCO/Token/Call
    String? type,

    /// Token id: It is the id for a token which is allocated when the token is minted.
    int? tokenId,
  }) = _TransactionInputWithTxAddress;
  const TransactionInputWithTxAddress._();

  factory TransactionInputWithTxAddress.fromJson(Map<String, dynamic> json) =>
      _$TransactionInputWithTxAddressFromJson(json);
}
