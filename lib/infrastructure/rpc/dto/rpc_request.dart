import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpc_request.freezed.dart';
part 'rpc_request.g.dart';

/// Identifies a request source.
@freezed
class RpcRequestOriginDTO with _$RpcRequestOriginDTO {
  const factory RpcRequestOriginDTO({
    required String name,
    String? url,
    String? logo,
  }) = _RpcRequestOrigin;
  const RpcRequestOriginDTO._();

  factory RpcRequestOriginDTO.fromJson(Map<String, dynamic> json) =>
      _$RpcRequestOriginDTOFromJson(json);

  RPCCommandOrigin toModel() => RPCCommandOrigin(
        name: name,
        logo: logo,
        url: url,
      );
}

@freezed
class RPCRequestDTO with _$RPCRequestDTO {
  const factory RPCRequestDTO({
    required RpcRequestOriginDTO origin,
    required int version, // Rpc protocol version
    required Map<String, dynamic> payload,
  }) = _RpcRequest;
  const RPCRequestDTO._();

  factory RPCRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RPCRequestDTOFromJson(json);
}
