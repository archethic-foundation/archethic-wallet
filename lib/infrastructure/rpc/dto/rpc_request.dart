import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpc_request.freezed.dart';
part 'rpc_request.g.dart';

/// Identifies a request source.
@freezed
class RpcRequestSource with _$RpcRequestSource {
  const factory RpcRequestSource({
    required String name,
    String? url,
    String? logo,
  }) = _RpcRequestSource;
  const RpcRequestSource._();

  factory RpcRequestSource.fromJson(Map<String, dynamic> json) =>
      _$RpcRequestSourceFromJson(json);
}

@freezed
class RpcRequest with _$RpcRequest {
  const factory RpcRequest({
    required RpcRequestSource source,
    required int version, // Rpc protocol version
    required Map<String, dynamic> payload,
  }) = _RpcRequest;
  const RpcRequest._();

  factory RpcRequest.fromJson(Map<String, dynamic> json) =>
      _$RpcRequestFromJson(json);
}
