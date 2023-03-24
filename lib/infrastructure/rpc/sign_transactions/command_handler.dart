import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/sign_transactions.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class RPCSignTransactionsCommandHandler extends RPCCommandHandler<
    RPCSignTransactionsCommandData, RPCSignTransactionsResultData> {
  RPCSignTransactionsCommandHandler() : super();

  @override
  RPCCommand<RPCSignTransactionsCommandData> commandToModel(
    RPCRequestDTO dto,
  ) {
    final rpcSignTransactionCommandDataList = <RPCSignTransactionCommandData>[];
    final transactions = dto.payload['transactions'];
    for (final Map<String, dynamic> transaction in transactions) {
      final tx = archethic.Transaction.fromJson(transaction);
      final rpcSignTransactionCommandData = RPCSignTransactionCommandData(
        data: tx.data!,
        version: tx.version,
        type: tx.type!,
      );
      rpcSignTransactionCommandDataList.add(rpcSignTransactionCommandData);
    }

    return RPCCommand(
      origin: dto.origin.toModel(),
      data: RPCSignTransactionsCommandData(
        serviceName: dto.payload['serviceName'],
        pathSuffix: dto.payload['pathSuffix'],
        rpcSignTransactionCommandData: rpcSignTransactionCommandDataList,
      ),
    );
  }

  @override
  Map<String, dynamic> resultFromModel(
    RPCSignTransactionsResultData model,
  ) =>
      {
        'signedTxs': model.signedTxs
            .map(
              (transaction) => {
                'address': transaction.address,
                'previousPublicKey': transaction.previousPublicKey,
                'previousSignature': transaction.previousSignature,
                'originSignature': transaction.originSignature,
              },
            )
            .toList(),
      };
}
