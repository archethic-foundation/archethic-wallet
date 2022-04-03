/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// [NFTTransferWallet] represents the an asset transfer
class NFTTransferWallet extends NFTTransfer {
  NFTTransferWallet(
      {BigInt? amount, String? to, String? nft, this.toContactName});
  String? toContactName;

  factory NFTTransferWallet.fromJson(Map<String, dynamic> json) =>
      NFTTransferWallet(
        amount:
            json['amount'] == null ? null : toBigInt(json['amount'].toDouble()),
        to: json['to'],
        nft: json['nft'],
        toContactName: json['toContactName'],
      );

  @override
  Map<String, dynamic> toJson() =>
      {'amount': amount, 'to': to, 'nft': nft, 'toContactName': toContactName};
}
