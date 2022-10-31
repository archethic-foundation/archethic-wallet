/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

extension AddTokenTransactionBuilder on archethic.Transaction {
  /// Builds a creation of token Transaction
  static archethic.Transaction build({
    required String? tokenName,
    required double tokenInitialSupply,
    required String? tokenSymbol,
    required String serviceName,
    required archethic.Keychain keychain,
    required int index,
    required String originPrivateKey,
  }) {
    final transaction = archethic.Transaction(
      type: 'token',
      data: archethic.Transaction.initData(),
    );

    final token = archethic.Token(
      name: tokenName,
      supply: archethic.toBigInt(tokenInitialSupply),
      type: 'fungible',
      symbol: tokenSymbol,
      tokenProperties: {},
    );

    final content = archethic.tokenToJsonForTxDataContent(
      token,
    );
    transaction.setContent(content);

    transaction.address = archethic.uint8ListToHex(
      keychain.deriveAddress(
        serviceName,
        index: index + 1,
      ),
    );

    return keychain
        .buildTransaction(
          transaction,
          serviceName,
          index,
        )
        .originSign(originPrivateKey);
  }
}
