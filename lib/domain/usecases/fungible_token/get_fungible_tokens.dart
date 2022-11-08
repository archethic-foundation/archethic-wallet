import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/fungible_tokens_local.dart';
import 'package:aewallet/domain/repositories/fungible_tokens_remote.dart';
import 'package:aewallet/domain/repositories/transaction_local.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/usecases/read_usecases.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:flutter/foundation.dart';

@immutable
class GetFungibleTokensCommand {
  const GetFungibleTokensCommand({
    required this.accountName,
    required this.accountGenesisAddress,
  });
  final String accountName;
  final String accountGenesisAddress;
}

@immutable
class GetFungibleTokensResult {
  const GetFungibleTokensResult({
    required this.accountLastTransactionAddress,
    required this.tokens,
  });

  final String accountLastTransactionAddress;
  final List<AccountToken> tokens;
}

class ReadFungibleTokensUseCases
    with ReadStrategy<GetFungibleTokensCommand, GetFungibleTokensResult> {
  ReadFungibleTokensUseCases({
    required this.transactionRemoteRepository,
    required this.transactionLocalRepository,
    required this.localRepository,
    required this.remoteRepository,
  });

  final TransactionRemoteRepositoryInterface transactionRemoteRepository;
  final TransactionLocalRepositoryInterface transactionLocalRepository;
  final FungibleTokensLocalRepositoryInterface localRepository;
  final FungibleTokensRemoteRepositoryInterface remoteRepository;

  @override
  Future<GetFungibleTokensResult?> getLocal(
    GetFungibleTokensCommand command,
  ) async {
    final lastAddress =
        await transactionLocalRepository.getLastTransactionAddress(
      command.accountName,
    );
    if (lastAddress == null) return null;

    final tokens = await localRepository
        .getFungibleTokens(
          accountName: command.accountName,
        )
        .valueOrNull;
    if (tokens == null) return null;

    return GetFungibleTokensResult(
      accountLastTransactionAddress: lastAddress,
      tokens: tokens,
    );
  }

  @override
  Future<GetFungibleTokensResult?> getRemote(
    GetFungibleTokensCommand command,
  ) async {
    final lastAddress =
        await transactionRemoteRepository.getLastTransactionAddress(
      genesisAddress: command.accountGenesisAddress,
    );
    if (lastAddress == null) return null;

    final tokens = await remoteRepository
        .getFungibleTokens(
          accountLastTransactionAddress: lastAddress,
        )
        .valueOrNull;
    if (tokens == null) return null;

    return GetFungibleTokensResult(
      accountLastTransactionAddress: lastAddress,
      tokens: tokens,
    );
  }

  @override
  Future<void> saveLocal(
    GetFungibleTokensCommand command,
    GetFungibleTokensResult value,
  ) =>
      localRepository
          .saveFungibleTokens(
            accountName: command.accountName,
            lastAddress: value.accountLastTransactionAddress,
            tokens: value.tokens,
          )
          .valueOrThrow;
}
