import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/subscribe_current_account.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:aewallet/model/data/account.dart';

class RPCSubscribeCurrentAccountCommandHandler extends RPCSubscriptionHandler<
    RPCSubscribeCurrentAccountCommandData, Account> {
  @override
  RPCCommand<RPCSubscribeCurrentAccountCommandData> commandToModel(
    RPCRequestDTO dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: const RPCSubscribeCurrentAccountCommandData(),
      );

  @override
  Map<String, dynamic> notificationFromModel(covariant Account? model) {
    if (model == null) {
      return {
        'name': '',
        'genesisAddress': '',
      };
    }
    return {
      'name': model.nameDisplayed,
      'genesisAddress': model.genesisAddress,
    };
  }
}
