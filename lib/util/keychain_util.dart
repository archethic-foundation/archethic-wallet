/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';

import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/repositories/transaction_validation_ratios.dart';
import 'package:aewallet/infrastructure/datasources/appwallet.hive.dart';
import 'package:aewallet/infrastructure/datasources/contacts.hive.dart';
import 'package:aewallet/infrastructure/repositories/transaction/transaction_keychain_builder.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/blockchain/keychain_secured_infos_service.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';

class KeychainUtil with KeychainServiceMixin {
  final appWalletDatasource = AppWalletHiveDatasource.instance();

  Future<void> createKeyChainAccess(
    NetworksSetting networkSettings,
    String? seed,
    String keychainAddress,
    String originPrivateKey,
    Keychain keychain,
  ) async {
    final blockchainTxVersion = int.parse(
      (await sl.get<ApiService>().getBlockchainVersion()).version.transaction,
    );

    /// Create Keychain Access for wallet
    final accessKeychainTx = sl.get<ApiService>().newAccessKeychainTransaction(
          seed!,
          hexToUint8List(keychainAddress),
          hexToUint8List(originPrivateKey),
          blockchainTxVersion,
        );

    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
      websocketEndpoint: networkSettings.getWebsocketUri(),
      apiService: sl.get<ApiService>(),
    );

