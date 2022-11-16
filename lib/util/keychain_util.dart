/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';

// Project imports:
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/get_it_instance.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';

class KeychainUtil {
  Future<void> createKeyChainAccess(
    NetworksSetting networkSettings,
    String? seed,
    String? name,
    String keychainAddress,
    String originPrivateKey,
    Keychain keychain,
  ) async {
    /// Create Keychain Access for wallet
    final accessKeychainTx = sl.get<ApiService>().newAccessKeychainTransaction(
          seed!,
          hexToUint8List(keychainAddress),
          hexToUint8List(originPrivateKey),
        );

    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
      websocketEndpoint: networkSettings.getWebsocketUri(),
    );

    dev.log('>>> Create access <<< ${accessKeychainTx.address}');
    transactionSender.send(
      transaction: accessKeychainTx,
      onConfirmation: (event) async {
        onConfirmation(
          event,
          transactionSender,
          TransactionSendEventType.keychainAccess,
          params: <String, Object>{
            'keychainAddress': keychainAddress,
            'keychain': keychain
          },
        );
      },
      onError: (error) async {
        onError(
          error,
          transactionSender,
          TransactionSendEventType.keychainAccess,
        );
      },
    );
  }

  Future<void> createKeyChain(
    NetworksSetting networkSettings,
    String? seed,
    String? name,
    String originPrivateKey,
  ) async {
    /// Get Wallet KeyPair
    final walletKeyPair = deriveKeyPair(seed!, 0);

    /// Generate keyChain Seed from random value
    final keychainSeed = uint8ListToHex(
      Uint8List.fromList(
        List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
      ),
    );

    final nameEncoded = Uri.encodeFull(name!);

    /// Default service for wallet
    final kServiceName = 'archethic-wallet-$nameEncoded';
    final kDerivationPathWithoutIndex = "m/650'/$kServiceName/";
    const index = '0';
    final kDerivationPath = '$kDerivationPathWithoutIndex$index';

    final keychain = Keychain(hexToUint8List(keychainSeed), version: 1)
      ..addService(kServiceName, kDerivationPath);

    /// Create Keychain from keyChain seed and wallet public key to encrypt secret
    final keychainTransaction = sl.get<ApiService>().newKeychainTransaction(
          keychainSeed,
          <String>[uint8ListToHex(walletKeyPair.publicKey)],
          hexToUint8List(originPrivateKey),
          serviceName: kServiceName,
          derivationPath: kDerivationPath,
        );

    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
      websocketEndpoint: networkSettings.getWebsocketUri(),
    );

    dev.log('>>> Create keychain <<< ${keychainTransaction.address}');
    transactionSender.send(
      transaction: keychainTransaction,
      onConfirmation: (event) async {
        onConfirmation(
          event,
          transactionSender,
          TransactionSendEventType.keychain,
          params: <String, Object>{
            'keychainAddress': keychainTransaction.address!,
            'originPrivateKey': originPrivateKey,
            'keychain': keychain
          },
        );
      },
      onError: (error) async {
        onError(
          error,
          transactionSender,
          TransactionSendEventType.keychain,
        );
      },
    );
  }

  Future<HiveAppWalletDTO> addAccountInKeyChain(
    HiveAppWalletDTO? appWallet,
    String? seed,
    String? name,
    String currency,
    String networkCurrency,
  ) async {
    Account? selectedAcct;

    final keychain = await sl.get<ApiService>().getKeychain(seed!);

    final originPrivateKey = sl.get<ApiService>().getOriginKey();

    final genesisAddressKeychain =
        deriveAddress(uint8ListToHex(keychain.seed!), 0);

    final nameEncoded = Uri.encodeFull(name!);

    final kServiceName = 'archethic-wallet-$nameEncoded';
    final kDerivationPathWithoutIndex = "m/650'/$kServiceName/";
    const index = '0';
    final kDerivationPath = '$kDerivationPathWithoutIndex$index';
    keychain.addService(kServiceName, kDerivationPath);

    final lastTransactionKeychainMap =
        await sl.get<ApiService>().getLastTransaction(
      [genesisAddressKeychain],
      request:
          'chainLength, data { content, ownerships { authorizedPublicKeys { publicKey } } }',
    );

    final aesKey = uint8ListToHex(
      Uint8List.fromList(
        List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
      ),
    );

    final keychainTransaction =
        Transaction(type: 'keychain', data: Transaction.initData())
            .setContent(jsonEncode(keychain.toDID()));

    final authorizedKeys = List<AuthorizedKey>.empty(growable: true);
    final authorizedKeysList =
        lastTransactionKeychainMap[genesisAddressKeychain]!
            .data!
            .ownerships![0]
            .authorizedPublicKeys!;
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
          lastTransactionKeychainMap[genesisAddressKeychain]!.chainLength!,
        )
        .originSign(originPrivateKey);

    // ignore: unused_local_variable
    final transactionStatusKeychain =
        await sl.get<ApiService>().sendTx(keychainTransaction);

    final genesisAddress = keychain.deriveAddress(kServiceName);
    selectedAcct = Account(
      lastLoadingTransactionInputs: 0,
      lastAddress: uint8ListToHex(genesisAddress),
      genesisAddress: uint8ListToHex(genesisAddress),
      name: name,
      balance: AccountBalance(
        nativeTokenName: networkCurrency,
        nativeTokenValue: 0,
      ),
      recentTransactions: [],
    );

    appWallet!.appKeychain.accounts.add(selectedAcct);
    appWallet.appKeychain.accounts.sort((a, b) => a.name.compareTo(b.name));
    appWallet.appKeychain.accounts.sort((a, b) => a.name.compareTo(b.name));

    final lastTransactionKeychainAddressMap = await sl
        .get<ApiService>()
        .getLastTransaction([genesisAddressKeychain], request: 'address');
    appWallet.appKeychain.address = lastTransactionKeychainAddressMap[
            genesisAddressKeychain]!
        .address!; // TODO(Chralu): Transaction.address should be non-nullable

    await sl.get<DBHelper>().saveAppWallet(appWallet);

    final newContact = Contact(
      name: '@$name',
      address: uint8ListToHex(genesisAddress),
      type: ContactType.keychainService.name,
      publicKey: uint8ListToHex(keychain.deriveKeypair(kServiceName).publicKey)
          .toUpperCase(),
    );
    await sl.get<DBHelper>().saveContact(newContact);

    return appWallet;
  }

  Future<HiveAppWalletDTO?> getListAccountsFromKeychain(
      HiveAppWalletDTO? appWallet,
      String? seed,
      String currency,
      String tokenName,
      {bool loadBalance = true}) async {
    final accounts = List<Account>.empty(growable: true);

    HiveAppWalletDTO currentAppWallet;
    try {
      /// Get KeyChain Wallet
      final keychain = await sl.get<ApiService>().getKeychain(seed!);

      /// Creation of a new appWallet
      if (appWallet == null) {
        final addressKeychain =
            deriveAddress(uint8ListToHex(keychain.seed!), 0);
        final lastTransactionMap =
            await sl.get<ApiService>().getLastTransaction([addressKeychain]);

        currentAppWallet = await sl
            .get<DBHelper>()
            .createAppWallet(lastTransactionMap[addressKeychain]!.address!);
      } else {
        currentAppWallet = appWallet;
      }

      final selectedAccount = currentAppWallet.appKeychain.getAccountSelected();

      const kDerivationPathWithoutService = "m/650'/archethic-wallet-";

      /// Get all services for archethic blockchain
      keychain.services!.forEach((serviceName, service) async {
        if (service.derivationPath!.startsWith(kDerivationPathWithoutService)) {
          final genesisAddress = keychain.deriveAddress(serviceName);

          final path = service.derivationPath!
              .replaceAll(kDerivationPathWithoutService, '')
              .split('/')
            ..last = '';
          var name = path.join('/');
          name = name.substring(0, name.length - 1);

          final nameDecoded = Uri.decodeFull(name);

          final account = Account(
            lastLoadingTransactionInputs:
                DateTime.now().millisecondsSinceEpoch ~/
                    Duration.millisecondsPerSecond,
            lastAddress: uint8ListToHex(genesisAddress),
            genesisAddress: uint8ListToHex(genesisAddress),
            name: nameDecoded,
            balance: AccountBalance(
              nativeTokenName: '',
              nativeTokenValue: 0,
            ),
            recentTransactions: [],
          );
          if (selectedAccount != null && selectedAccount.name == nameDecoded) {
            account.selected = true;
          } else {
            account.selected = false;
          }

          accounts.add(account);

          try {
            await sl.get<DBHelper>().getContactWithName(account.name);
          } catch (e) {
            final newContact = Contact(
              name: '@$nameDecoded',
              address: uint8ListToHex(genesisAddress),
              type: ContactType.keychainService.name,
              publicKey:
                  uint8ListToHex(keychain.deriveKeypair(serviceName).publicKey)
                      .toUpperCase(),
            );
            await sl.get<DBHelper>().saveContact(newContact);
          }
        }
      });
      if (loadBalance) {
        for (var i = 0; i < accounts.length; i++) {
          await accounts[i].updateBalance();
        }
      }
      final genesisAddressKeychain =
          deriveAddress(uint8ListToHex(keychain.seed!), 0);

      final lastTransactionKeychainMap = await sl
          .get<ApiService>()
          .getLastTransaction([genesisAddressKeychain], request: 'address');
      currentAppWallet.appKeychain.address =
          lastTransactionKeychainMap[genesisAddressKeychain]!.address!;
      accounts.sort((a, b) => a.name.compareTo(b.name));
      currentAppWallet.appKeychain.accounts = accounts;

      await sl.get<DBHelper>().saveAppWallet(currentAppWallet);
    } catch (e) {
      throw Exception();
    }

    return currentAppWallet;
  }

  void onConfirmation(
    TransactionConfirmation confirmation,
    TransactionSenderInterface transactionSender,
    TransactionSendEventType transactionSendEventType, {
    Map<String, Object>? params,
  }) {
    EventTaxiImpl.singleton().fire(
      TransactionSendEvent(
        transactionType: transactionSendEventType,
        response: 'ok',
        nbConfirmations: confirmation.nbConfirmations,
        maxConfirmations: confirmation.maxConfirmations,
        params: params,
      ),
    );
  }

  void onError(
    TransactionError error,
    TransactionSenderInterface transactionSender,
    TransactionSendEventType transactionSendEventType, {
    Map<String, Object>? params,
  }) {
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
