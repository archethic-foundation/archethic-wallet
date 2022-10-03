/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// [UCOTransferWallet] represents the an asset transfer
class UCOTransferWallet extends UCOTransfer {
  UCOTransferWallet({super.amount, super.to, this.toContactName});

  factory UCOTransferWallet.fromJson(Map<String, dynamic> json) =>
      UCOTransferWallet(
        amount:
            json['amount'] == null ? null : toBigInt(json['amount'].toDouble()),
        to: json['to'],
        toContactName: json['toContactName'],
      );

  String? toContactName;

  @override
  Map<String, dynamic> toJson() =>
      {'amount': amount, 'to': to, 'toContactName': toContactName};
}
