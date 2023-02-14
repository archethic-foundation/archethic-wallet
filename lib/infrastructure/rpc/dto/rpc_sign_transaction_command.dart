import 'package:aewallet/domain/service/rpc/commands/sign_transaction.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

extension RpcSignTransactionCommand on RpcRequest {
  RPCSignTransactionCommand toSignTransactionModel() {
    return RPCSignTransactionCommand(
      source: RPCCommandSource(
        name: source.name,
        logo: source.logo,
        url: source.url,
      ),
      data: archethic.Data.fromJson(payload['data']),
      type: payload['type'],
      version: version,
    );
  }
}
