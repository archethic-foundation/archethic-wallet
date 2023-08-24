import 'package:aewallet/domain/repositories/transaction_local.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/usecases/read_usecases.dart';
import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:flutter/material.dart';

@immutable
class ReadRecentTransactionsCommand {
  const ReadRecentTransactionsCommand({
    required this.account,
    required this.walletSeed,
    required this.keychainSecuredInfos,
  });

  final Account account;
  final String walletSeed;
  final KeychainSecuredInfos keychainSecuredInfos;
}

@immutable
class ReadRecentTransactionsResult {
  const ReadRecentTransactionsResult({
    required this.lastTransactionAddress,
    required this.recentTransactions,
  });

  final String lastTransactionAddress;
  final List<RecentTransaction> recentTransactions;
}

class ReadRecentTransactionsUseCases
    with
        ReadStrategy<ReadRecentTransactionsCommand,
            ReadRecentTransactionsResult> {
  ReadRecentTransactionsUseCases({
    required this.transactionRepository,
    required this.transactionLocalRepository,
  });

  final TransactionRemoteRepositoryInterface transactionRepository;
  final TransactionLocalRepositoryInterface transactionLocalRepository;

  @override
  Future<ReadRecentTransactionsResult?> getLocal(
    ReadRecentTransactionsCommand command,
  ) async {
    final lastTransactionAddress =
        await transactionLocalRepository.getLastTransactionAddress(
      command.account.name,
    );
    if (lastTransactionAddress == null) return null;

    final localTransactions =
        await transactionLocalRepository.getRecentTransactions(
      command.account.name,
    );
    return ReadRecentTransactionsResult(
      lastTransactionAddress: lastTransactionAddress,
      recentTransactions: localTransactions,
    );
  }

  @override
  Future<ReadRecentTransactionsResult?> getRemote(
    ReadRecentTransactionsCommand command,
  ) async {
    final lastTransactionAddress =
        await transactionRepository.getLastTransactionAddress(
      genesisAddress: command.account.genesisAddress,
    );

    if (lastTransactionAddress == null) {
      return null;
    }

    final recentTransactionsResult =
        await transactionRepository.getRecentTransactions(
      account: command.account.copyWith(
        lastAddress: lastTransactionAddress,
      ),
      keychainSecuredInfos: command.keychainSecuredInfos,
    );
    final remoteRecentTransactions = recentTransactionsResult.valueOrNull;

    if (remoteRecentTransactions == null) {
      return null;
    }

    return ReadRecentTransactionsResult(
      lastTransactionAddress: lastTransactionAddress,
      recentTransactions: remoteRecentTransactions,
    );
  }

  @override
  Future<void> saveLocal(
    ReadRecentTransactionsCommand command,
    ReadRecentTransactionsResult value,
  ) async {
    await transactionLocalRepository.saveRecentTransactions(
      accountName: command.account.name,
      lastAddress: value.lastTransactionAddress,
      recentTransactions: value.recentTransactions,
    );
  }
}
