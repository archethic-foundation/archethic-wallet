/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:developer' as dev;

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

// Project imports:
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/get_it_instance.dart';

class KeychainUtil {
  Future<Account?> newAccount(String? seed, String? name) async {
    Account? selectedAcct;

    /// Get Wallet KeyPair
    final KeyPair walletKeyPair = deriveKeyPair(seed!, 0);

    /// Generate keyChain Seed from random value
    final String keychainSeed = uint8ListToHex(Uint8List.fromList(
        List<int>.generate(32, (int i) => Random.secure().nextInt(256))));

    /// Default service for wallet
    String formatName = name!.replaceAll(' ', '-');
    String kServiceName = 'archethic-wallet-$formatName';
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

    Uint8List genesisAddress = keychain.deriveAddress(kServiceName, index: 0);
    selectedAcct = Account(
        lastAccess: 0,
        lastAddress: uint8ListToHex(genesisAddress),
        genesisAddress: uint8ListToHex(genesisAddress),
        name: name,
        selected: true);
    await sl.get<DBHelper>().addAccount(selectedAcct);

    return selectedAcct;
  }

  Future<Account?> addAccountInKeyChain(String? seed, String? name) async {
    Account? selectedAcct;

    final Keychain keychain = await sl.get<ApiService>().getKeychain(seed!);

    final String originPrivateKey = await sl.get<ApiService>().getOriginKey();

    final String genesisAddressKeychain =
        deriveAddress(uint8ListToHex(keychain.seed!), 0);

    String formatName = name!.replaceAll(' ', '-');
    String kServiceName = 'archethic-wallet-$formatName';
    String kDerivationPathWithoutIndex = 'm/650\'/$kServiceName/';
    const String index = '0';
    String kDerivationPath = '$kDerivationPathWithoutIndex$index';
    keychain.addService(kServiceName, kDerivationPath);

    final Transaction lastTransactionKeychain =
        await sl.get<ApiService>().getLastTransaction(genesisAddressKeychain);

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
        lastAccess: 0,
        lastAddress: uint8ListToHex(genesisAddress),
        genesisAddress: uint8ListToHex(genesisAddress),
        name: name,
        balance: '0.0',
        selected: false);
    await sl.get<DBHelper>().addAccount(selectedAcct);

    return selectedAcct;
  }

  Future<List<Account>?> getListAccountsFromKeychain(
      String? seed, String? currentName) async {
    List<Account> accounts = List<Account>.empty(growable: true);

    try {
      /// Get KeyChain Wallet
      final Keychain keychain = await sl.get<ApiService>().getKeychain(seed!);

      const String kDerivationPathWithoutService = 'm/650\'/archethic-wallet-';

      /// Get all services for archethic blockchain
      keychain.services!.forEach((serviceName, service) async {
        /// For the moment, only one account for wallet : services "uco-wallet-main"
        /// When multi accounts will be implemented in archethic wallet, user could choose by himself the name of services
        /// The wallet app will force the account in the derivation path with nameService = Account
        if (service.derivationPath!.startsWith(kDerivationPathWithoutService)) {
          Uint8List genesisAddress =
              keychain.deriveAddress(serviceName, index: 0);

          String name = service.derivationPath!
              .replaceAll(kDerivationPathWithoutService, '')
              .split('/')[0];
          Account account = Account(
              lastAccess: 0,
              lastAddress: uint8ListToHex(genesisAddress),
              genesisAddress: uint8ListToHex(genesisAddress),
              name: name,
              balance: '0');
          if (currentName == name) {
            account.selected = true;
          } else {
            account.selected = false;
          }

          accounts.add(account);
        }
      });

      for (int i = 0; i <= accounts.length; i++) {
        String? lastAddress = await sl
            .get<AddressService>()
            .lastAddressFromAddress(accounts[i].genesisAddress!);
        if (lastAddress.isNotEmpty) {
          accounts[i].lastAddress = lastAddress;
        }

        final Balance balance = await sl
            .get<AppService>()
            .getBalanceGetResponse(accounts[i].lastAddress!);
        if (balance.uco != null) {
          accounts[i].balance = balance.uco.toString();
        }
      }
    } catch (e) {}

    return accounts;
  }
}
