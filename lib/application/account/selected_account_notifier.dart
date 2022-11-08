part of 'providers.dart';

@riverpod
class _SelectedAccountNotifier extends AutoDisposeNotifier<Account?> {
  @override
  Account? build() {
    final accounts = ref.watch(AccountProviders.accounts).valueOrNull ?? [];
    for (final account in accounts) {
      if (account.selected == true) return account;
    }
    return null;
  }

  Future<void> _update(Future<void> Function(Account account) doUpdate) async {
    final account = state;
    if (account == null) return;
    await account.updateLastAddress();

    await doUpdate(account);

    state = account.copyWith();
    ref.invalidate(AccountProviders.account(account.name));
  }

  Future<void> _updateRecentTransactions(Account account) async {
    final session = ref.read(SessionProviders.session).loggedIn!;
    await account.updateRecentTransactions(session.wallet.seed);
  }

  Future<void> _updateBalance(Account account) async {
    final selectedCurrency = ref.read(CurrencyProviders.selectedCurrency);
    final tokenPrice = await Price.getCurrency(
      selectedCurrency.currency.name,
    );
    await account.updateBalance(
      selectedCurrency.currency.name,
      tokenPrice,
    );
  }

  Future<void> updateRecentTransactions() => _update(
        (account) async {
          await account.updateLastAddress();

          await _updateRecentTransactions(account);
          await _updateBalance(account);
        },
      );

  Future<void> updateFungibleTokens() => _update(
        (account) async {
          await account.updateLastAddress();
          await account.updateFungiblesTokens();
          await _updateBalance(account);
        },
      );

  Future<void> updateNonFungibleTokens() => _update(
        (account) async {
          await account.updateLastAddress();
          await account.updateNFT();
          await _updateBalance(account);
        },
      );

  Future<void> updateNft({
    required String tokenAddress,
    required int categoryIndex,
  }) =>
      _update(
        (account) async {
          await account.updateNftInfosOffChain(
            tokenAddress: tokenAddress,
            categoryNftIndex: categoryIndex,
          );
        },
      );

  Future<void> updateBalance() => _update(_updateBalance);
}
