part of 'providers.dart';

@riverpod
Future<String?> _selectedAccountName(_SelectedAccountNameRef ref) async {
  final accounts = await ref.watch(AccountProviders.accounts.future);
  for (final account in accounts) {
    if (account.selected == true) return account.name;
  }
  return null;
}

@riverpod
class _SelectedAccountNotifier extends AutoDisposeAsyncNotifier<Account?> {
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
