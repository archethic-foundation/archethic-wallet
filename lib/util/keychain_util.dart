/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// Project imports:
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/app_wallet.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/util/confirmations/subscription_channel.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/preferences.dart';

class KeychainUtil {
  Future<Transaction?> createKeyChainAccess(
    String? seed,
    String? name,
    String keychainAddress,
    String originPrivateKey,
    Keychain keychain,
    SubscriptionChannel subscriptionChannel,
  ) async {
    /// Create Keychain Access for wallet
    final Transaction accessKeychainTx =
        sl.get<ApiService>().newAccessKeychainTransaction(
              seed!,
              hexToUint8List(keychainAddress),
              hexToUint8List(originPrivateKey),
            );

    void waitConfirmationsKeychainAccess(QueryResult event) {
      final Map<String, Object> params = {
        'keychainAddress': keychainAddress,
        'keychain': keychain
      };

      waitConfirmations(
        event,
        TransactionSendEventType.keychainAccess,
        params: params,
      );
    }

    subscriptionChannel.addSubscriptionTransactionConfirmed(
      accessKeychainTx.address!,
      waitConfirmationsKeychainAccess,
    );

    await Future.delayed(const Duration(seconds: 1));

    // ignore: unused_local_variable
    final TransactionStatus transactionStatusKeychainAccess =
        await sl.get<ApiService>().sendTx(accessKeychainTx);

    return accessKeychainTx;
  }

  Future<void> createKeyChain(
    String? seed,
    String? name,
    String originPrivateKey,
    Preferences preferences,
    SubscriptionChannel subscriptionChannel,
  ) async {
    /// Get Wallet KeyPair
    final KeyPair walletKeyPair = deriveKeyPair(seed!, 0);

    /// Generate keyChain Seed from random value
    final String keychainSeed = uint8ListToHex(
      Uint8List.fromList(
        List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
      ),
    );

    final String nameEncoded = Uri.encodeFull(name!);

    /// Default service for wallet
    final String kServiceName = 'archethic-wallet-$nameEncoded';
    final String kDerivationPathWithoutIndex = "m/650'/$kServiceName/";
    const String index = '0';
    final String kDerivationPath = '$kDerivationPathWithoutIndex$index';

    final Keychain keychain =
        Keychain(hexToUint8List(keychainSeed), version: 1);
    keychain.addService(kServiceName, kDerivationPath);

    /// Create Keychain from keyChain seed and wallet public key to encrypt secret
    final Transaction keychainTransaction =
        sl.get<ApiService>().newKeychainTransaction(
              keychainSeed,
              <String>[uint8ListToHex(walletKeyPair.publicKey)],
              hexToUint8List(originPrivateKey),
              serviceName: kServiceName,
              derivationPath: kDerivationPath,
            );

    void waitConfirmationsKeychain(QueryResult event) {
      final Map<String, Object> params = {
        'keychainAddress': keychainTransaction.address!,
        'originPrivateKey': originPrivateKey,
        'keychain': keychain
      };
      waitConfirmations(
        event,
        TransactionSendEventType.keychain,
        params: params,
      );
    }

    subscriptionChannel.addSubscriptionTransactionConfirmed(
      keychainTransaction.address!,
      waitConfirmationsKeychain,
    );

    await Future.delayed(const Duration(seconds: 1));

    // ignore: unused_local_variable
    final TransactionStatus transactionStatusKeychain =
        await sl.get<ApiService>().sendTx(keychainTransaction);
  }

