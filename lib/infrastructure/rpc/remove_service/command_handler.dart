import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCRemoveServiceCommandHandler extends RPCCommandHandler<
    awc.RemoveServiceRequest, TransactionConfirmation> {
  RPCRemoveServiceCommandHandler() : super();

  @override
  RPCCommand<awc.RemoveServiceRequest> commandToModel(awc.Request dto) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: awc.RemoveServiceRequest(
          name: dto.payload['name'],
        ),
      );

  @override
  Map<String, dynamic> resultFromModel(TransactionConfirmation model) =>
      awc.SendTransactionResult(
        maxConfirmations: model.maxConfirmations,
        nbConfirmations: model.nbConfirmations,
        transactionAddress: model.transactionAddress,
      ).toJson();
}
