part of 'providers.dart';

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
    final account = state.valueOrNull;
    if (account == null) return;
    await account.updateLastAddress();

    await doRefresh(account);

    state = AsyncValue.data(account.copyWith());
    ref.invalidate(AccountProviders.account(account.name));
  }

  Future<void> _refreshRecentTransactions(Account account) async {
    final session = ref.read(SessionProviders.session).loggedIn!;
    await account.updateRecentTransactions(session.wallet.seed);
  }

  Future<void> _refreshBalance(Account account) async {
    final selectedCurrency = ref.read(CurrencyProviders.selectedCurrency);
    final tokenPrice = await Price.getCurrency(
      selectedCurrency.currency.name,
    );
    await account.updateBalance(
      selectedCurrency.currency.name,
      tokenPrice,
    );
  }

  Future<void> refreshRecentTransactions() => _refresh(
        (account) async {
          await _refreshRecentTransactions(account);
          await _refreshBalance(account);
        },
      );

  Future<void> refreshFungibleTokens() => _refresh(
        (account) async {
          await account.updateFungiblesTokens();
          await _refreshBalance(account);
        },
      );

  Future<void> refreshNFTs() => _refresh(
        (account) async {
          await account.updateNFT();
          await _refreshBalance(account);
        },
      );

  Future<void> refreshBalance() => _refresh(_refreshBalance);

  Future<void> refreshAll() => _refresh(
        (account) async {
          await _refreshRecentTransactions(account);
          await _refreshBalance(account);
          await account.updateFungiblesTokens();
          await account.updateNFT();
        },
      );
}
