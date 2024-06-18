import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCGetEndpointCommandHandler
    extends RPCCommandHandler<awc.GetEndpointRequest, awc.GetEndpointResult> {
  RPCGetEndpointCommandHandler() : super();

  @override
  RPCCommand<awc.GetEndpointRequest> commandToModel(awc.Request dto) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: const awc.GetEndpointRequest(),
      );

  @override
  Map<String, dynamic> resultFromModel(awc.GetEndpointResult model) =>
      model.toJson();
}
