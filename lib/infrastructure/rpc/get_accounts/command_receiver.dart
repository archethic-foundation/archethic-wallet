import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcGetAccountsCommandReceiverFactory = RPCCommandReceiverFactory<
    awc.GetAccountsRequest, awc.GetAccountsResult>.authenticated(
  decodeRequest: (dto) => const awc.GetAccountsRequest(),
  encodeResult: (model) => model.toJson(),
);