  Future<AppWallet?> addAccountInKeyChain(
    AppWallet? appWallet,
    String? seed,
    String? name,
    String currency,
    String networkCurrency,
  ) async {
    Account? selectedAcct;

    final Keychain keychain = await sl.get<ApiService>().getKeychain(seed!);

    final String originPrivateKey = sl.get<ApiService>().getOriginKey();

    final String genesisAddressKeychain =
        deriveAddress(uint8ListToHex(keychain.seed!), 0);

    final String nameEncoded = Uri.encodeFull(name!);

    final String kServiceName = 'archethic-wallet-$nameEncoded';
    final String kDerivationPathWithoutIndex = "m/650'/$kServiceName/";
    const String index = '0';
    final String kDerivationPath = '$kDerivationPathWithoutIndex$index';
    keychain.addService(kServiceName, kDerivationPath);

    final Transaction lastTransactionKeychain =
        await sl.get<ApiService>().getLastTransaction(
              genesisAddressKeychain,
              request:
                  'chainLength, data { content, ownerships { authorizedPublicKeys { publicKey } } }',
            );

    final String aesKey = uint8ListToHex(
      Uint8List.fromList(
        List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
      ),
    );

    final Transaction keychainTransaction =
        Transaction(type: 'keychain', data: Transaction.initData())
            .setContent(jsonEncode(keychain.toDID()));

    final List<AuthorizedKey> authorizedKeys =
        List<AuthorizedKey>.empty(growable: true);
    final List<AuthorizedKey> authorizedKeysList =
        lastTransactionKeychain.data!.ownerships![0].authorizedPublicKeys!;
    for (final authorizedKey in authorizedKeysList) {
      authorizedKeys.add(
        AuthorizedKey(
          encryptedSecretKey:
              uint8ListToHex(ecEncrypt(aesKey, authorizedKey.publicKey)),
          publicKey: authorizedKey.publicKey,
        ),
      );
    }

    keychainTransaction.addOwnership(
      aesEncrypt(keychain.encode(), aesKey),
      authorizedKeys,
    );

    keychainTransaction
        .build(
          uint8ListToHex(keychain.seed!),
          lastTransactionKeychain.chainLength!,
        )
        .originSign(originPrivateKey);

    // ignore: unused_local_variable
    final TransactionStatus transactionStatusKeychain =
        await sl.get<ApiService>().sendTx(keychainTransaction);

    final Price tokenPrice = await Price.getCurrency(currency);

    final Uint8List genesisAddress = keychain.deriveAddress(kServiceName);
    selectedAcct = Account(
      lastLoadingTransactionInputs: 0,
      lastAddress: uint8ListToHex(genesisAddress),
      genesisAddress: uint8ListToHex(genesisAddress),
      name: name,
      balance: AccountBalance(
        fiatCurrencyCode: '',
        fiatCurrencyValue: 0,
        nativeTokenName: networkCurrency,
        nativeTokenValue: 0,
        tokenPrice: tokenPrice,
      ),
      recentTransactions: [],
    );

    appWallet!.appKeychain!.accounts!.add(selectedAcct);
    appWallet.appKeychain!.accounts!.sort((a, b) => a.name!.compareTo(b.name!));

    final Transaction lastTransactionKeychainAddress = await sl
        .get<ApiService>()
        .getLastTransaction(genesisAddressKeychain, request: 'address');
    appWallet.appKeychain!.address = lastTransactionKeychainAddress.address;

    await appWallet.save();

    final Contact newContact = Contact(
      name: '@$name',
      address: uint8ListToHex(genesisAddress),
      type: 'keychainService',
    );
    await sl.get<DBHelper>().saveContact(newContact);

    return appWallet;
  }

