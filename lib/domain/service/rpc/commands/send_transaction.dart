import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/service/rpc/commands/command_origin.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_transaction.freezed.dart';

typedef SendTransactionResult
    = Result<TransactionConfirmation, TransactionError>;

@freezed
class RPCSendTransactionCommand with _$RPCSendTransactionCommand {
  const factory RPCSendTransactionCommand({
    /// Source application name
    required RPCCommandOrigin origin,

    /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
    required archethic.Data data,

    /// - Type: transaction type
    required String type,

    /// - Version: version of the transaction (used for backward compatiblity)
    required int version,
  }) = _RPCSendTransactionCommand;
  const RPCSendTransactionCommand._();
}
