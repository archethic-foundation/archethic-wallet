part of 'wallet.dart';

@Riverpod(keepAlive: true)
class _SessionNotifier extends Notifier<Session> {
  final DBHelper _dbHelper = sl.get<DBHelper>();

  @override
  Session build() {
    return const Session.loggedOut();
  }

  Future<void> restore() async {
    final vault = await HiveVaultDatasource.getInstance();

    final seed = vault.getSeed();
    var keychainSecuredInfos = vault.getKeychainSecuredInfos();
    if (keychainSecuredInfos == null && seed != null) {
      // Create manually Keychain
      final keychain = await sl.get<ApiService>().getKeychain(seed);
      keychainSecuredInfos = keychain.toKeychainSecuredInfos();
      await vault.setKeychainSecuredInfos(keychainSecuredInfos);
    }
    final appWalletDTO = await _dbHelper.getAppWallet();

    if (seed == null || appWalletDTO == null) {
      await logout();
      return;
    }

    state = Session.loggedIn(
      wallet: appWalletDTO.toModel(
        seed: seed,
        keychainSecuredInfos: keychainSecuredInfos!,
      ),
    );
  }

  Future<void> refresh() async {
    if (state.isLoggedOut) return;
    final connectivityStatusProvider = ref.read(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
      return;
    }

    final loggedInState = state.loggedIn!;
    final selectedCurrency = ref.read(
      SettingsProviders.settings.select((settings) => settings.currency),
    );

    try {
      final keychain =
          await sl.get<ApiService>().getKeychain(loggedInState.wallet.seed);

      final keychainSecuredInfos = keychain.toKeychainSecuredInfos();

      final vault = await HiveVaultDatasource.getInstance();
      await vault.setKeychainSecuredInfos(keychainSecuredInfos);

      final newWalletDTO = await KeychainUtil().getListAccountsFromKeychain(
        keychain,
        HiveAppWalletDTO.fromModel(loggedInState.wallet),
        selectedCurrency.name,
        AccountBalance.cryptoCurrencyLabel,
      );
      if (newWalletDTO == null) return;

      state = Session.loggedIn(
        wallet: loggedInState.wallet.copyWith(
          keychainSecuredInfos: keychainSecuredInfos,
          appKeychain: newWalletDTO.appKeychain,
        ),
      );
    } catch (e) {}
  }

  Future<void> logout() async {
    await ref.read(SettingsProviders.settings.notifier).reset();
    await AuthenticationProviders.reset(ref);
    await ContactProviders.reset(ref);

    await (await HiveVaultDatasource.getInstance()).clearAll();
    await _dbHelper.clearAppWallet();

    state = const Session.loggedOut();
  }

  Future<void> createNewAppWallet({
    required String seed,
    required String keychainAddress,
    required Keychain keychain,
    String? name,
  }) async {
    final newAppWalletDTO = await HiveAppWalletDTO.createNewAppWallet(
      keychainAddress,
      keychain,
      name,
    );

    final keychainSecuredInfos = keychain.toKeychainSecuredInfos();

    final vault = await HiveVaultDatasource.getInstance();
    await vault.setKeychainSecuredInfos(keychainSecuredInfos);

    state = Session.loggedIn(
      wallet: newAppWalletDTO.toModel(
        seed: seed,
        keychainSecuredInfos: keychainSecuredInfos,
      ),
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
    final vault = await HiveVaultDatasource.getInstance();
    vault.setSeed(seed);

    try {
      final keychain = await sl.get<ApiService>().getKeychain(seed);

      final appWallet = await KeychainUtil().getListAccountsFromKeychain(
        keychain,
        null,
        settings.currency.name,
        AccountBalance.cryptoCurrencyLabel,
        loadBalance: false,
      );

      if (appWallet == null) {
        return null;
      }

      final keychainSecuredInfos = keychain.toKeychainSecuredInfos();

      await vault.setKeychainSecuredInfos(keychainSecuredInfos);

      return state = LoggedInSession(
        wallet: appWallet.toModel(
          seed: seed,
          keychainSecuredInfos: keychainSecuredInfos,
        ),
      );
    } catch (e) {
      return null;
    }
  }
}

abstract class SessionProviders {
  static final session = _sessionNotifierProvider;
}
