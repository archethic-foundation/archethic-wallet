import 'package:aewallet/domain/repositories/transaction_local.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/usecases/get_from_remote_first.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:flutter/material.dart';

@immutable
class GetRecentTransactionsCommand {
  const GetRecentTransactionsCommand({
    required this.account,
    required this.walletSeed,
  });

  final Account account;
  final String walletSeed;
}

@immutable
class GetRecentTransactionsResult {
  const GetRecentTransactionsResult({
    required this.lastTransactionAddress,
    required this.recentTransactions,
  });

  final String lastTransactionAddress;
  final List<RecentTransaction> recentTransactions;
}

class GetRecentTransactions extends GetFromRemoteFirstStrategy<
    GetRecentTransactionsCommand, GetRecentTransactionsResult> {
  GetRecentTransactions({
    required this.transactionRepository,
    required this.accountLocalRepository,
  });

  final TransactionRemoteRepositoryInterface transactionRepository;
  final TransactionLocalRepositoryInterface accountLocalRepository;

  @override
  Future<GetRecentTransactionsResult?> getLocal(
    GetRecentTransactionsCommand command,
  ) async {
    final lastTransactionAddress =
        await accountLocalRepository.getLastTransactionAddress(
      command.account.name!,
    );
    if (lastTransactionAddress == null) return null;
    final localTransactions =
        await accountLocalRepository.getRecentTransactions(
      command.account.name!,
    );
    return GetRecentTransactionsResult(
      lastTransactionAddress: lastTransactionAddress,
      recentTransactions: localTransactions,
    );
  }

  @override
  Future<GetRecentTransactionsResult?> getRemote(
    GetRecentTransactionsCommand command,
  ) async {
    final lastTransactionAddress =
        await transactionRepository.getLastTransactionAddress(
      genesisAddress: command.account.genesisAddress!,
    );

    if (lastTransactionAddress == null) {
      return null;
    }

    final recentTransactionsResult =
        await transactionRepository.getRecentTransactions(
      account: command.account.copyWith(
        lastAddress: lastTransactionAddress,
      ),
      walletSeed: command.walletSeed,
    );
    final remoteRecentTransactions = recentTransactionsResult.valueOrNull;

    if (remoteRecentTransactions == null) {
      return null;
    }

    return GetRecentTransactionsResult(
      lastTransactionAddress: lastTransactionAddress,
      recentTransactions: remoteRecentTransactions,
    );
  }

  @override
  Future<void> saveLocal(
    GetRecentTransactionsCommand command,
    GetRecentTransactionsResult value,
  ) async {
    await accountLocalRepository.saveRecentTransactions(
      accountName: command.account.name!,
      lastAddress: value.lastTransactionAddress,
      recentTransactions: value.recentTransactions,
    );
  }
}
