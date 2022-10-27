part of 'wallet.dart';

class SessionNotifier extends Notifier<Session> {
  Vault? __vault;
  Future<Vault> get _vault async => __vault ??= await Vault.getInstance();

  final DBHelper _dbHelper = sl.get<DBHelper>();

  @override
  Session build() {
    return const Session.loggedOut();
  }

  Future<void> restore() async {
    final seed = (await _vault).getSeed();
    final appWallet = await _dbHelper.getAppWallet();

    if (seed == null || appWallet == null) {
      await logout();
      return;
    }

    state = Session.loggedIn(
      seed: seed,
      wallet: appWallet,
    );
  }

  Future<void> refresh() async {
    if (state.isLoggedOut) return;

    final loggedInState = state.loggedIn!;
    final selectedCurrency = ref.read(CurrencyProviders.selectedCurrency);
    final selectedAccount = ref.read(AccountProviders.selectedAccount)!;

    final newWallet = await KeychainUtil().getListAccountsFromKeychain(
      loggedInState.wallet,
      loggedInState.seed,
      selectedCurrency.currency.name,
      selectedAccount.balance!.nativeTokenName!,
      selectedAccount.balance!.tokenPrice!,
      currentName: selectedAccount.name,
    );
    if (newWallet == null) return;

    state = Session.loggedIn(
      seed: loggedInState.seed,
      wallet: newWallet,
    );
  }

  Future<void> logout() async {
    (await Vault.getInstance()).clearAll();
    (await Preferences.getInstance()).clearAll();
    sl.get<DBHelper>().clearAll();

    state = const Session.loggedOut();
    // TODO(Chralu): is it useful ?
    // RestartWidget.restartApp(context);
  }

  Future<void> createNewAppWallet({
    required String seed,
    required String keychainAddress,
    required Keychain keychain,
    String? name,
  }) async {
    final newAppWallet = await AppWallet.createNewAppWallet(
      keychainAddress,
      keychain,
      name,
    );
    state = Session.loggedIn(
      seed: seed,
      wallet: newAppWallet,
    );
  }

  Future<LoggedInSession?> restoreFromMnemonics({
    required List<String> mnemonics,
    required String languageCode,
  }) async {
    final settings = ref.read(SettingsProviders.settings);

    await sl.get<DBHelper>().clearAppWallet();

    final seed = AppMnemomics.mnemonicListToSeed(
      mnemonics,
      languageCode: languageCode,
    );
    final vault = await Vault.getInstance();
    vault.setSeed(seed);
    final tokenPrice = await Price.getCurrency(
      settings.currency.name,
    );

    try {
      final appWallet = await KeychainUtil().getListAccountsFromKeychain(
        null,
        seed,
        settings.currency.name,
        settings.network.getNetworkCryptoCurrencyLabel(),
        tokenPrice,
      );

      if (appWallet == null) {
        return null;
      }

      // StateContainer.of(context).appWallet = appWallet;
      final accounts = appWallet.appKeychain.accounts;

      if (accounts.isEmpty) {
        return null;
      }

      accounts.sort(
        (a, b) => a.name!.compareTo(b.name!),
      );

      return state = LoggedInSession(
        seed: seed,
        wallet: appWallet,
      );
    } catch (e) {
      return null;
    }
  }
}

@Riverpod(keepAlive: false)
Future<List<RecentTransaction>> _recentTransactions(
  _RecentTransactionsRef ref, {
  required String pagingAddress,
}) async {
  final session = ref.watch<Session>(SessionProviders.session).loggedIn;
  if (session == null) {
    return [];
  }

  final selectedAccount = ref.watch(AccountProviders.selectedAccount);

  if (selectedAccount == null) return [];
  selectedAccount.updateRecentTransactions(pagingAddress, session.seed);

  return selectedAccount.recentTransactions ?? [];
}

@riverpod
Future<Keychain?> _archethicWalletKeychain(Ref ref) async {
  final loggedInSession = ref.watch(SessionProviders.session).loggedIn;
  if (loggedInSession == null) return null;

  return sl.get<ApiService>().getKeychain(loggedInSession.seed);
}

abstract class SessionProviders {
  static final session = NotifierProvider<SessionNotifier, Session>(
    SessionNotifier.new,
  );

  static final recentTransactions = _recentTransactionsProvider;

  static final archethicWalletKeychain = _archethicWalletKeychainProvider;
}
