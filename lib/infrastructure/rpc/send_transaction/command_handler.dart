import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class RPCSendTransactionCommandHandler extends RPCCommandHandler<
    RPCSendTransactionCommandData, archethic.TransactionConfirmation> {
  RPCSendTransactionCommandHandler() : super();

  @override
  RPCCommand<RPCSendTransactionCommandData> commandToModel(RPCRequestDTO dto) {
    if ((dto.payload['data'] as Map<String, dynamic>)
        .containsKey('recipients')) {
      if (dto.payload['data']['recipients'] is List<String>) {
        final _newRecipients = <archethic.Recipient>[];
        for (final recipientAddress
            in dto.payload['data']['recipients'] as List<String>) {
          final _recipient = archethic.Recipient(address: recipientAddress);
          _newRecipients.add(_recipient);
        }
        dto.payload['data']['actionRecipients'] = _newRecipients;
      } else {
        dto.payload['data']['actionRecipients'] =
            dto.payload['data']['recipients'];
      }
      (dto.payload['data'] as Map<String, dynamic>).remove('recipients');
    }

    return RPCCommand(
      origin: dto.origin.toModel(),
      data: RPCSendTransactionCommandData(
        data: archethic.Data.fromJson(dto.payload['data']),
        type: dto.payload['type'],
        version: dto.version,
        generateEncryptedSeedSC: dto.payload['generateEncryptedSeedSC'],
      ),
    );
  }

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
