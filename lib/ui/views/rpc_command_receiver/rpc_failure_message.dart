import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_balance.dart';

extension TransactionErrorLocalizedExt on TransactionError {
  String localizedMessage(AppLocalization localization) => map(
        timeout: (_) => localization.transactionTimeOut,
        connectivity: (_) => localization.connectivityWarningDesc,
        consensusNotReached: (_) => localization.consensusNotReached,
        invalidTransaction: (_) => localization.invalidTransaction,
        invalidConfirmation: (_) => localization.notEnoughConfirmations,
        insufficientFunds: (_) => localization.insufficientBalance.replaceAll(
          '%1',
          AccountBalance.cryptoCurrencyLabel,
        ),
        userRejected: (_) => localization.userCancelledOperation,
        unknownAccount: (error) => localization.unknownAccount.replaceAll(
          '%1',
          error.accountName,
        ),
        other: (_) => localization.genericError,
      );
}
