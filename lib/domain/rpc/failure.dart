import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

extension TransactionErrorToRpcFailure on TransactionError {
  awc.Failure toRpcFailure() {
    return map(
      timeout: (_) => awc.Failure.timeout,
      connectivity: (_) => awc.Failure.connectivity,
      consensusNotReached: (_) => awc.Failure.consensusNotReached,
      invalidTransaction: (_) => awc.Failure.invalidTransaction,
      invalidConfirmation: (_) => awc.Failure.invalidConfirmation,
      serviceNotFound: (_) => awc.Failure.serviceNotFound,
      serviceAlreadyExists: (_) => awc.Failure.serviceAlreadyExists,
      insufficientFunds: (_) => awc.Failure.insufficientFunds,
      userRejected: (_) => awc.Failure.userRejected,
      unknownAccount: (_) => awc.Failure.unknownAccount,
      other: (e) => awc.Failure.other,
    );
  }
}
