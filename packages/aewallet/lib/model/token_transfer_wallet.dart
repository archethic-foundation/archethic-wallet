/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// [TokenTransferWallet] represents the an asset transfer
class TokenTransferWallet extends TokenTransfer {
  TokenTransferWallet(
      {BigInt? amount, String? to, String? token, this.toContactName});
  String? toContactName;

  factory TokenTransferWallet.fromJson(Map<String, dynamic> json) =>
      TokenTransferWallet(
        amount:
            json['amount'] == null ? null : toBigInt(json['amount'].toDouble()),
        to: json['to'],
        token: json['token'],
        toContactName: json['toContactName'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'amount': amount,
        'to': to,
        'token': token,
        'toContactName': toContactName
      };
}
