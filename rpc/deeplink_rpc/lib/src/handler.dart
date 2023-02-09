import 'dart:async';

import 'package:deeplink_rpc/src/data/request.dart';
import 'package:deeplink_rpc/src/data/response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'handler.freezed.dart';

/// Route receiving a Deeplink
///
/// Deeplink path follows the format '/[parametrable_path_prefix]/[base64_payload]'
@freezed
class DeeplinkRpcRoute with _$DeeplinkRpcRoute {
  const DeeplinkRpcRoute._();
  const factory DeeplinkRpcRoute(
    String pathFirstSegment,
  ) = _DeeplinkRpcRoute;

  get _pathRegex => RegExp('/$pathFirstSegment/(?<data>[a-zA-Z0-9=+/]*)');

  /// Does the path match the Route.
  bool matches(String path) => _pathRegex.hasMatch(path);

  /// Extracts data payload from the path.
  String? getData(String? path) {
    final matches = _pathRegex.allMatches(path);
    if (matches.isEmpty) {
      return null;
    }
    return matches.first.namedGroup('data');
  }
}

abstract class DeeplinkRpcHandler {
  DeeplinkRpcRoute get route;
}

@freezed
class DeeplinkRpcRequestHandler
    with _$DeeplinkRpcRequestHandler
    implements DeeplinkRpcHandler {
  const DeeplinkRpcRequestHandler._();

  const factory DeeplinkRpcRequestHandler({
    required DeeplinkRpcRoute route,
    required FutureOr<Map<String, dynamic>> Function(DeeplinkRpcRequest request)
        handle,
  }) = _DeeplinkRpcRequestHandler;
}

@freezed
class DeeplinkRpcResponseHandler
    with _$DeeplinkRpcResponseHandler
    implements DeeplinkRpcHandler {
  const DeeplinkRpcResponseHandler._();

  const factory DeeplinkRpcResponseHandler({
    required DeeplinkRpcRoute route,
    required FutureOr<void> Function(DeeplinkRpcResponse response) handle,
  }) = _DeeplinkRpcResponseHandler;
}
