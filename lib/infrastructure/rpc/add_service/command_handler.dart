import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/rpc/commands/add_service.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';

class RPCAddServiceCommandHandler extends RPCCommandHandler<
    RPCAddServiceCommandData, TransactionConfirmation> {
  RPCAddServiceCommandHandler() : super();

  @override
  RPCCommand<RPCAddServiceCommandData> commandToModel(RPCRequestDTO dto) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: RPCAddServiceCommandData(
          name: dto.payload['name'],
        ),
      );

  @override
  Map<String, dynamic> resultFromModel(TransactionConfirmation model) {
    return {
      'maxConfirmations': model.maxConfirmations,
      'nbConfirmations': model.nbConfirmations,
      'transactionAddress': model.transactionAddress,
    };
  }
}
