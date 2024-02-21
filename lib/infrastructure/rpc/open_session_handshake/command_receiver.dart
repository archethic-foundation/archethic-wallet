import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcOpenSessionHandshakeCommandReceiverFactory = RPCCommandReceiverFactory<
    awc.OpenSessionHandshakeRequest,
    awc.OpenSessionHandshakeResponse>.anonymous(
  decodeRequest: awc.OpenSessionHandshakeRequest.fromJson,
  encodeResult: (model) => model.toJson(),
);
