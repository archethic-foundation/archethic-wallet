/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

/// [UCOTransferWallet] represents the an asset transfer
part 'uco_transfer_wallet.freezed.dart';
part 'uco_transfer_wallet.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class UCOTransferWallet with _$UCOTransferWallet {
  const factory UCOTransferWallet({
    int? amount,
    String? to,
    String? toContactName,
  }) = _UCOTransferWallet;
  const UCOTransferWallet._();

  factory UCOTransferWallet.fromJson(Map<String, dynamic> json) =>
      _$UCOTransferWalletFromJson(json);
}
