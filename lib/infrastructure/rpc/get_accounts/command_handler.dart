import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_accounts.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';

class RPCGetAccountsCommandHandler extends RPCCommandHandler<
    RPCGetAccountsCommandData, RPCGetAccountsResultData> {
  RPCGetAccountsCommandHandler() : super();

  @override
  RPCCommand<RPCGetAccountsCommandData> commandToModel(RPCRequestDTO dto) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: const RPCGetAccountsCommandData(),
      );

  @override
  Map<String, dynamic> resultFromModel(RPCGetAccountsResultData model) => {
        'accounts': model.accounts.map(
          (account) => {
            'name': account.name,
            'genesisAddress': account.genesisAddress,
          },
        )
      };
}
