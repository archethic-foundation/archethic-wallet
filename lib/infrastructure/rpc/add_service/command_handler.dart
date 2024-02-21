import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcAddServiceReceiverFactory = RPCCommandReceiverFactory<
    awc.AddServiceRequest, awc.SendTransactionResult>.authenticated(
  decodeRequest: awc.AddServiceRequest.fromJson,
  encodeResult: (model) => model.toJson(),
);
