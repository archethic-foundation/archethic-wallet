import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcKeychainDeriveAddressReceiverFactory = RPCCommandReceiverFactory<
    awc.KeychainDeriveAddressRequest,
    awc.KeychainDeriveAddressResult>.authenticated(
  decodeRequest: awc.KeychainDeriveAddressRequest.fromJson,
  encodeResult: (model) => model.toJson(),
);
