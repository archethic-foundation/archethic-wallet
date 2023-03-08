import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_endpoint.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';

class RPCGetEndpointCommandHandler extends RPCCommandHandler<
    RPCGetEndpointCommandData, RPCGetEndpointResultData> {
  RPCGetEndpointCommandHandler() : super();

  @override
  RPCCommand<RPCGetEndpointCommandData> commandToModel(RPCRequestDTO dto) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: const RPCGetEndpointCommandData(),
      );

  @override
  Map<String, dynamic> resultFromModel(RPCGetEndpointResultData model) {
    return {
      'endpointUrl': model.endpoint,
    };
  }
}
