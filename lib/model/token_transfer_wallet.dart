/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// [TokenTransferWallet] represents the an asset transfer
class TokenTransferWallet extends TokenTransfer {
  TokenTransferWallet({
    super.amount,
    super.to,
    super.tokenAddress,
    super.tokenId,
    this.toContactName,
  });
  String? toContactName;
}
