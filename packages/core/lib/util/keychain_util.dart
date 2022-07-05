/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:core/model/data/account.dart';
import 'package:core/model/data/account_balance.dart';
import 'package:core/model/data/app_wallet.dart';

// Project imports:
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/price.dart';
import 'package:core/util/get_it_instance.dart';

class KeychainUtil {
  Future<AppWallet?> newAppWallet(String? seed, String? name) async {
    Account? selectedAcct;

    /// Get Wallet KeyPair
    final KeyPair walletKeyPair = deriveKeyPair(seed!, 0);

    /// Generate keyChain Seed from random value
    final String keychainSeed = uint8ListToHex(Uint8List.fromList(
        List<int>.generate(32, (int i) => Random.secure().nextInt(256))));

    /// Default service for wallet
    String kServiceName = 'archethic-wallet-$name';
    String kDerivationPathWithoutIndex = 'm/650\'/$kServiceName/';
    const String index = '0';
    String kDerivationPath = '$kDerivationPathWithoutIndex$index';

    final String originPrivateKey = await sl.get<ApiService>().getOriginKey();

    Keychain keychain = Keychain(hexToUint8List(keychainSeed), version: 1);
    keychain.addService(kServiceName, kDerivationPath);

    /// Create Keychain from keyChain seed and wallet public key to encrypt secret
    final Transaction keychainTransaction = await sl
        .get<ApiService>()
        .newKeychainTransaction(
            keychainSeed,
            <String>[uint8ListToHex(walletKeyPair.publicKey)],
            hexToUint8List(originPrivateKey),
            serviceName: kServiceName,
            derivationPath: kDerivationPath);

    /// Create Keychain Access for wallet
    final Transaction accessKeychainTx = await sl
        .get<ApiService>()
        .newAccessKeychainTransaction(
            seed,
            hexToUint8List(keychainTransaction.address!),
            hexToUint8List(originPrivateKey));

    // ignore: unused_local_variable
    final TransactionStatus transactionStatusKeychain =
        await sl.get<ApiService>().sendTx(keychainTransaction);

    // ignore: unused_local_variable
    final TransactionStatus transactionStatusKeychainAccess =
        await sl.get<ApiService>().sendTx(accessKeychainTx);

    // TODO: Crypt Seed
    AppWallet appWallet = await sl
        .get<DBHelper>()
        .createAppWallet('', keychainTransaction.address!);

    Uint8List genesisAddress = keychain.deriveAddress(kServiceName, index: 0);
    selectedAcct = Account(
        lastLoadingTransactionInputs: 0,
        lastAddress: uint8ListToHex(genesisAddress),
        genesisAddress: uint8ListToHex(genesisAddress),
        name: name,
        balance: AccountBalance(
            fiatCurrencyCode: '',
            fiatCurrencyValue: 0,
            nativeTokenName: '',
            nativeTokenValue: 0),
        selected: true,
        recentTransactions: []);
    appWallet = await sl.get<DBHelper>().addAccount(selectedAcct);

    return appWallet;
  }

  Future<Account?> addAccountInKeyChain(String? seed, String? name) async {
    Account? selectedAcct;

    final Keychain keychain = await sl.get<ApiService>().getKeychain(seed!);

    final String originPrivateKey = await sl.get<ApiService>().getOriginKey();

    final String genesisAddressKeychain =
        deriveAddress(uint8ListToHex(keychain.seed!), 0);

    String kServiceName = 'archethic-wallet-$name';
    String kDerivationPathWithoutIndex = 'm/650\'/$kServiceName/';
    const String index = '0';
    String kDerivationPath = '$kDerivationPathWithoutIndex$index';
    keychain.addService(kServiceName, kDerivationPath);

    final Transaction lastTransactionKeychain = await sl
        .get<ApiService>()
        .getLastTransaction(genesisAddressKeychain,
            request:
                'chainLength, data { content, ownerships { authorizedPublicKeys { publicKey } } }');

    final String aesKey = uint8ListToHex(Uint8List.fromList(
        List<int>.generate(32, (int i) => Random.secure().nextInt(256))));

    Transaction keychainTransaction =
        Transaction(type: 'keychain', data: Transaction.initData())
            .setContent(jsonEncode(keychain.toDID()));

    final List<AuthorizedKey> authorizedKeys =
        List<AuthorizedKey>.empty(growable: true);
    List<AuthorizedKey> authorizedKeysList =
        lastTransactionKeychain.data!.ownerships![0].authorizedPublicKeys!;
    authorizedKeysList.forEach((AuthorizedKey authorizedKey) {
      authorizedKeys.add(AuthorizedKey(
          encryptedSecretKey:
              uint8ListToHex(ecEncrypt(aesKey, authorizedKey.publicKey)),
          publicKey: authorizedKey.publicKey));
    });

    keychainTransaction.addOwnership(
        aesEncrypt(keychain.encode(), aesKey), authorizedKeys);

    keychainTransaction
        .build(uint8ListToHex(keychain.seed!),
            lastTransactionKeychain.chainLength!)
        .originSign(originPrivateKey);

    // ignore: unused_local_variable
    final TransactionStatus transactionStatusKeychain =
        await sl.get<ApiService>().sendTx(keychainTransaction);

    Uint8List genesisAddress = keychain.deriveAddress(kServiceName, index: 0);
    selectedAcct = Account(
        lastLoadingTransactionInputs: 0,
        lastAddress: uint8ListToHex(genesisAddress),
        genesisAddress: uint8ListToHex(genesisAddress),
        name: name,
        balance: AccountBalance(
            fiatCurrencyCode: '',
            fiatCurrencyValue: 0,
            nativeTokenName: '',
            nativeTokenValue: 0),
        selected: false,
        recentTransactions: []);

    return selectedAcct;
  }

  Future<List<Account>?> getListAccountsFromKeychain(AppWallet appWallet,
      String? seed, String currency, String tokenName, Price tokenPrice,
      {String? currentName = ''}) async {
    List<Account> accounts = List<Account>.empty(growable: true);

    try {
      /// Get KeyChain Wallet
      final Keychain keychain = await sl.get<ApiService>().getKeychain(seed!);

      const String kDerivationPathWithoutService = 'm/650\'/archethic-wallet-';

      /// Get all services for archethic blockchain
      keychain.services!.forEach((serviceName, service) async {
        if (service.derivationPath!.startsWith(kDerivationPathWithoutService)) {
          Uint8List genesisAddress =
              keychain.deriveAddress(serviceName, index: 0);

          String name = service.derivationPath!
              .replaceAll(kDerivationPathWithoutService, '')
              .split('/')[0];
          Account account = Account(
              lastLoadingTransactionInputs: 0,
              lastAddress: uint8ListToHex(genesisAddress),
              genesisAddress: uint8ListToHex(genesisAddress),
              name: name,
              balance: AccountBalance(
                  fiatCurrencyCode: '',
                  fiatCurrencyValue: 0,
                  nativeTokenName: '',
                  nativeTokenValue: 0),
              recentTransactions: []);
          if (currentName == name) {
            account.selected = true;
          } else {
            account.selected = false;
          }

          accounts.add(account);
        }
      });

      for (int i = 0; i < accounts.length; i++) {
        String? lastAddress = await sl
            .get<AddressService>()
            .lastAddressFromAddress(accounts[i].genesisAddress!);
        if (lastAddress.isNotEmpty) {
          accounts[i].lastAddress = lastAddress;
        }
        await accounts[i].updateBalance(tokenName, currency, tokenPrice);
      }
      appWallet.appKeychain!.accounts = accounts;
      appWallet.save();
    } catch (e) {}

    return accounts;
  }
}
