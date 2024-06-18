import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCRefreshCurrentAccountCommandHandler
    extends RPCCommandHandler<awc.RefreshCurrentAccountRequest, void> {
  RPCRefreshCurrentAccountCommandHandler() : super();

  @override
  RPCCommand<awc.RefreshCurrentAccountRequest> commandToModel(
    awc.Request dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: const awc.RefreshCurrentAccountRequest(),
      );

  @override
  Map<String, dynamic> resultFromModel(
    awc.RefreshCurrentAccountResponse model,
  ) =>
      model.toJson();
}
