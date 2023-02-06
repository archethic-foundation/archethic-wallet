import 'package:deeplink_rpc/src/codec.dart';
import 'package:deeplink_rpc/src/data/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request.freezed.dart';
part 'request.g.dart';

/// RPC request received through Deeplink.
@freezed
class DeeplinkRpcRequest with _$DeeplinkRpcRequest {
  const factory DeeplinkRpcRequest({
    required String id,
    required String replyUrl,
    dynamic params,
  }) = _DeeplinkRpcRequest;

  factory DeeplinkRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$DeeplinkRpcRequestFromJson(json);

  const DeeplinkRpcRequest._();

  factory DeeplinkRpcRequest.decode(Object? argument) {
    if (argument is! String) {
      throw const DeeplinkRpcFailure(code: DeeplinkRpcFailure.kInvalidRequest);
    }

    return DeeplinkRpcRequest.fromJson(
      deeplinkRpc.decode(argument),
    );
  }

  String encode() => deeplinkRpc.encode(toJson());
}
