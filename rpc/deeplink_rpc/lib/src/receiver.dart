import 'dart:developer';

import 'package:deeplink_rpc/src/data/failure.dart';
import 'package:deeplink_rpc/src/data/request.dart';
import 'package:deeplink_rpc/src/data/response.dart';
import 'package:deeplink_rpc/src/data/result.dart';
import 'package:deeplink_rpc/src/handler.dart';
import 'package:url_launcher/url_launcher.dart';

/// Test deeplink :
/// xcrun simctl openurl booted aewallet://wallet.archethic.net/sign_transaction/H4sIAAAAAAAAA2VQMW7DMAz8isFZre2OHjMU6JIu6RRnUGTGESqTqiQ3MAz/vSRqdKkW6u7Iw5Er+AE6+HpgKgsYSBjD8pECdBXcS4m5q+uReQz47HiqoTIVRJvslKFbIfOcHMr8G2WeyFtxsM7xTOVoJxUO7wfhyhIVFP5EEviNKXsm6FoDgy1WrRxTQSrStVY9kEz3kqGH4+upapq2ByMgz1HiqdA2+1Na7X+7ienpNtPorwH3kWW6cvjz2o0s+qjc+eWiMCaOcgCPWcl12ySk40Ezy48fJIHvPsrO54uBgMOISUPPjrWUZCnfpEf1zex7/hM2Pa/z0cueO7P9AHpG2+OAAQAA
class DeeplinkRpcReceiver {
  DeeplinkRpcReceiver();

  static const _logName = 'DeeplinkRpcRequest';

  final Set<DeeplinkRpcHandler> _routeHandlers = {};

  DeeplinkRpcHandler? _handlerForPath(String? path) {
    if (path == null) return null;
    return _routeHandlers.cast<DeeplinkRpcHandler?>().firstWhere(
          (handler) => handler?.route.matches(path) ?? false,
          orElse: () => null,
        );
  }

  void registerHandler(DeeplinkRpcHandler handler) {
    _routeHandlers.add(handler);
  }

  bool canHandle(String? path) {
    if (path == null) return false;

    return _handlerForPath(path) != null;
  }

  Future<DeeplinkRpcResult> _handle(String? path) async {
    try {
      log(
        'Handles RPC call',
        name: _logName,
      );

      final handler = _handlerForPath(path);
      if (handler == null) {
        throw DeeplinkRpcFailure(
          code: DeeplinkRpcFailure.kInvalidRequest,
          message: 'No handler for path $path',
        );
      }

      final data = handler.route.getData(path);

      if (data == null) {
        throw const DeeplinkRpcFailure(
          code: DeeplinkRpcFailure.kInvalidRequest,
          message: 'Failed to extract data from path',
        );
      }

      final request = DeeplinkRpcRequest.decode(data);

      final result = await handler.handle(request);

      log(
        'RPC call handled',
        name: _logName,
      );
      return DeeplinkRpcResult.success(
        request: request,
        result: result,
      );
    } on DeeplinkRpcFailure catch (e, stack) {
      log(
        'An error occured',
        error: e,
        stackTrace: stack,
        name: _logName,
      );

      return DeeplinkRpcResult.failure(failure: e);
    } catch (e, stack) {
      log(
        'An error occured',
        error: e,
        stackTrace: stack,
        name: _logName,
      );
      return DeeplinkRpcResult.failure(
        failure: DeeplinkRpcFailure(
          code: DeeplinkRpcFailure.kServerError,
        ),
      );
    }
  }

  Future<void> handle(String? path) async {
    final result = await _handle(path);

    final request = result.request;
    final response = result.toResponse();
    if (request == null || response == null) {
      log(
        'Impossible to send RPC result back',
        name: _logName,
      );
      return;
    }

    await launchUrl(Uri.parse('${request.replyUrl}/${response.encode()}'));
  }
}
