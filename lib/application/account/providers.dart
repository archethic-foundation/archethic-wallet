/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/nft/nft.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/repositories/account.dart';
import 'package:aewallet/infrastructure/repositories/local_account.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_token.dart';
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
    final accountNFTFiltered = <AccountToken>[];
    if (account.accountNFT == null && account.accountNFTCollections == null) {
      return accountNFTFiltered;
    } else {
      if (account.nftInfosOffChainList == null ||
          account.nftInfosOffChainList!.isEmpty) {
        return account.accountNFT!;
      } else {
        for (final accountToken in account.accountNFT!) {
          final nftInfosOffChain = account.nftInfosOffChainList!
              .where(
                (element) => element.id == accountToken.tokenInformations!.id,
              )
              .firstOrNull;
          if (nftInfosOffChain != null &&
              nftInfosOffChain.categoryNftIndex == categoryNftIndex) {
            if (favorite == null) {
              accountNFTFiltered.add(accountToken);
            } else {
              if (nftInfosOffChain.favorite == favorite) {
                accountNFTFiltered.add(accountToken);
              }
            }
          }
        }
        if (account.accountNFTCollections != null) {
          for (final accountNFTCollection in account.accountNFTCollections!) {
            final nftInfosOffChain = account.nftInfosOffChainList!
                .where(
                  (element) =>
                      element.id == accountNFTCollection.tokenInformations!.id,
                )
                .firstOrNull;
            if (nftInfosOffChain != null &&
                nftInfosOffChain.categoryNftIndex == categoryNftIndex) {
              if (favorite == null) {
                accountNFTFiltered.add(accountNFTCollection);
              } else {
                if (nftInfosOffChain.favorite == favorite) {
                  accountNFTFiltered.add(accountNFTCollection);
                }
              }
            }
          }
        }

        return accountNFTFiltered;
      }
    }
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
