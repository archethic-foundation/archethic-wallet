import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcKeychainDeriveKeypairReceiverFactory = RPCCommandReceiverFactory<
    awc.KeychainDeriveKeypairRequest,
    awc.KeychainDeriveKeypairResult>.authenticated(
  decodeRequest: awc.KeychainDeriveKeypairRequest.fromJson,
  encodeResult: (model) => model.toJson(),
);
