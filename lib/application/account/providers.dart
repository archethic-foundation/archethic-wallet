/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:aewallet/application/nft/nft.dart';
import 'package:aewallet/application/refresh_in_progress.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/repositories/account.dart';
import 'package:aewallet/infrastructure/repositories/local_account.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_notifier.dart';
part 'accounts_notifier.dart';
part 'providers.g.dart';

@riverpod
AccountRepository _accountRepository(_AccountRepositoryRef ref) =>
    AccountRepository();

@riverpod
Future<List<Account>> _sortedAccounts(_SortedAccountsRef ref) async {
  final accounts = await ref.watch(
    AccountProviders.accounts.future,
  );
  return [
    ...accounts,
  ]..sort(
      (a, b) => a.nameDisplayed.compareTo(b.nameDisplayed),
    );
}

@riverpod
List<AccountToken> _getAccountNFTFiltered(
  _GetAccountNFTFilteredRef ref,
  Account account,
  int categoryNftIndex, {
  bool? favorite,
}) {
  return ref.watch(_accountRepositoryProvider).getAccountNFTFiltered(
        account,
        categoryNftIndex,
        favorite: favorite,
      );
}

class AccountRepository {
  List<AccountToken> getAccountNFTFiltered(
    Account account,
    int categoryNftIndex, {
    bool? favorite,
  }) {
    final accountNFTFiltered = <AccountToken>[
      ..._filterTokens(account, account.accountNFT, categoryNftIndex),
      // A collection of NFT has the same address for all the sub NFT, we only want to display one NFT in that case
      ..._getUniqueTokens(
        _filterTokens(account, account.accountNFTCollections, categoryNftIndex),
      ),
    ];
    return accountNFTFiltered;
  }

  List<AccountToken> _filterTokens(
    Account account,
    List<AccountToken>? accountTokens,
    int categoryNftIndex, {
    bool? favorite,
  }) {
    final listTokens = <AccountToken>[];
    if (accountTokens == null) {
      return listTokens;
    }

    for (final accountToken in accountTokens) {
      final nftInfoOffChain = account.nftInfosOffChainList!.firstWhereOrNull(
        (nftInfoOff) =>
            nftInfoOff.id == accountToken.tokenInformation!.id &&
            nftInfoOff.categoryNftIndex == categoryNftIndex,
      );
      if (nftInfoOffChain == null) {
        continue;
      }
      if (favorite == null) {
        listTokens.add(accountToken);
      } else {
        if (nftInfoOffChain.favorite == favorite) {
          listTokens.add(accountToken);
        }
      }
    }

    return listTokens;
  }

  List<AccountToken> _getUniqueTokens(List<AccountToken> accountTokens) {
    final set = <String>{};
    return accountTokens
        .where((e) => set.add(e.tokenInformation?.address ?? ''))
        .toList();
  }
}

@Riverpod(keepAlive: true)
AccountLocalRepositoryInterface _accountsRepository(
  _AccountsRepositoryRef ref,
) =>
    AccountLocalRepository();

@riverpod
class _AccountExistsNotifier extends _$AccountExistsNotifier {
  @override
  Future<bool> build(String accountName) async {
    return (await ref.watch(AccountProviders.account(accountName).future)) !=
        null;
  }
}

abstract class AccountProviders {
  static final accountsRepository = _accountsRepositoryProvider;
  static final accounts = _accountsNotifierProvider;
  static const accountExists = _accountExistsNotifierProvider;
  static const account = _accountNotifierProvider;
  static final sortedAccounts = _sortedAccountsProvider;
  static final accountRepository = _accountRepositoryProvider;
  static const getAccountNFTFiltered = _getAccountNFTFilteredProvider;
}
