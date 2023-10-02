import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcRefreshCurrentAccountCommandReceiverFactory =
    RPCCommandReceiverFactory<awc.RefreshCurrentAccountRequest,
        awc.RefreshCurrentAccountResponse>.authenticated(
  decodeRequest: (dto) => const awc.RefreshCurrentAccountRequest(),
  encodeResult: (model) => model.toJson(),
);
