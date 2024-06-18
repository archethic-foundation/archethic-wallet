import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCGetCurrentAccountCommandHandler extends RPCCommandHandler<
    awc.GetCurrentAccountRequest, awc.GetCurrentAccountResult> {
  RPCGetCurrentAccountCommandHandler() : super();

  @override
  RPCCommand<awc.GetCurrentAccountRequest> commandToModel(
    awc.Request dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: const awc.GetCurrentAccountRequest(),
      );

  @override
  Map<String, dynamic> resultFromModel(awc.GetCurrentAccountResult model) =>
      model.toJson();
}
