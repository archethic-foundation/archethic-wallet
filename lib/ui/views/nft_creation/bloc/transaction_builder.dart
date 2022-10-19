import 'package:archethic_lib_dart/archethic_lib_dart.dart';

extension TokenTransactionBuilder on Transaction {
  /// Builds a Token transfer Transaction
  static Transaction build({
    required Keychain keychain,
    required String serviceName,
    required String originPrivateKey,
    required int index,
    required String? tokenName,
    required double tokenInitialSupply,
    required String? tokenSymbol,
    required Map<String, dynamic> tokenProperties,
  }) {
    final transaction = Transaction(
      type: 'token',
      data: Transaction.initData(),
    );

    final token = Token(
      name: tokenName,
      supply: toBigInt(tokenInitialSupply),
      type: 'non-fungible',
      symbol: tokenSymbol,
      tokenProperties: tokenProperties,
    );

    final content = tokenToJsonForTxDataContent(
      token,
    );
    transaction.setContent(content);

    transaction.address = uint8ListToHex(
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
