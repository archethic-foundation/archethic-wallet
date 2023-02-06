import 'package:deeplink_rpc/src/data/request.dart';
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

@freezed
class DeeplinkRpcHandler with _$DeeplinkRpcHandler {
  const DeeplinkRpcHandler._();
  const factory DeeplinkRpcHandler({
    required DeeplinkRpcRoute route,
    required Future<Map<String, dynamic>> Function(DeeplinkRpcRequest request)
        handle,
  }) = _DeeplinkRpcHandler;
}
