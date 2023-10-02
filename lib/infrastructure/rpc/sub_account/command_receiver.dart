import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcSubscribeAccountCommandReceiver = RPCSubscriptionReceiverFactory<
    awc.SubscribeAccountRequest,
    awc.SubscribeAccountNotification>.authenticated(
  decodeRequest: awc.SubscribeAccountRequest.fromJson,
  encodeNotification: (notification) => notification?.toJson() ?? {},
);
