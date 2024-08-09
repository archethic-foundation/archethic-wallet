part of 'providers.dart';

@riverpod
class _AccountsNotifier extends AutoDisposeAsyncNotifier<List<Account>> {
  @override
  FutureOr<List<Account>> build() async {
    final session = ref.watch(sessionNotifierProvider);
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

  Future<_AccountNotifier?> get selectedAccountNotifier async {
    final accountName = (await future).selectedAccount?.name;
    if (accountName == null) return null;

    return ref.read(AccountProviders.account(accountName).notifier);
  }
}

extension AccountsExt on List<Account> {
  Account? get selectedAccount {
    for (final account in this) {
      if (account.selected == true) return account;
    }
    return null;
  }
}

extension FuturteAccountsExt on Future<List<Account>> {
  Future<Account?> get selectedAccount async {
    return (await this).selectedAccount;
  }
}
