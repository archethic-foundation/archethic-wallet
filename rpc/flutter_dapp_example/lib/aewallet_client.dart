import 'dart:async';

import 'package:deeplink_rpc/deeplink_rpc.dart';

class AEWalletRPCClient {
  final _deeplinkRpcClient = DeeplinkRpcClient();

  bool handleRoute(String? path) => _deeplinkRpcClient.handleRoute(path);

  Future<DeeplinkRpcResponse> signTransaction({
    required String id,
    required Map<String, dynamic> params,
  }) async =>
      _deeplinkRpcClient.send(
        request: DeeplinkRpcRequest(
          requestUrl: 'aewallet://wallet.archethic.net/send_transaction',
          replyUrl: "flutterdappexample://dapp.example/aewallet_response",
          params: params,
        ),
      );
}
