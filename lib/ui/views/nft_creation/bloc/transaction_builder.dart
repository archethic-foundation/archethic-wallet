import 'package:archethic_lib_dart/archethic_lib_dart.dart';

extension NftTransactionBuilder on Transaction {
  /// Builds a NFT Creation Transaction
  static Transaction build({
    required String? tokenName,
    required String? tokenSymbol,
    required double tokenInitialSupply,
    required Map<String, dynamic> tokenProperties,
    required String serviceName,
    required Keychain keychain,
    required int index,
    required String originPrivateKey,
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

    return keychain
        .buildTransaction(
          transaction,
          serviceName,
          index,
        )
        .originSign(originPrivateKey);
  }
}
