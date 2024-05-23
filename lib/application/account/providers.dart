/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/nft/nft.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/repositories/account.dart';
import 'package:aewallet/infrastructure/repositories/local_account.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_notifier.dart';
part 'accounts_notifier.dart';
part 'providers.g.dart';
part 'selected_account_notifier.dart';

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

abstract class AccountProviders {
  static final accountsRepository = Provider<AccountLocalRepositoryInterface>(
    (ref) => AccountLocalRepository(),
  );
  static final accounts = _accountsNotifierProvider;
  static final accountExists = FutureProvider.autoDispose.family<bool, String>(
    (ref, arg) async => (await ref.watch(account(arg).future)) != null,
  );
  static final account = AsyncNotifierProvider.autoDispose
      .family<_AccountNotifier, Account?, String>(
    _AccountNotifier.new,
  );
  static final sortedAccounts = _sortedAccountsProvider;
  static final selectedAccount = _selectedAccountNotifierProvider;
  static final selectedAccountName = _selectedAccountNameProvider;
  static final accountRepository = _accountRepositoryProvider;
  static const getAccountNFTFiltered = _getAccountNFTFilteredProvider;
}
