/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:math';
import 'dart:typed_data';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

// Project imports:
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/vault.dart';

class KeychainUtil {
  Future<Account?> addAccount(String? seed, String? name) async {
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

    /// Get KeyChain Wallet
    final Keychain keychain = await sl.get<ApiService>().getKeychain(seed);

    /// Get all services for archethic blockchain
    keychain.services!.forEach((serviceName, service) async {
      /// For the moment, only one account for wallet : services "uco-wallet-main"
      /// When multi accounts will be implemented in archethic wallet, user could choose by himself the name of services
      /// The wallet app will force the account in the derivation path with nameService = Account
      if (service.derivationPath!.startsWith(kDerivationPathWithoutIndex) &&
          serviceName == kServiceName) {
        Uint8List genesisAddress =
            keychain.deriveAddress(serviceName, index: 0);
        selectedAcct = Account(
            lastAccess: 0,
            lastAddress: uint8ListToHex(genesisAddress),
            genesisAddress: uint8ListToHex(genesisAddress),
            name: name,
            selected: true);
        await sl.get<DBHelper>().addAccount(selectedAcct!);
      }
    });

    return selectedAcct;
  }

  Future<List<Account>?> getListAccountsFromKeychain(String? seed) async {
    List<Account> accounts = List<Account>.empty(growable: true);

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
            selected: true);
        accounts.add(account);
      }
    });
    return accounts;
  }
}
