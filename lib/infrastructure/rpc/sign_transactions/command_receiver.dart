import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcSignTransactionReceiverFactory = RPCCommandReceiverFactory<
    awc.SignTransactionRequest, awc.SignTransactionsResult>.authenticated(
  decodeRequest: awc.SignTransactionRequest.fromJson,
  encodeResult: (model) => model.toJson(),
);
