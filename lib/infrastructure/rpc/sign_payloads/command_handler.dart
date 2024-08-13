import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCSignPayloadsCommandHandler
    extends RPCCommandHandler<awc.SignPayloadRequest, awc.SignPayloadsResult> {
  RPCSignPayloadsCommandHandler() : super();

  @override
  RPCCommand<awc.SignPayloadRequest> commandToModel(
    awc.Request dto,
  ) {
    final rpcSignPayloadCommandDataList = <awc.SignPayloadRequestData>[];
    final payloads = dto.payload['payloads'];
    for (final Map<String, dynamic> payload in payloads) {
      final payloadDecoded = payload['payload'] ?? '';
      final isHexa = payload['isHexa'] ?? false;
      final rpcSignTransactionCommandData = awc.SignPayloadRequestData(
        payload: payloadDecoded,
        isHexa: isHexa,
      );
      rpcSignPayloadCommandDataList.add(rpcSignTransactionCommandData);
    }

    return RPCCommand(
      origin: dto.origin.toModel,
      data: awc.SignPayloadRequest(
        serviceName: dto.payload['serviceName'],
        pathSuffix: dto.payload['pathSuffix'],
        description: dto.payload['description'] ?? {},
        payloads: rpcSignPayloadCommandDataList,
      ),
    );
  }

  @override
  Map<String, dynamic> resultFromModel(
    awc.SignPayloadsResult model,
  ) =>
      model.toJson();
}
