part of 'wallet.dart';

@Riverpod(keepAlive: true)
class _SessionNotifier extends Notifier<Session> {
  HiveVaultDatasource? __vault;
  Future<HiveVaultDatasource> get _vault async =>
      __vault ??= await HiveVaultDatasource.getInstance();

  final DBHelper _dbHelper = sl.get<DBHelper>();

  @override
  Session build() {
    return const Session.loggedOut();
  }

  Future<void> restore() async {
    final seed = (await _vault).getSeed();
    final keychainServiceKeyPairMap =
        (await _vault).getKeychainServiceKeyPairMap();
    final appWalletDTO = await _dbHelper.getAppWallet();

    if (seed == null || appWalletDTO == null) {
      await logout();
      return;
    }

    state = Session.loggedIn(
      wallet: appWalletDTO.toModel(
        seed: seed,
        keychainServiceKeyPairMap: keychainServiceKeyPairMap,
      ),
    );
  }

  Future<void> refresh() async {
    if (state.isLoggedOut) return;

    final loggedInState = state.loggedIn!;
    final selectedCurrency = ref.read(
      SettingsProviders.settings.select((settings) => settings.currency),
    );

    final keychain =
        await sl.get<ApiService>().getKeychain(loggedInState.wallet.seed);

    final keychainServiceKeyPairMap = <String, KeychainServiceKeyPair>{};
    if (keychain.services != null) {
      keychain.services!.forEach((key, value) {
        final keyPair = keychain.deriveKeypair(key);
        keychainServiceKeyPairMap[key.replaceAll('archethic-wallet-', '')] =
            KeychainServiceKeyPair(
          privateKey: keyPair.privateKey,
          publicKey: keyPair.publicKey,
        );
      });
      final vault = await HiveVaultDatasource.getInstance();
      await vault.setKeychainServiceKeyPairMap(keychainServiceKeyPairMap);
    }

    final newWalletDTO = await KeychainUtil().getListAccountsFromKeychain(
      keychain,
      HiveAppWalletDTO.fromModel(loggedInState.wallet),
      selectedCurrency.name,
      AccountBalance.cryptoCurrencyLabel,
    );
    if (newWalletDTO == null) return;

    state = Session.loggedIn(
      wallet: loggedInState.wallet.copyWith(
        keychainServiceKeyPairMap: keychainServiceKeyPairMap,
        appKeychain: newWalletDTO.appKeychain,
      ),
    );
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

    final keychainServiceKeyPairMap = <String, KeychainServiceKeyPair>{};
    keychain.services!.forEach((key, value) {
      final keyPair = keychain.deriveKeypair(key);
      keychainServiceKeyPairMap[key.replaceAll('archethic-wallet-', '')] =
          KeychainServiceKeyPair(
        privateKey: keyPair.privateKey,
        publicKey: keyPair.publicKey,
      );
    });
    final vault = await HiveVaultDatasource.getInstance();
    await vault.setKeychainServiceKeyPairMap(keychainServiceKeyPairMap);

    state = Session.loggedIn(
      wallet: newAppWalletDTO.toModel(
        seed: seed,
        keychainServiceKeyPairMap: keychainServiceKeyPairMap,
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

      final keychainServiceKeyPairMap = <String, KeychainServiceKeyPair>{};
      keychain.services!.forEach((key, value) {
        final keyPair = keychain.deriveKeypair(key);
        keychainServiceKeyPairMap[key.replaceAll('archethic-wallet-', '')] =
            KeychainServiceKeyPair(
          privateKey: keyPair.privateKey,
          publicKey: keyPair.publicKey,
        );
      });
      await vault.setKeychainServiceKeyPairMap(keychainServiceKeyPairMap);

      return state = LoggedInSession(
        wallet: appWallet.toModel(
          seed: seed,
          keychainServiceKeyPairMap: keychainServiceKeyPairMap,
        ),
      );
    } catch (e) {
      return null;
    }
  }
}

@riverpod
Future<Keychain?> _archethicWalletKeychain(Ref ref) async {
  final loggedInSession = ref.watch(SessionProviders.session).loggedIn;
  if (loggedInSession == null) return null;

  return sl.get<ApiService>().getKeychain(loggedInSession.wallet.seed);
}

abstract class SessionProviders {
  static final session = _sessionNotifierProvider;

  static final archethicWalletKeychain = _archethicWalletKeychainProvider;
}
