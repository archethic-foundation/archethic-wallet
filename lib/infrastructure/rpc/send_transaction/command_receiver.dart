import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcSendTransactionReceiverFactory = RPCCommandReceiverFactory<
    awc.SendTransactionRequest, awc.SendTransactionResult>.authenticated(
  decodeRequest: awc.SendTransactionRequest.fromJson,
  encodeResult: (model) => model.toJson(),
);
