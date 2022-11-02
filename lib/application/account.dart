/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account.g.dart';

@Riverpod(keepAlive: true)
class _AccountsNotifier extends Notifier<List<Account>> {
  @override
  List<Account> build() {
    /// Accounts initialization done from SessionProvider.
    /// That way, it is reset on login/logout.
    /// Moreover, that way, intialisation is synchronous
    ///
    /// Next, we will use local state only
    return ref.watch(
          SessionProviders.session.select(
            (value) => value.loggedIn?.wallet.appKeychain.accounts,
          ),
        ) ??
        [];
  }

  @override
  bool updateShouldNotify(List<Account> previous, List<Account> next) {
    return const DeepCollectionEquality.unordered().equals(previous, next);
  }

  Future<void> selectAccount(Account account) async {
    final updatedKeychain = await sl.get<DBHelper>().changeAccount(account);
    state = updatedKeychain.appKeychain.accounts;
  }

  Future<void> addAccount({required String name}) async {
    final loggedInSession = ref.read(SessionProviders.session).loggedIn;
    if (loggedInSession == null) return;

    final currencyName = ref.read(
      CurrencyProviders.selectedCurrency.select((value) => value.currency.name),
    );
    final currentNetwork = ref.read(
      SettingsProviders.settings.select(
        (value) => value.network,
      ),
    );

    final updatedKeychain = await KeychainUtil().addAccountInKeyChain(
      loggedInSession.wallet,
      loggedInSession.seed,
      name,
      currencyName,
      currentNetwork.getNetworkCryptoCurrencyLabel(),
    );
    state = updatedKeychain.appKeychain.accounts;
  }
}

@Riverpod(keepAlive: true)
class _SelectedAccountNotifier extends Notifier<Account?> {
  @override
  Account? build() {
    final accounts = ref.watch(AccountProviders.accounts);
    for (final account in accounts) {
      if (account.selected == true) return account;
    }
    return null;
  }
}

@riverpod
List<Account> _sortedAccounts(Ref ref) {
  final accounts = ref.watch(
    AccountProviders.accounts,
  );
  return [
    ...accounts,
  ]..sort(
      (a, b) => a.name!.compareTo(b.name!),
    );
}

abstract class AccountProviders {
  static final accounts = _accountsNotifierProvider;
  static final sortedAccounts = _sortedAccountsProvider;
  static final selectedAccount = _selectedAccountNotifierProvider;
}
