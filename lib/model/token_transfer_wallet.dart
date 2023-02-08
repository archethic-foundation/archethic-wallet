/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

/// [TokenTransferWallet] represents the an asset transfer
part 'token_transfer_wallet.freezed.dart';
part 'token_transfer_wallet.g.dart';

@freezed
class TokenTransferWallet with _$TokenTransferWallet {
  const factory TokenTransferWallet({
    int? amount,
    String? to,
    String? tokenAddress,
    int? tokenId,
    String? toContactName,
  }) = _TokenTransferWallet;
  const TokenTransferWallet._();

  factory TokenTransferWallet.fromJson(Map<String, dynamic> json) =>
      _$TokenTransferWalletFromJson(json);
}