  Future<AppWallet?> getListAccountsFromKeychain(
    AppWallet? appWallet,
    String? seed,
    String currency,
    String tokenName,
    Price tokenPrice, {
    String? currentName = '',
    bool loadBalance = true,
    bool loadRecentTransactions = true,
  }) async {
    final List<Account> accounts = List<Account>.empty(growable: true);

    AppWallet currentAppWallet;
    try {
      /// Get KeyChain Wallet
      final Keychain keychain = await sl.get<ApiService>().getKeychain(seed!);

      /// Creation of a new appWallet
      if (appWallet == null) {
        final String addressKeychain =
            deriveAddress(uint8ListToHex(keychain.seed!), 0);
        final Transaction lastTransaction =
            await sl.get<ApiService>().getLastTransaction(addressKeychain);

        currentAppWallet = await sl
            .get<DBHelper>()
            .createAppWallet('', lastTransaction.address!);
      } else {
        currentAppWallet = appWallet;
      }

      const String kDerivationPathWithoutService = "m/650'/archethic-wallet-";

      final Price tokenPrice = await Price.getCurrency(currency);

      /// Get all services for archethic blockchain
      keychain.services!.forEach((serviceName, service) async {
        if (service.derivationPath!.startsWith(kDerivationPathWithoutService)) {
          final Uint8List genesisAddress = keychain.deriveAddress(serviceName);

          final List<String> path = service.derivationPath!
              .replaceAll(kDerivationPathWithoutService, '')
              .split('/');
          path.last = '';
          String name = path.join('/');
          name = name.substring(0, name.length - 1);

          final String nameDecoded = Uri.decodeFull(name);

          final Account account = Account(
            lastLoadingTransactionInputs:
                DateTime.now().millisecondsSinceEpoch ~/
                    Duration.millisecondsPerSecond,
            lastAddress: uint8ListToHex(genesisAddress),
            genesisAddress: uint8ListToHex(genesisAddress),
            name: nameDecoded,
            balance: AccountBalance(
              fiatCurrencyCode: '',
              fiatCurrencyValue: 0,
              nativeTokenName: '',
              nativeTokenValue: 0,
              tokenPrice: tokenPrice,
            ),
            recentTransactions: [],
          );
          if (currentName == nameDecoded) {
            account.selected = true;
          } else {
            account.selected = false;
          }

          accounts.add(account);

          try {
            await sl.get<DBHelper>().getContactWithName(account.name!);
          } catch (e) {
            final Contact newContact = Contact(
              name: '@$nameDecoded',
              address: uint8ListToHex(genesisAddress),
              type: 'keychainService',
            );
            await sl.get<DBHelper>().saveContact(newContact);
          }
        }
      });

      for (int i = 0; i < accounts.length; i++) {
        final String lastAddress = await sl
            .get<AddressService>()
            .lastAddressFromAddress(accounts[i].genesisAddress!);
        if (lastAddress.isNotEmpty) {
          accounts[i].lastAddress = lastAddress;
        }
        if (loadBalance) {
          await accounts[i].updateBalance(tokenName, currency, tokenPrice);
          await accounts[i].updateFungiblesTokens();
        }
        if (loadRecentTransactions) {
          await accounts[i].updateRecentTransactions('', seed);
        }
      }
      final String genesisAddressKeychain =
          deriveAddress(uint8ListToHex(keychain.seed!), 0);

      final Transaction lastTransactionKeychain = await sl
          .get<ApiService>()
          .getLastTransaction(genesisAddressKeychain, request: 'address');
      currentAppWallet.appKeychain!.address = lastTransactionKeychain.address;
      accounts.sort((a, b) => a.name!.compareTo(b.name!));
      currentAppWallet.appKeychain!.accounts = accounts;

      await currentAppWallet.save();
    } catch (e) {
      throw Exception();
    }

    return currentAppWallet;
  }

  void waitConfirmations(
    QueryResult event,
    TransactionSendEventType transactionSendEventType, {
    Map<String, Object>? params,
  }) {
    int nbConfirmations = 0;
    int maxConfirmations = 0;
    if (event.data != null && event.data!['transactionConfirmed'] != null) {
      if (event.data!['transactionConfirmed']['nbConfirmations'] != null) {
        nbConfirmations =
            event.data!['transactionConfirmed']['nbConfirmations'];
      }
      if (event.data!['transactionConfirmed']['maxConfirmations'] != null) {
        maxConfirmations =
            event.data!['transactionConfirmed']['maxConfirmations'];
      }
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
          transactionType: transactionSendEventType,
          response: 'ok',
          nbConfirmations: nbConfirmations,
          maxConfirmations: maxConfirmations,
          params: params,
        ),
      );
    } else {
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
          transactionType: transactionSendEventType,
          nbConfirmations: 0,
          maxConfirmations: 0,
          response: 'ko',
        ),
      );
    }
  }
}
