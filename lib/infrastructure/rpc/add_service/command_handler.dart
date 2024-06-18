import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCAddServiceCommandHandler
    extends RPCCommandHandler<awc.AddServiceRequest, TransactionConfirmation> {
  RPCAddServiceCommandHandler() : super();

  @override
  RPCCommand<awc.AddServiceRequest> commandToModel(awc.Request dto) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: awc.AddServiceRequest(
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
