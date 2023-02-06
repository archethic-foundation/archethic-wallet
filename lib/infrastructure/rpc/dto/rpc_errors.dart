import 'package:aewallet/domain/models/transaction_event.dart';

class ArchethicRPCErrors {
  static int fromTransactionError(TransactionError failure) => failure.map(
        connectivity: (_) => ArchethicRPCErrors.disconnected,
        timeout: (_) => ArchethicRPCErrors.consensusTimeout,
        consensusNotReached: (_) => ArchethicRPCErrors.consensusNotReached,
        invalidConfirmation: (_) => ArchethicRPCErrors.consensusNotReached,
        invalidTransaction: (_) => ArchethicRPCErrors.invalidTransaction,
        insufficientFunds: (_) => ArchethicRPCErrors.insufficientFunds,
        userRejected: (_) => ArchethicRPCErrors.userRejected,
        unknownAccount: (_) => ArchethicRPCErrors.unknownAccount,
        other: (_) => ArchethicRPCErrors.other,
      );

  static const userRejected = 4001;
  static const unauthorized = 4100;
  static const unsupportedMethod = 4200;
  static const disconnected = 4900;
  static const chainDisconnected = 4901;

  static const other = 5000;
  static const consensusTimeout = 5001;
  static const consensusNotReached = 5002;
  static const invalidTransaction = 5003;
  static const insufficientFunds = 5004;
  static const unknownAccount = 5005;
}
