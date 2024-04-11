import 'package:aewallet/model/data/account_balance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

extension TransactionErrorLocalizedExt on TransactionError {
  String localizedMessage(AppLocalizations localization) => map(
        timeout: (_) => localization.transactionTimeOut,
        connectivity: (_) => localization.connectivityWarningDesc,
        consensusNotReached: (_) => localization.consensusNotReached,
        invalidTransaction: (_) => localization.invalidTransaction,
        invalidConfirmation: (_) => localization.notEnoughConfirmations,
        insufficientFunds: (_) => localization.insufficientBalance.replaceAll(
          '%1',
          AccountBalance.cryptoCurrencyLabel,
        ),
        serviceNotFound: (_) => localization.serviceNotFound,
        serviceAlreadyExists: (_) => localization.serviceAlreadyExists,
        userRejected: (_) => localization.userCancelledOperation,
        unknownAccount: (error) => localization.unknownAccount.replaceAll(
          '%1',
          error.accountName,
        ),
        rpcError: (error) => localization.rpcError
            .replaceFirst('%1', error.code.toString())
            .replaceFirst(
              '%2',
              '${error.message} ${error.data ?? ''}',
            ),
        other: (_) => localization.genericError,
      );
}
