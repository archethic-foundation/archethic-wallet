import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcGetCurrentAccountCommandReceiverFactory = RPCCommandReceiverFactory<
    awc.GetCurrentAccountRequest, awc.GetCurrentAccountResult>.authenticated(
  decodeRequest: (dto) => const awc.GetCurrentAccountRequest(),
  encodeResult: (model) => model.toJson(),
);
