import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpc_get_endpoint_result.freezed.dart';
part 'rpc_get_endpoint_result.g.dart';

@freezed
class RpcGetEndpointResult with _$RpcGetEndpointResult {
  const factory RpcGetEndpointResult({
    required String endpointUrl,
  }) = _RpcGetEndpointResult;
  const RpcGetEndpointResult._();

  factory RpcGetEndpointResult.fromJson(Map<String, dynamic> json) =>
      _$RpcGetEndpointResultFromJson(json);
}
