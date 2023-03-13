import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/keychain_derive_address.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';

class RPCKeychainDeriveAddressCommandHandler extends RPCCommandHandler<
    RPCKeychainDeriveAddressCommandData, RPCKeychainDeriveAddressResultData> {
  RPCKeychainDeriveAddressCommandHandler() : super();

  @override
  RPCCommand<RPCKeychainDeriveAddressCommandData> commandToModel(
    RPCRequestDTO dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: RPCKeychainDeriveAddressCommandData(
          serviceName: dto.payload['serviceName'],
          index: dto.payload['index'] ?? 0,
          pathSuffix: dto.payload['pathSuffix'] ?? '',
        ),
      );

  @override
  Map<String, dynamic> resultFromModel(
    RPCKeychainDeriveAddressResultData model,
  ) =>
      {'address': model.address};
}
