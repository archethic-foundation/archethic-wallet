import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_current_account.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';

class RPCGetCurrentAccountCommandHandler extends RPCCommandHandler<
    RPCGetCurrentAccountCommandData, RPCGetCurrentAccountResultData> {
  RPCGetCurrentAccountCommandHandler() : super();

  @override
  RPCCommand<RPCGetCurrentAccountCommandData> commandToModel(
    RPCRequestDTO dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: const RPCGetCurrentAccountCommandData(),
      );

  @override
  Map<String, dynamic> resultFromModel(RPCGetCurrentAccountResultData model) =>
      {
        'shortName': model.account.shortName,
        'serviceName': model.account.serviceName,
        'genesisAddress': model.account.genesisAddress,
      };
}
