import 'dart:async';

import 'package:deeplink_rpc/deeplink_rpc.dart';
import 'package:url_launcher/url_launcher.dart';

class AEWalletRPCClient {
  late final _runningRequests = <String, Completer<DeeplinkRpcResponse>>{};

  late final DeeplinkRpcResponseReceiver _deeplinkRpcReceiver;

  AEWalletRPCClient() {
    _deeplinkRpcReceiver = DeeplinkRpcResponseReceiver()
      ..registerHandler(
        DeeplinkRpcResponseHandler(
          route: const DeeplinkRpcRoute('aewallet_response'),
          handle: (response) {
            final requestCompleter = _runningRequests[response.id];

            if (requestCompleter == null) return;

            requestCompleter.complete(response);

            _runningRequests.remove(response.id);
          },
        ),
      );
  }

  bool handleRoute(String? path) {
    if (!_deeplinkRpcReceiver.canHandle(path)) return false;

    _deeplinkRpcReceiver.handle(path);
    return true;
  }

  Future<DeeplinkRpcResponse> signTransaction({
    required String id,
    required String replyUrl,
    required Map<String, dynamic> params,
  }) async {
    if (_runningRequests.containsKey(id)) {
      return DeeplinkRpcResponse.failure(
        id: id,
        failure: DeeplinkRpcFailure(
          code: DeeplinkRpcFailure.kInvalidRequest,
          message: 'A request with id $id already running.',
        ),
      );
    }

    final rpcRequest = DeeplinkRpcRequest(
      id: id,
      replyUrl: replyUrl,
      params: params,
    );

    await launchUrl(
      Uri.parse(
        'aewallet://wallet.archethic.net/sign_transaction/${rpcRequest.encode()}',
      ),
      mode: LaunchMode.externalApplication,
    );

    final requestCompleter = Completer<DeeplinkRpcResponse>();
    _runningRequests[id] = requestCompleter;

    return requestCompleter.future;
  }
}
