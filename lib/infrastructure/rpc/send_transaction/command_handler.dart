import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class RPCSendTransactionCommandHandler extends RPCCommandHandler<
    RPCSendTransactionCommandData, archethic.TransactionConfirmation> {
  RPCSendTransactionCommandHandler() : super();

  @override
  RPCCommand<RPCSendTransactionCommandData> commandToModel(RPCRequestDTO dto) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: RPCSendTransactionCommandData(
          data: archethic.Data.fromJson(dto.payload['data']),
          type: dto.payload['type'],
          version: dto.version,
        ),
      );

  @override
  Map<String, dynamic> resultFromModel(
    archethic.TransactionConfirmation model,
  ) {
    return {
      'maxConfirmations': model.maxConfirmations,
      'nbConfirmations': model.nbConfirmations,
      'transactionAddress': model.transactionAddress,
    };
  }
}
