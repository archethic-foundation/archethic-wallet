import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcOpenSessionChallengeCommandReceiverFactory = RPCCommandReceiverFactory<
    awc.OpenSessionChallengeRequest,
    awc.OpenSessionChallengeResponse>.authenticated(
  decodeRequest: awc.OpenSessionChallengeRequest.fromJson,
  encodeResult: (model) => model.toJson(),
);
