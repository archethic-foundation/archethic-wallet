import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcGetEndpointCommandReceiverFactory = RPCCommandReceiverFactory<
    awc.GetEndpointRequest, awc.GetEndpointResult>.authenticated(
  decodeRequest: (dto) => const awc.GetEndpointRequest(),
  encodeResult: (model) => model.toJson(),
);
