import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpc_request.freezed.dart';
part 'rpc_request.g.dart';

/// Identifies a request source.
@freezed
class RpcRequestOrigin with _$RpcRequestOrigin {
  const factory RpcRequestOrigin({
    required String name,
    String? url,
    String? logo,
  }) = _RpcRequestOrigin;
  const RpcRequestOrigin._();

  factory RpcRequestOrigin.fromJson(Map<String, dynamic> json) =>
      _$RpcRequestOriginFromJson(json);
}

@freezed
class RpcRequest with _$RpcRequest {
  const factory RpcRequest({
    required RpcRequestOrigin origin,
    required int version, // Rpc protocol version
    required Map<String, dynamic> payload,
  }) = _RpcRequest;
  const RpcRequest._();

  factory RpcRequest.fromJson(Map<String, dynamic> json) =>
      _$RpcRequestFromJson(json);
}
