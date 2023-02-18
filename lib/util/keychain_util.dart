/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
import 'package:aewallet/model/keychain_secured_infos.dart';
import 'package:aewallet/model/keychain_secured_infos_service.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/get_it_instance.dart';
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

    final keychain = Keychain(seed: hexToUint8List(keychainSeed), version: 1)
        .copyWithService(kServiceName, kDerivationPath);

    /// Create Keychain from keyChain seed and wallet public key to encrypt secret
    final keychainTransaction = sl.get<ApiService>().newKeychainTransaction(
          keychainSeed,
          <String>[uint8ListToHex(walletKeyPair.publicKey!)],
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
            'keychainAddress':
                keychainTransaction.address!.address!.toUpperCase(),
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
    final newKeychain = keychain.copyWithService(kServiceName, kDerivationPath);

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
            .setContent(jsonEncode(newKeychain.toDID()));

    final authorizedKeys = List<AuthorizedKey>.empty(growable: true);
    final authorizedKeysList =
        lastTransactionKeychainMap[genesisAddressKeychain]!
            .data!
            .ownerships[0]
            .authorizedPublicKeys;
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
      uint8ListToHex(
        aesEncrypt(newKeychain.encode(), aesKey),
      ),
      authorizedKeys,
    );

    keychainTransaction
        .build(
          uint8ListToHex(newKeychain.seed!),
          lastTransactionKeychainMap[genesisAddressKeychain]!.chainLength!,
        )
        .originSign(originPrivateKey);

    await sl.get<ApiService>().sendTx(keychainTransaction);

    final genesisAddress = newKeychain.deriveAddress(kServiceName);
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
        .address!
        .address!; // TODO(Chralu): Transaction.address should be non-nullable (3)

    await sl.get<DBHelper>().saveAppWallet(appWallet);

    final newContact = Contact(
      name: '@$name',
      address: uint8ListToHex(genesisAddress),
      type: ContactType.keychainService.name,
      publicKey:
          uint8ListToHex(newKeychain.deriveKeypair(kServiceName).publicKey!)
              .toUpperCase(),
    );
    await sl.get<DBHelper>().saveContact(newContact);

    return appWallet;
  }

  Future<HiveAppWalletDTO?> getListAccountsFromKeychain(
    Keychain keychain,
    HiveAppWalletDTO? appWallet,
    String currency,
    String tokenName, {
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

        currentAppWallet = await sl.get<DBHelper>().createAppWallet(
              lastTransactionMap[addressKeychain]!.address!.address!,
            );
      } else {
        currentAppWallet = appWallet;
      }

      final selectedAccount = currentAppWallet.appKeychain.getAccountSelected();

      const kDerivationPathWithoutService = "m/650'/archethic-wallet-";

      final genesisAddressAccountList = <String>[];
      final lastAddressAccountList = <String>[];

      /// Get all services for archethic blockchain
      keychain.services.forEach((serviceName, service) async {
        if (service.derivationPath.startsWith(kDerivationPathWithoutService)) {
          final genesisAddress = keychain.deriveAddress(serviceName);

          final path = service.derivationPath
              .replaceAll(kDerivationPathWithoutService, '')
              .split('/')
            ..last = '';
          var name = path.join('/');
          name = name.substring(0, name.length - 1);

          final nameDecoded = Uri.decodeFull(name);

          genesisAddressAccountList.add(
            uint8ListToHex(genesisAddress),
          );
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

          try {
            await sl.get<DBHelper>().getContactWithName(account.name);
          } catch (e) {
            final newContact = Contact(
              name: '@$nameDecoded',
              address: uint8ListToHex(genesisAddress),
              type: ContactType.keychainService.name,
              publicKey:
                  uint8ListToHex(keychain.deriveKeypair(serviceName).publicKey!)
                      .toUpperCase(),
            );
            await sl.get<DBHelper>().saveContact(newContact);
          }
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

mixin KeychainMixin {
  /// Convert Keychain model to KeychainSecuredInfos
  KeychainSecuredInfos keychainToKeychainSecuredInfos(
    Keychain keychain,
  ) {
    final keychainSecuredInfosServiceMap =
        <String, KeychainSecuredInfosService>{};
    keychain.services.forEach((key, value) {
      final keyPair = keychain.deriveKeypair(key);

      keychainSecuredInfosServiceMap[key] = KeychainSecuredInfosService(
        curve: value.curve,
        derivationPath: value.derivationPath,
        hashAlgo: value.hashAlgo,
        name: key.replaceAll('archethic-wallet-', ''),
        keyPair: KeychainServiceKeyPair(
          privateKey: keyPair.privateKey!,
          publicKey: keyPair.publicKey!,
        ),
      );
    });

    return KeychainSecuredInfos(
      seed: keychain.seed!,
      version: keychain.version,
      services: keychainSecuredInfosServiceMap,
    );
  }

  /// Convert KeychainSecuredInfos model to Keychain
  Keychain keychainSecuredInfosToKeychain(
    KeychainSecuredInfos keychainSecuredInfos,
  ) {
    final services = <String, Service>{};
    keychainSecuredInfos.services.forEach((key, value) {
      services[key] = Service(
        curve: value.curve,
        derivationPath: value.derivationPath,
        hashAlgo: value.hashAlgo,
      );
    });

    return Keychain(
      seed: Uint8List.fromList(keychainSecuredInfos.seed),
      services: services,
      version: keychainSecuredInfos.version,
    );
  }
}
