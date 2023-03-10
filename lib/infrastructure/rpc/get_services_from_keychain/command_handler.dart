import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_services_from_keychain.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';

class RPCGetServicesFromKeychainCommandHandler extends RPCCommandHandler<
    RPCGetServicesFromKeychainCommandData,
    RPCGetServicesFromKeychainResultData> {
  RPCGetServicesFromKeychainCommandHandler() : super();

  @override
  RPCCommand<RPCGetServicesFromKeychainCommandData> commandToModel(
    RPCRequestDTO dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: const RPCGetServicesFromKeychainCommandData(),
      );

  @override
  Map<String, dynamic> resultFromModel(
    RPCGetServicesFromKeychainResultData model,
  ) =>
      {
        'services': model.services
            .map(
              (service) => {
                'derivationPath': service.derivationPath,
                'curve': service.curve,
                'hashAlgo': service.hashAlgo,
              },
            )
            .toList(),
      };
}
