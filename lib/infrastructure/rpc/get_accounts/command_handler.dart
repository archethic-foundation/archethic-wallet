import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCGetAccountsCommandHandler
    extends RPCCommandHandler<awc.GetAccountsRequest, awc.GetAccountsResult> {
  RPCGetAccountsCommandHandler() : super();

  @override
  RPCCommand<awc.GetAccountsRequest> commandToModel(awc.Request dto) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: const awc.GetAccountsRequest(),
      );

  @override
  Map<String, dynamic> resultFromModel(awc.GetAccountsResult model) =>
      model.toJson();
}
