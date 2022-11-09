part of 'providers.dart';

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
    ];
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
      CurrencyProviders.selectedCurrency.select((value) => value.currency.name),
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
