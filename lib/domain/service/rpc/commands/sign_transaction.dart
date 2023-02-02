import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_transaction.freezed.dart';

typedef SignTransactionResult
    = Result<TransactionConfirmation, TransactionError>;

@freezed
class SignTransactionCommand with _$SignTransactionCommand {
  const factory SignTransactionCommand({
    /// Source application name
    required String source,

    /// Service
    required String accountName,

    /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
    required archethic.Data data,

    /// - Type: transaction type
    required String type,

    /// - Version: version of the transaction (used for backward compatiblity)
    required int version,
  }) = _SignTransactionCommand;
  const SignTransactionCommand._();
}
