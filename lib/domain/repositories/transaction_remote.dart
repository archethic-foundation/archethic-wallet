/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/keychain_secured_infos.dart';

typedef TransactionConfirmationHandler = Future<void> Function(
  TransactionConfirmation confirmation,
);
typedef TransactionErrorHandler = Future<void> Function(TransactionError error);

abstract class TransactionRemoteRepositoryInterface {
  const TransactionRemoteRepositoryInterface();

  Future<Result<double, Failure>> calculateFees(Transaction transaction);

  Future<void> send({
    required Transaction transaction,
    Duration timeout = const Duration(seconds: 10),
    required TransactionConfirmationHandler onConfirmation,
    required TransactionErrorHandler onError,
  });

  Future<String?> getLastTransactionAddress({
    required String genesisAddress,
  });

  Future<Result<List<RecentTransaction>, Failure>> getRecentTransactions({
    required Account account,
    required String walletSeed,
    required KeychainSecuredInfos keychainSecuredInfos,
  });
}
