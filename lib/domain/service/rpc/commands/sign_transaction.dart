import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_transaction.freezed.dart';

typedef SignTransactionResult
    = Result<TransactionConfirmation, TransactionError>;

@freezed
class RPCCommandSource with _$RPCCommandSource {
  const factory RPCCommandSource({
    required String name,
    String? url,
    String? logo,
  }) = _RPCCommandSource;
  const RPCCommandSource._();
}

@freezed
class RPCSignTransactionCommand with _$RPCSignTransactionCommand {
  const factory RPCSignTransactionCommand({
    /// Source application name
    required RPCCommandSource source,

    /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
    required archethic.Data data,

    /// - Type: transaction type
    required String type,

    /// - Version: version of the transaction (used for backward compatiblity)
    required int version,
  }) = _RPCSignTransactionCommand;
  const RPCSignTransactionCommand._();
}
