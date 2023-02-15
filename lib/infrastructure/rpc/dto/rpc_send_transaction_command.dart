import 'package:aewallet/domain/service/rpc/commands/command_origin.dart';
import 'package:aewallet/domain/service/rpc/commands/send_transaction.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

extension RpcSendTransactionCommand on RpcRequest {
  RPCSendTransactionCommand toSignTransactionModel() {
    return RPCSendTransactionCommand(
      origin: RPCCommandOrigin(
        name: origin.name,
        logo: origin.logo,
        url: origin.url,
      ),
      data: archethic.Data.fromJson(payload['data']),
      type: payload['type'],
      version: version,
    );
  }
}
