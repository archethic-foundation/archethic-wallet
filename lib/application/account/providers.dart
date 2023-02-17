/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/repositories/account.dart';
import 'package:aewallet/infrastructure/repositories/local_account.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Future<List<Account>> _sortedAccounts(_SortedAccountsRef ref) async {
  final accounts = await ref.watch(
    AccountProviders.accounts.future,
  );
  return [
    ...accounts,
  ]..sort(
      (a, b) => a.name.compareTo(b.name),
    );
}

abstract class AccountProviders {
  static final accountsRepository = Provider<AccountLocalRepositoryInterface>(
    (ref) => AccountLocalRepository(),
  );
  static final accounts = _accountsNotifierProvider;
  static final account = AsyncNotifierProvider.autoDispose
      .family<_AccountNotifier, Account?, String>(
    _AccountNotifier.new,
  );
  static final sortedAccounts = _sortedAccountsProvider;
  static final selectedAccount = _selectedAccountNotifierProvider;
  static final selectedAccountName = _selectedAccountNameProvider;
}

class _AccountNotifier
    extends AutoDisposeFamilyAsyncNotifier<Account?, String> {
  @override
  FutureOr<Account?> build(String name) async {
    final repository = ref.read(AccountProviders.accountsRepository);
    final account = await repository.getAccount(name);

    return account!;
  }

  Future<void> _refresh(
    Future<void> Function(Account account) doRefresh,
  ) async {
    try {
      final account = state.valueOrNull;
      if (account == null) return;
      await account.updateLastAddress();

      await doRefresh(account);

      state = AsyncValue.data(account.copyWith());
      ref.invalidate(AccountProviders.account(account.name));
    } catch (e, stack) {
      log('Refresh failed', error: e, stackTrace: stack);
    }
  }

  Future<void> _refreshRecentTransactions(Account account) async {
    final session = ref.read(SessionProviders.session).loggedIn;
    await account.updateRecentTransactions(
      account.name,
      session.wallet.keychainSecuredInfos,
    );
  }

  Future<void> _refreshBalance(Account account) => account.updateBalance();

  Future<void> refreshRecentTransactions() => _refresh(
        (account) async {
          log('${DateTime.now()} Start method refreshRecentTransactions');
          await Future.wait([
            _refreshRecentTransactions(account),
            _refreshBalance(account),
            account.updateFungiblesTokens(),
          ]);
          log('${DateTime.now()} End method refreshRecentTransactions');
        },
      );

  Future<void> refreshFungibleTokens() => _refresh(
        (account) async {
          await account.updateFungiblesTokens();
        },
      );

  Future<void> refreshNFTs() => _refresh(
        (account) async {
          final session = ref.read(SessionProviders.session).loggedIn;
          await account.updateNFT(
            session.wallet.keychainSecuredInfos,
          );
        },
      );

  Future<void> refreshBalance() => _refresh(_refreshBalance);

  Future<void> refreshAll() => _refresh(
        (account) async {
          log('${DateTime.now()} Start method refreshAll');
          final session = ref.read(SessionProviders.session).loggedIn;
          await Future.wait([
            _refreshRecentTransactions(account),
            _refreshBalance(account),
            account.updateFungiblesTokens(),
            account.updateNFT(
              session.wallet.keychainSecuredInfos,
            ),
          ]);
          log('${DateTime.now()} End method refreshAll');
        },
      );
}

@riverpod
class _AccountsNotifier extends AutoDisposeAsyncNotifier<List<Account>> {
  @override
  FutureOr<List<Account>> build() async {
    final session = ref.watch(SessionProviders.session);
    if (session.isLoggedOut) {
      return [];
    }

    // Init avec la valeur du cache
    final repository = ref.watch(AccountProviders.accountsRepository);
    final accountNames = await repository.accountNames();

    return [
      for (final accountName in accountNames)
        await ref.watch(
          AccountProviders.account(accountName).future,
        ),
    ].whereType<Account>().toList();
  }

  Future<void> selectAccount(Account account) async {
    final repository = ref.read(AccountProviders.accountsRepository);

    final previouslySelectedAccount = await repository.getSelectedAccount();
    if (account.name == previouslySelectedAccount?.name) return;

    await repository.selectAccount(account.name);

    if (previouslySelectedAccount != null) {
      ref.invalidate(AccountProviders.account(previouslySelectedAccount.name));
    }
    ref.invalidate(AccountProviders.account(account.name));
  }

  Future<void> addAccount({required String name}) async {
    final loggedInSession = ref.read(SessionProviders.session).loggedIn;
    if (loggedInSession == null) return;

    final currencyName = ref.read(
      SettingsProviders.settings.select((settings) => settings.currency.name),
    );

    await KeychainUtil().addAccountInKeyChain(
      HiveAppWalletDTO.fromModel(loggedInSession.wallet),
      loggedInSession.wallet.seed,
      name,
      currencyName,
      AccountBalance.cryptoCurrencyLabel,
    );

    ref.invalidate(AccountProviders.accounts);
  }
}

@riverpod
Future<String?> _selectedAccountName(_SelectedAccountNameRef ref) async {
  final accounts = await ref.watch(AccountProviders.accounts.future);
  for (final account in accounts) {
    if (account.selected == true) return account.name;
  }
  return null;
}

@riverpod
class _SelectedAccountNotifier extends _$SelectedAccountNotifier {
  @override
  FutureOr<Account?> build() async {
    final accounts = await ref.watch(AccountProviders.accounts.future);
    for (final account in accounts) {
      if (account.selected == true) return account;
    }
    return null;
  }

  Future<void> _refresh(
    Future<void> Function(_AccountNotifier accountNotifier) doRefresh,
  ) async {
    final connectivityStatusProvider = ref.read(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
      return;
    }

    final accountName = state.valueOrNull?.name;
    if (accountName == null) return;
    final accountNotifier = ref.read(
      AccountProviders.account(accountName).notifier,
    );

    return doRefresh(accountNotifier);
  }

  Future<void> refreshRecentTransactions() => _refresh(
        (accountNotifier) => accountNotifier.refreshRecentTransactions(),
      );

  Future<void> refreshFungibleTokens() => _refresh(
        (accountNotifier) => accountNotifier.refreshFungibleTokens(),
      );

  Future<void> refreshNFTs() => _refresh(
        (accountNotifier) => accountNotifier.refreshNFTs(),
      );

  Future<void> refreshBalance() => _refresh(
        (accountNotifier) => accountNotifier.refreshBalance(),
      );

  Future<void> refreshAll() => _refresh(
        (accountNotifier) => accountNotifier.refreshAll(),
      );
}
