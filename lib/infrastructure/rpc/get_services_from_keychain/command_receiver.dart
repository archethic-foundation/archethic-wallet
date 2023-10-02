import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcGetServicesFromKeychainReceiverFactory = RPCCommandReceiverFactory<
    awc.GetServicesFromKeychainRequest,
    awc.GetServicesFromKeychainResult>.authenticated(
  decodeRequest: (dto) => const awc.GetServicesFromKeychainRequest(),
  encodeResult: (model) => model.toJson(),
);
