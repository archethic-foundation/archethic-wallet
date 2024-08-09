part of 'providers.dart';

class _AccountNotifier
    extends AutoDisposeFamilyAsyncNotifier<Account?, String> {
  final _logger = Logger('AccountNotifier');

  @override
  FutureOr<Account?> build(String name) async {
    final repository = ref.read(AccountProviders.accountsRepository);
    final account = await repository.getAccount(name);

    return account;
  }

  Future<void> _refresh(
    Future<void> Function(Account account) doRefresh,
  ) async {
    try {
      final account = state.valueOrNull;
      if (account == null) return;
      await account.updateLastAddress();

      ref.read(refreshInProgressProviders.notifier).setRefreshInProgress(true);
      await doRefresh(account);

      final newAccountData = account.copyWith();
      state = AsyncData(newAccountData);
    } catch (e, stack) {
      _logger.severe('Refresh failed', e, stack);
    } finally {
      ref.read(refreshInProgressProviders.notifier).setRefreshInProgress(false);
    }
  }

  Future<void> _refreshRecentTransactions(Account account) async {
    final session = ref.read(sessionNotifierProvider).loggedIn!;
    await account.updateRecentTransactions(
      account.name,
      session.wallet.keychainSecuredInfos,
    );
  }

  Future<void> _refreshBalance(Account account) => account.updateBalance();

  Future<void> refreshRecentTransactions() => _refresh(
        (account) async {
          _logger.fine(
            'Start method refreshRecentTransactions for ${account.nameDisplayed}',
          );
          await _refreshRecentTransactions(account);
          await _refreshBalance(account);
          await account.updateFungiblesTokens();
          _logger.fine(
            'End method refreshRecentTransactions for ${account.nameDisplayed}',
          );
        },
      );

  Future<void> refreshFungibleTokens() => _refresh(
        (account) async {
          await account.updateFungiblesTokens();
        },
      );

  Future<void> refreshNFTs() => _refresh(
        (account) async {
          final session = ref.read(sessionNotifierProvider).loggedIn!;
          final tokenInformation = await ref.read(
            NFTProviders.getNFTList(
              account.lastAddress!,
              account.name,
              session.wallet.keychainSecuredInfos,
            ).future,
          );

          await account.updateNFT(
            session.wallet.keychainSecuredInfos,
            tokenInformation.$1,
            tokenInformation.$2,
          );
        },
      );

  Future<void> refreshBalance() => _refresh(_refreshBalance);

  Future<void> refreshAll() => _refresh(
        (account) async {
          _logger.fine('(${account.name}) Start method refreshAll');
          final session = ref.read(sessionNotifierProvider).loggedIn!;
          final tokenInformation = await ref.read(
            NFTProviders.getNFTList(
              account.lastAddress!,
              account.name,
              session.wallet.keychainSecuredInfos,
            ).future,
          );
          await _refreshBalance(account);
          await _refreshRecentTransactions(account);
          await account.updateFungiblesTokens();
          await account.updateNFT(
            session.wallet.keychainSecuredInfos,
            tokenInformation.$1,
            tokenInformation.$2,
          );
          _logger.fine('End method refreshAll');
        },
      );
}
