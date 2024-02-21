import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

final rpcSubscribeCurrentAccountCommandReceiver =
    RPCSubscriptionReceiverFactory<awc.SubscribeCurrentAccountRequest,
        awc.SubscribeAccountNotification?>.authenticated(
  decodeRequest: (_) => const awc.SubscribeCurrentAccountRequest(),
  encodeNotification: (notification) => notification?.toJson() ?? {},
);
