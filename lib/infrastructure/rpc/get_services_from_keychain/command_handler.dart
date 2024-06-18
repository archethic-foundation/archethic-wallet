import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCGetServicesFromKeychainCommandHandler extends RPCCommandHandler<
    awc.GetServicesFromKeychainRequest, awc.GetServicesFromKeychainResult> {
  RPCGetServicesFromKeychainCommandHandler() : super();

  @override
  RPCCommand<awc.GetServicesFromKeychainRequest> commandToModel(
    awc.Request dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: const awc.GetServicesFromKeychainRequest(),
      );

  @override
  Map<String, dynamic> resultFromModel(
    awc.GetServicesFromKeychainResult model,
  ) =>
      model.toJson();
}
