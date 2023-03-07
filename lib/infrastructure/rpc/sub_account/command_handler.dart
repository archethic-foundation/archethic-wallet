import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/subscribe_account.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:aewallet/model/data/account.dart';

class RPCSubscribeAccountCommandHandler
    extends RPCSubscriptionHandler<RPCSubscribeAccountCommandData, Account> {
  @override
  RPCCommand<RPCSubscribeAccountCommandData> commandToModel(
    RPCRequestDTO dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: RPCSubscribeAccountCommandData(
          accountName: dto.payload['name'],
        ),
      );

  @override
  Map<String, dynamic> notificationFromModel(covariant Account model) => {
        'name': model.name,
        'genesisAddress': model.genesisAddress,
        'lastAddress': model.lastAddress,
        if (model.balance != null)
          'balance': {
            'nativeTokenName': model.balance!.nativeTokenName,
            'nativeTokenValue': model.balance!.nativeTokenValue,
          }
      };
}
