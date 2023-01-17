import 'package:freezed_annotation/freezed_annotation.dart';

part 'request.freezed.dart';
part 'request.g.dart';

@freezed
class RPCRequest with _$RPCRequest {
  const RPCRequest._();
  const factory RPCRequest({
    required String method,
    required Map<String, dynamic> jsonParams,
  }) = _RPCRequest;

  factory RPCRequest.fromJson(Map<String, dynamic> json) =>
      _$RPCRequestFromJson(json);
}
