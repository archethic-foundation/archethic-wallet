import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/refresh_current_account.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';

class RPCRefreshCurrentAccountCommandHandler
    extends RPCCommandHandler<RPCRefreshCurrentAccountCommandData, void> {
  RPCRefreshCurrentAccountCommandHandler() : super();

  @override
  RPCCommand<RPCRefreshCurrentAccountCommandData> commandToModel(
    RPCRequestDTO dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: const RPCRefreshCurrentAccountCommandData(),
      );

  @override
  Map<String, dynamic> resultFromModel(void model) {
    return {};
  }
}
