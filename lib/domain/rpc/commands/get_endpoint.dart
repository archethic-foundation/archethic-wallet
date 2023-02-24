import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_endpoint.freezed.dart';

@freezed
class RPCGetEndpointCommandData with _$RPCGetEndpointCommandData {
  const factory RPCGetEndpointCommandData() = _RPCGetEndpointCommandData;
  const RPCGetEndpointCommandData._();
}

@freezed
class RPCGetEndpointResultData with _$RPCGetEndpointResultData {
  const factory RPCGetEndpointResultData({
    required String endpoint,
  }) = _RPCGetEndpointResultData;

  const RPCGetEndpointResultData._();
}