    dev.log('>>> Create access <<< ${accessKeychainTx.address}');
    await transactionSender.send(
      transaction: accessKeychainTx,
      onConfirmation: (event) async {
        if (TransactionConfirmation.isEnoughConfirmations(
          event.nbConfirmations,
          event.maxConfirmations,
          TransactionValidationRatios.createKeychainAccess,
        )) {
          transactionSender.close();
          onConfirmation(
            event,
            transactionSender,
            TransactionSendEventType.keychainAccess,
            params: <String, Object>{
              'keychainAddress': keychainAddress,
              'keychain': keychain,
            },
          );
        }
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

    /// Default service for wallet
    final kServiceName = 'archethic-wallet-${Uri.encodeFull(name!)}';
    final kDerivationPathWithoutIndex = "m/650'/$kServiceName/";
    const index = '0';
    final kDerivationPath = '$kDerivationPathWithoutIndex$index';

    final keychain = Keychain(seed: hexToUint8List(keychainSeed))
        .copyWithService(kServiceName, kDerivationPath);

    final blockchainTxVersion = int.parse(
      (await sl.get<ApiService>().getBlockchainVersion()).version.transaction,
    );

    /// Create Keychain from keyChain seed and wallet public key to encrypt secret
    final keychainTransaction = sl.get<ApiService>().newKeychainTransaction(
          keychainSeed,
          <String>[uint8ListToHex(walletKeyPair.publicKey!)],
          hexToUint8List(originPrivateKey),
          blockchainTxVersion,
          serviceName: kServiceName,
          derivationPath: kDerivationPath,
        );

    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
      websocketEndpoint: networkSettings.getWebsocketUri(),
      apiService: sl.get<ApiService>(),
    );

    dev.log('>>> Create keychain <<< ${keychainTransaction.address}');
    await transactionSender.send(
      transaction: keychainTransaction,
      onConfirmation: (event) async {
        if (TransactionConfirmation.isEnoughConfirmations(
          event.nbConfirmations,
          event.maxConfirmations,
          TransactionValidationRatios.createKeychain,
        )) {
          transactionSender.close();
          onConfirmation(
            event,
            transactionSender,
            TransactionSendEventType.keychain,
            params: <String, Object>{
              'keychainAddress':
                  keychainTransaction.address!.address!.toUpperCase(),
              'originPrivateKey': originPrivateKey,
              'keychain': keychain,
            },
          );
        }
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

  Future<void> removeService(
    NetworksSetting networkSettings,
    String service,
    Keychain keychain,
  ) async {
    final originPrivateKey = sl.get<ApiService>().getOriginKey();
    final servicesRemoved = Map<String, Service>.from(keychain.services)
      ..removeWhere((key, value) => key == service);
    final transaction = await KeychainTransactionBuilder.build(
      keychain: keychain.copyWith(services: servicesRemoved),
      originPrivateKey: originPrivateKey,
    );

    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
      websocketEndpoint: networkSettings.getWebsocketUri(),
      apiService: sl.get<ApiService>(),
    );

    await transactionSender.send(
      transaction: transaction,
      onConfirmation: (event) async {
        if (TransactionConfirmation.isEnoughConfirmations(
          event.nbConfirmations,
          event.maxConfirmations,
          TransactionValidationRatios.createKeychain,
        )) {
          transactionSender.close();
          onConfirmation(
            event,
            transactionSender,
            TransactionSendEventType.keychain,
            params: <String, Object>{
              'keychainAddress': transaction.address!.address!.toUpperCase(),
              'originPrivateKey': originPrivateKey,
              'keychain': keychain,
            },
          );
        }
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

  Future<HiveAppWalletDTO?> getListAccountsFromKeychain(
    Keychain keychain,
    HiveAppWalletDTO? appWallet, {
    bool loadBalance = true,
  }) async {
    final accounts = List<Account>.empty(growable: true);

    HiveAppWalletDTO currentAppWallet;
    try {
      /// Creation of a new appWallet
      if (appWallet == null) {
        final addressKeychain =
            deriveAddress(uint8ListToHex(keychain.seed!), 0);
        final lastTransactionMap =
            await sl.get<ApiService>().getLastTransaction([addressKeychain]);

        currentAppWallet = await appWalletDatasource.createAppWallet(
          lastTransactionMap[addressKeychain]!.address!.address!,
        );
      } else {
        currentAppWallet = appWallet;
      }

      final selectedAccount =
          await currentAppWallet.appKeychain.getAccountSelected();

      final genesisAddressAccountList = <String>[];
      final lastAddressAccountList = <String>[];

      await ContactsHiveDatasource.instance()
          .deleteContactByType(ContactType.keychainService.name);

      /// Get all services for archethic blockchain
      keychain.services.forEach((serviceName, service) async {
        final serviceType = getServiceTypeFromPath(service.derivationPath);

        final genesisAddress = keychain.deriveAddress(serviceName);
        final name = getNameFromPath(service.derivationPath);

        genesisAddressAccountList.add(
          uint8ListToHex(genesisAddress),
        );
        final account = Account(
          lastLoadingTransactionInputs: DateTime.now().millisecondsSinceEpoch ~/
              Duration.millisecondsPerSecond,
          lastAddress: uint8ListToHex(genesisAddress),
          genesisAddress: uint8ListToHex(genesisAddress),
          name: name,
          balance: AccountBalance(
            nativeTokenName: '',
            nativeTokenValue: 0,
          ),
          recentTransactions: [],
          serviceType: serviceType,
        );
        if (selectedAccount != null &&
            selectedAccount.name == name &&
            serviceType == 'archethicWallet') {
          account.selected = true;
        } else {
          account.selected = false;
        }

        // Get offchain infos if exists locally
        if (appWallet != null) {
          for (final element in appWallet.appKeychain.accounts) {
            if (element.name == account.name) {
              if (element.nftInfosOffChainList != null) {
                account.nftInfosOffChainList = element.nftInfosOffChainList;
              }
            }
          }
        }

        accounts.add(account);

        if (serviceType == 'archethicWallet') {
          final newContact = Contact(
            name: '@${Uri.encodeFull(account.nameDisplayed)}',
            address: uint8ListToHex(genesisAddress),
            genesisAddress: uint8ListToHex(genesisAddress),
            type: ContactType.keychainService.name,
            publicKey:
                uint8ListToHex(keychain.deriveKeypair(serviceName).publicKey!)
                    .toUpperCase(),
          );
          await ContactsHiveDatasource.instance().saveContact(newContact);
        }
      });

      final genesisAddressKeychain =
          deriveAddress(uint8ListToHex(keychain.seed!), 0);

      final lastTransactionKeychainMap =
          await sl.get<ApiService>().getLastTransaction(
        [genesisAddressKeychain, ...genesisAddressAccountList],
        request: 'address',
      );

      currentAppWallet.appKeychain.address =
          lastTransactionKeychainMap[genesisAddressKeychain]!.address!.address!;

      for (var i = 0; i < accounts.length; i++) {
        if (lastTransactionKeychainMap[accounts[i].genesisAddress] != null &&
            lastTransactionKeychainMap[accounts[i].genesisAddress]!.address !=
                null) {
          accounts[i].lastAddress =
              lastTransactionKeychainMap[accounts[i].genesisAddress]!
                  .address!
                  .address;
          lastAddressAccountList.add(
            lastTransactionKeychainMap[accounts[i].genesisAddress]!
                .address!
                .address!,
          );
        } else {
          lastAddressAccountList.add(
            accounts[i].genesisAddress,
          );
        }
      }

      if (loadBalance) {
        var balanceGetResponseMap = <String, Balance>{};
        if (loadBalance) {
          balanceGetResponseMap = await sl
              .get<AppService>()
              .getBalanceGetResponse(lastAddressAccountList);
        }

        for (var i = 0; i < accounts.length; i++) {
          if (balanceGetResponseMap[accounts[i].lastAddress] != null) {
            final balanceGetResponse =
                balanceGetResponseMap[accounts[i].lastAddress]!;
            final accountBalance = AccountBalance(
              nativeTokenName: AccountBalance.cryptoCurrencyLabel,
              nativeTokenValue: fromBigInt(balanceGetResponse.uco).toDouble(),
            );
            for (final token in balanceGetResponse.token) {
              if (token.tokenId != null) {
                if (token.tokenId == 0) {
                  accountBalance.tokensFungiblesNb++;
                } else {
                  accountBalance.nftNb++;
                }
              }
            }

            accounts[i].balance = accountBalance;
          }
        }
      }

      accounts.sort((a, b) => a.nameDisplayed.compareTo(b.nameDisplayed));
      currentAppWallet.appKeychain.accounts = accounts;

      await appWalletDatasource.saveAppWallet(currentAppWallet);
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

extension KeychainConversionsExt on Keychain {
  /// Convert Keychain model to KeychainSecuredInfos
  KeychainSecuredInfos toKeychainSecuredInfos() {
    final keychainSecuredInfosServiceMap =
        <String, KeychainSecuredInfosService>{};
    services.forEach((key, value) {
      final keyPair = deriveKeypair(key);

      keychainSecuredInfosServiceMap[key] = KeychainSecuredInfosService(
        curve: value.curve,
        derivationPath: value.derivationPath,
        hashAlgo: value.hashAlgo,
        name: key,
        keyPair: KeychainServiceKeyPair(
          privateKey: keyPair.privateKey!,
          publicKey: keyPair.publicKey!,
        ),
      );
    });

    return KeychainSecuredInfos(
      seed: seed!,
      version: version,
      services: keychainSecuredInfosServiceMap,
    );
  }
}

extension KeychainSecuredInfosConversionsExt on KeychainSecuredInfos {
  /// Convert KeychainSecuredInfos model to Keychain
  Keychain toKeychain() {
    final keychainServices = <String, Service>{};
    services.forEach((key, value) {
      keychainServices[key] = Service(
        curve: value.curve,
        derivationPath: value.derivationPath,
        hashAlgo: value.hashAlgo,
      );
    });

    return Keychain(
      seed: Uint8List.fromList(seed),
      services: keychainServices,
      version: version,
    );
  }
}
