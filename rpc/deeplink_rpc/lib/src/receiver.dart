import 'dart:developer';

import 'package:deeplink_rpc/src/data/failure.dart';
import 'package:deeplink_rpc/src/data/request.dart';
import 'package:deeplink_rpc/src/data/response.dart';
import 'package:deeplink_rpc/src/data/result.dart';
import 'package:deeplink_rpc/src/handler.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class BaseDeeplinkRpcReceiver<T extends DeeplinkRpcHandler> {
  final Set<T> _routeHandlers = {};

  T? _handlerForPath(String? path) {
    if (path == null) return null;
    return _routeHandlers.cast<T?>().firstWhere(
          (handler) => handler?.route.matches(path) ?? false,
          orElse: () => null,
        );
  }

  void registerHandler(T handler) {
    _routeHandlers.add(handler);
  }

  bool canHandle(String? path) {
    if (path == null) return false;

    return _handlerForPath(path) != null;
  }
}

/// Receives and decodes DeeplinkRpcRequests.
class DeeplinkRpcRequestReceiver
    extends BaseDeeplinkRpcReceiver<DeeplinkRpcRequestHandler> {
  DeeplinkRpcRequestReceiver();

  static const _logName = 'DeeplinkRpcRequest';

  Future<DeeplinkRpcResult> _handle(String? path) async {
    try {
      log(
        'Handles RPC call',
        name: _logName,
      );

      final handler = _handlerForPath(path);
      if (handler == null) {
        return DeeplinkRpcResult.failure(
          failure: DeeplinkRpcFailure(
            code: DeeplinkRpcFailure.kInvalidRequest,
            message: 'No handler for path $path',
          ),
        );
      }

      final data = handler.route.getData(path);

      if (data == null) {
        return DeeplinkRpcResult.failure(
          failure: const DeeplinkRpcFailure(
            code: DeeplinkRpcFailure.kInvalidRequest,
            message: 'Failed to extract data from path',
          ),
        );
      }

      final request = DeeplinkRpcRequest.decode(data);

      try {
        final result = await handler.handle(request);

        log(
          'RPC call handled',
          name: _logName,
        );
        return DeeplinkRpcResult.success(
          request: request,
          result: result,
        );
      } catch (e) {
        if (e is DeeplinkRpcFailure) {
          return DeeplinkRpcResult.failure(
            failure: e,
            request: request,
          );
        }
        return DeeplinkRpcResult.failure(
          failure: DeeplinkRpcFailure(
            code: DeeplinkRpcFailure.kServerError,
          ),
          request: request,
        );
      }
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

/// Receives and decodes DeeplinkRpcRequests.
class DeeplinkRpcResponseReceiver
    extends BaseDeeplinkRpcReceiver<DeeplinkRpcResponseHandler> {
  DeeplinkRpcResponseReceiver();

  static const _logName = 'DeeplinkRpcResponse';

  Future<void> handle(String? path) async {
    try {
      log(
        'Handles RPC response',
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

      final request = DeeplinkRpcResponse.decode(data);

      await handler.handle(request);

      log(
        'RPC call handled',
        name: _logName,
      );
    } catch (e, stack) {
      log(
        'An error occured',
        error: e,
        stackTrace: stack,
        name: _logName,
      );
      throw DeeplinkRpcResult.failure(
        failure: DeeplinkRpcFailure(
          code: DeeplinkRpcFailure.kServerError,
        ),
      );
    }
  }
}
