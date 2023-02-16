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
    final session = ref.read(SessionProviders.session).loggedIn!;
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
          final session = ref.read(SessionProviders.session).loggedIn!;
          await account.updateNFT(
            session.wallet.keychainSecuredInfos,
          );
        },
      );

  Future<void> refreshBalance() => _refresh(_refreshBalance);

  Future<void> refreshAll() => _refresh(
        (account) async {
          log('${DateTime.now()} Start method refreshAll');
          final session = ref.read(SessionProviders.session).loggedIn!;
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
