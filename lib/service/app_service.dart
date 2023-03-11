/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';

import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/model/keychain_secured_infos.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/model/transaction_infos.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:aewallet/util/queue.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppService {
  Future<Map<String, List<Transaction>>> getTransactionChain(
    Map<String, String> addresses,
    String? request,
  ) async {
    final transactionChainMap = await sl.get<ApiService>().getTransactionChain(
          addresses,
          request: request!,
        );
    return transactionChainMap;
  }

  Future<Map<String, Token>> getToken(
    List<String> addresses, {
    String request =
        'genesis, name, id, supply, symbol, type, properties, ownerships { authorizedPublicKeys { encryptedSecretKey,  publicKey }, secret }',
  }) async {
    final tokenMap = <String, Token>{};
    var antiSpam = 0;
    final futures = <Future>[];
    for (final address in addresses.toSet()) {
      // Delay the API call if we have made more than 15 requests
      if (antiSpam > 0 && antiSpam % 15 == 0) {
        await Future.delayed(const Duration(seconds: 1));
      }

      // Make the API call and update the antiSpam counter
      futures.add(
        sl.get<ApiService>().getToken(
          [address],
          request: request,
        ),
      );
      antiSpam++;
    }

    final getTokens = await Future.wait(futures);
    for (final getToken in getTokens) {
      tokenMap.addAll(getToken);
    }

    return tokenMap;
  }

  Future<Map<String, List<TransactionInput>>> getTransactionInputs(
    List<String> addresses,
    String request, {
    int limit = 0,
    int pagingOffset = 0,
  }) async {
    final transactionInputs = <String, List<TransactionInput>>{};
    var antiSpam = 0;
    final futures = <Future>[];
    for (final address in addresses.toSet()) {
      // Delay the API call if we have made more than 15 requests
      if (antiSpam > 0 && antiSpam % 15 == 0) {
        await Future.delayed(const Duration(seconds: 1));
      }

      // Make the API call and update the antiSpam counter
      futures.add(
        sl.get<ApiService>().getTransactionInputs(
          [address],
          request: request,
          limit: limit,
          pagingOffset: pagingOffset,
        ),
      );
      antiSpam++;
    }

    final getTransactionInputs = await Future.wait(futures);
    for (final getTransactionInput in getTransactionInputs) {
      transactionInputs.addAll(getTransactionInput);
    }

    return transactionInputs;
  }

  List<RecentTransaction> _removeRecentTransactionsDuplicates(
    List<RecentTransaction> recentTransactions,
  ) =>
      recentTransactions.fold<List<RecentTransaction>>(
        [],
        (keptRecentTransactions, element) {
          final matchingIndex = keptRecentTransactions.indexWhere(
            (keptRecentTransaction) =>
                keptRecentTransaction.typeTx == element.typeTx &&
                keptRecentTransaction.from == element.from &&
                keptRecentTransaction.type == element.type &&
                keptRecentTransaction.tokenAddress == element.tokenAddress &&
                keptRecentTransaction.tokenAddress == element.tokenAddress,
          );

          if (matchingIndex == -1) {
            return [
              ...keptRecentTransactions,
              element,
            ];
          }

          final matchingElement = keptRecentTransactions[matchingIndex];
          if (matchingElement.timestamp! > element.timestamp!) {
            return keptRecentTransactions;
          }

          return [
            for (var i = 0; i < keptRecentTransactions.length; i++)
              i == matchingIndex ? element : keptRecentTransactions[i]
          ];
        },
      );

  List<RecentTransaction> _populateRecentTransactionsFromTransactionInputs(
    List<TransactionInput> transactionInputs,
    String txAddress,
    int mostRecentTimestamp,
  ) {
    final recentTransactions = <RecentTransaction>[];
    for (final transactionInput in transactionInputs) {
      if (transactionInput.from!.toUpperCase() != txAddress.toUpperCase() &&
          transactionInput.timestamp! > mostRecentTimestamp) {
        final recentTransaction = RecentTransaction()
          ..address = transactionInput.from
          ..amount = fromBigInt(transactionInput.amount).toDouble()
          ..typeTx = RecentTransaction.transferInput
          ..from = transactionInput.from
          ..recipient = txAddress
          ..timestamp = transactionInput.timestamp
          ..fee = 0
          ..tokenAddress = transactionInput.tokenAddress;
        recentTransactions.add(recentTransaction);
      }
    }
    return recentTransactions;
  }

  List<RecentTransaction> _populateRecentTransactionsFromTransactionChain(
    List<Transaction> transactionChain,
  ) {
    final recentTransactions = <RecentTransaction>[];
    for (final transaction in transactionChain) {
      if (transaction.type! == 'token') {
        final recentTransaction = RecentTransaction()
          ..address = transaction.address!.address
          ..timestamp = transaction.validationStamp!.timestamp
          ..typeTx = RecentTransaction.tokenCreation
          ..fee = fromBigInt(transaction.validationStamp!.ledgerOperations!.fee)
              .toDouble()
          ..tokenAddress = transaction.address!.address;
        recentTransactions.add(recentTransaction);
      }

      if (transaction.type! == 'hosting') {
        final recentTransaction = RecentTransaction()
          ..address = transaction.address!.address
          ..timestamp = transaction.validationStamp!.timestamp
          ..typeTx = RecentTransaction.hosting
          ..fee = fromBigInt(transaction.validationStamp!.ledgerOperations!.fee)
              .toDouble()
          ..tokenAddress = transaction.address!.address;
        recentTransactions.add(recentTransaction);
      }

      if (transaction.type! == 'transfer') {
        for (final transfer in transaction.data!.ledger!.uco!.transfers) {
          final recentTransaction = RecentTransaction()
            ..address = transaction.address!.address
            ..typeTx = RecentTransaction.transferOutput
            ..amount = fromBigInt(
              transfer.amount,
            ).toDouble()
            ..recipient = transfer.to
            ..fee =
                fromBigInt(transaction.validationStamp!.ledgerOperations!.fee)
                    .toDouble()
            ..timestamp = transaction.validationStamp!.timestamp
            ..from = transaction.address!.address
            ..ownerships = transaction.data!.ownerships;
          recentTransactions.add(recentTransaction);
        }
        for (final transfer in transaction.data!.ledger!.token!.transfers) {
          final recentTransaction = RecentTransaction()
            ..address = transaction.address!.address
            ..typeTx = RecentTransaction.transferOutput
            ..amount = fromBigInt(
              transfer.amount,
            ).toDouble()
            ..recipient = transfer.to
            ..fee =
                fromBigInt(transaction.validationStamp!.ledgerOperations!.fee)
                    .toDouble()
            ..timestamp = transaction.validationStamp!.timestamp
            ..from = transaction.address!.address
            ..ownerships = transaction.data!.ownerships
            ..tokenAddress = transfer.tokenAddress;
          recentTransactions.add(recentTransaction);
        }
      }
    }
    return recentTransactions;
  }

  Future<List<RecentTransaction>> _buildRecentTransactionFromTransaction(
    List<RecentTransaction> recentTransactionList,
    String address,
    int mostRecentTimestamp,
  ) async {
    var newRecentTransactionList = recentTransactionList;

    final transaction = await sl.get<ApiService>().getTransaction(
      [address],
      request:
          'address, type, chainLength, validationStamp { timestamp, ledgerOperations { fee } }, data { ledger { uco { transfers { amount, to } } token {transfers {amount, to, tokenAddress, tokenId } } } }',
    );

    final transactionInputs = await sl.get<ApiService>().getTransactionInputs(
      [address],
      request: 'from, spent, tokenAddress, tokenId, amount, timestamp',
      limit: 10,
    );

    if (transaction[address] != null) {
      final transactionTimeStamp =
          transaction[address]!.validationStamp!.timestamp!;

      if (transactionInputs[address] != null) {
        newRecentTransactionList.addAll(
          _populateRecentTransactionsFromTransactionInputs(
            transactionInputs[address]!,
            address,
            mostRecentTimestamp,
          ),
        );
      }

      if (transactionTimeStamp > mostRecentTimestamp) {
        newRecentTransactionList.addAll(
          _populateRecentTransactionsFromTransactionChain(
            [transaction[address]!],
          ),
        );
      }
      // Remove doublons (on type / token address / from / timestamp)
      if (newRecentTransactionList.isNotEmpty) {
        newRecentTransactionList =
            _removeRecentTransactionsDuplicates(newRecentTransactionList);
      }
    }

    return newRecentTransactionList;
  }

  Future<List<RecentTransaction>> getAccountRecentTransactions(
    String genesisAddress,
    String lastAddress,
    String name,
    KeychainSecuredInfos keychainSecuredInfos,
    List<RecentTransaction> localRecentTransactionList,
  ) async {
    dev.log(
      '>> START getRecentTransactions : ${DateTime.now()}',
    );

    // get the most recent movement in cache
    var mostRecentTimestamp = 0;
    if (localRecentTransactionList.isNotEmpty) {
      localRecentTransactionList.sort(
        (a, b) => b.timestamp!.compareTo(a.timestamp!),
      );
      mostRecentTimestamp = localRecentTransactionList.first.timestamp ?? 0;
    }

    var recentTransactions = <RecentTransaction>[];

    final keychain = keychainSecuredInfos.toKeychain();
    final nameEncoded = Uri.encodeFull(
      name,
    );

    final lastIndex = await sl.get<ApiService>().getTransactionIndex(
      [lastAddress],
    );

    var index = lastIndex[lastAddress] ?? 0;
    String addressToSearch;
    var nbRecentTransactions = 0;
    recentTransactions.addAll(localRecentTransactionList);

    while (nbRecentTransactions < 10 && index > 0) {
      addressToSearch = uint8ListToHex(
        keychain.deriveAddress(
          'archethic-wallet-$nameEncoded',
          index: index,
        ),
      );

      recentTransactions = await _buildRecentTransactionFromTransaction(
        recentTransactions,
        addressToSearch,
        mostRecentTimestamp,
      );

      index--;
      nbRecentTransactions = recentTransactions.length;
    }

    if (nbRecentTransactions < 10) {
      // Get transaction inputs from genesis address if filtered list is < 10
      final genesisTransactionInputsMap = await getTransactionInputs(
        [genesisAddress],
        'from, type, spent, tokenAddress, amount, timestamp',
        limit: 10 - nbRecentTransactions,
      );

      if (genesisTransactionInputsMap[genesisAddress] != null) {
        recentTransactions.addAll(
          _populateRecentTransactionsFromTransactionInputs(
            genesisTransactionInputsMap[genesisAddress]!,
            genesisAddress,
            mostRecentTimestamp,
          ),
        );
      }
    }

    // Remove doublons (on type / token address / from / timestamp)
    if (recentTransactions.isNotEmpty) {
      recentTransactions =
          _removeRecentTransactionsDuplicates(recentTransactions);
    }

    // Sort by timestamp desc
    recentTransactions.sort(
      (a, b) => b.timestamp!.compareTo(a.timestamp!),
    );

    // Get 10 first transactions
    recentTransactions = recentTransactions.sublist(
      0,
      recentTransactions.length > 10 ? 10 : recentTransactions.length,
    );

    // Get token id
    final tokensAddresses = <String>[];
    for (final recentTransaction in recentTransactions) {
      if (recentTransaction.tokenAddress != null &&
          recentTransaction.tokenAddress!.isNotEmpty &&
          recentTransaction.timestamp! > mostRecentTimestamp) {
        tokensAddresses.add(recentTransaction.tokenAddress!);
      }
    }

    final recentTransactionLastAddresses = <String>[];
    final ownershipsAddresses = <String>[];

    // Search token informations
    final tokensAddressMap = await sl.get<AppService>().getToken(
          tokensAddresses.toSet().toList(),
          request: 'genesis, name, id, supply, symbol, type',
        );

    for (final recentTransaction in recentTransactions) {
      // Get token informations
      if (recentTransaction.tokenAddress != null &&
          recentTransaction.tokenAddress!.isNotEmpty &&
          recentTransaction.timestamp! > mostRecentTimestamp) {
        final token = tokensAddressMap[recentTransaction.tokenAddress];
        if (token != null) {
          recentTransaction.tokenInformations = TokenInformations(
            address: token.address,
            name: token.name,
            supply: fromBigInt(token.supply).toDouble(),
            symbol: token.symbol,
            type: token.type,
          );
        }
      }

      // Decrypt secrets
      switch (recentTransaction.typeTx) {
        case RecentTransaction.transferInput:
          if (recentTransaction.from != null) {
            if (recentTransaction.timestamp! > mostRecentTimestamp) {
              ownershipsAddresses.add(recentTransaction.from!);
            }
            recentTransactionLastAddresses.add(recentTransaction.from!);
          }
          break;
        case RecentTransaction.transferOutput:
          if (recentTransaction.recipient != null) {
            if (recentTransaction.timestamp! > mostRecentTimestamp) {
              ownershipsAddresses.add(recentTransaction.address!);
            }
            recentTransactionLastAddresses.add(recentTransaction.address!);
          }
          break;
      }
    }

    // Get List of ownerships
    final ownershipsMap = <String, List<Ownership>>{};
    var antiSpam = 0;
    var futures = <Future>[];
    for (final ownershipsAddress in ownershipsAddresses.toSet()) {
      // Delay the API call if we have made more than 15 requests
      if (antiSpam > 0 && antiSpam % 15 == 0) {
        await Future.delayed(const Duration(seconds: 1));
      }

      // Make the API call and update the antiSpam counter
      futures.add(
        sl.get<ApiService>().getTransactionOwnerships(
          [ownershipsAddress],
        ),
      );
      antiSpam++;
    }

    final getTransactionOwnerships = await Future.wait(futures);
    for (final getTransactionOwnership in getTransactionOwnerships) {
      ownershipsMap.addAll(getTransactionOwnership);
    }

    final keychainServiceKeyPair =
        keychainSecuredInfos.services['archethic-wallet-$nameEncoded']!.keyPair;
    for (var recentTransaction in recentTransactions) {
      switch (recentTransaction.typeTx) {
        case RecentTransaction.transferInput:
          if (recentTransaction.from != null &&
              recentTransaction.timestamp! > mostRecentTimestamp) {
            recentTransaction = _decryptedSecret(
              keypair: keychainServiceKeyPair!,
              ownerships: ownershipsMap[recentTransaction.from!] ?? [],
              recentTransaction: recentTransaction,
            );
          }
          break;
        case RecentTransaction.transferOutput:
          if (recentTransaction.address != null &&
              recentTransaction.timestamp! > mostRecentTimestamp) {
            recentTransaction = _decryptedSecret(
              keypair: keychainServiceKeyPair!,
              ownerships: ownershipsMap[recentTransaction.address!] ?? [],
              recentTransaction: recentTransaction,
            );
          }
          break;
      }
    }

    // Check if the recent transactions are with contacts
    final contactsList = await sl.get<DBHelper>().getContacts();
    final contactsListUpdated = <Contact>[];
    final contactsAddresses = <String>[];
    for (final contact in contactsList) {
      contactsAddresses.add(contact.address);
    }

    // Get last transactions for all tx and contacts
    final lastTransactionAddressesToSearch = [
      ...recentTransactionLastAddresses,
      ...contactsAddresses
    ];

    final lastAddressesMap = <String, Transaction>{};
    antiSpam = 0;
    futures = <Future>[];
    for (final lastTransactionAddressToSearch
        in lastTransactionAddressesToSearch.toSet()) {
      // Delay the API call if we have made more than 15 requests
      if (antiSpam > 0 && antiSpam % 15 == 0) {
        await Future.delayed(const Duration(seconds: 1));
      }

      // Make the API call and update the antiSpam counter
      futures.add(
        sl.get<ApiService>().getLastTransaction(
          [lastTransactionAddressToSearch],
          request: 'address',
        ),
      );
      antiSpam++;
    }

    final getLastTransactions = await Future.wait(futures);
    for (final getLastTransaction in getLastTransactions) {
      lastAddressesMap.addAll(getLastTransaction);
    }

    // We complete map with last address not found because no tx in the chain
    for (final lastTransactionAddressToSearch
        in lastTransactionAddressesToSearch) {
      if (lastAddressesMap[lastTransactionAddressToSearch] == null) {
        lastAddressesMap[lastTransactionAddressToSearch] = Transaction(
          type: '',
          data: Transaction.initData(),
          address:
              Address(address: lastTransactionAddressToSearch.toLowerCase()),
        );
      }
    }

    // Update contacts' last address
    for (final contact in contactsList) {
      if (lastAddressesMap[contact.address] != null &&
          lastAddressesMap[contact.address]!.address!.address!.toLowerCase() !=
              contact.address.toLowerCase()) {
        contact.address = lastAddressesMap[contact.address]!.address!.address ??
            contact.address;
        await sl.get<DBHelper>().saveContact(contact);
      }
      contactsListUpdated.add(contact);
    }

    recentTransactions = _updateContactInTx(
      contactsList: contactsListUpdated,
      lastAddressesMap: lastAddressesMap,
      recentTransactions: recentTransactions,
    );

    dev.log(
      '>> END getRecentTransactions : ${DateTime.now()}',
    );

    return recentTransactions;
  }

  List<RecentTransaction> _updateContactInTx({
    required List<RecentTransaction> recentTransactions,
    required Map<String, Transaction> lastAddressesMap,
    required List<Contact> contactsList,
  }) {
    for (final recentTransaction in recentTransactions) {
      switch (recentTransaction.typeTx) {
        case RecentTransaction.transferInput:
          if (recentTransaction.from != null) {
            if (lastAddressesMap[recentTransaction.from!] != null &&
                lastAddressesMap[recentTransaction.from!]!.address != null) {
              try {
                recentTransaction.contactInformations = contactsList
                    .where(
                      (contact) =>
                          lastAddressesMap[recentTransaction.from!]!
                              .address!
                              .address!
                              .toLowerCase() ==
                          contact.address.toLowerCase(),
                    )
                    .first;
              } catch (e) {
                recentTransaction.contactInformations = null;
              }
            } else {
              recentTransaction.contactInformations = null;
            }
          }
          break;
        case RecentTransaction.transferOutput:
          if (recentTransaction.recipient != null) {
            if (lastAddressesMap[recentTransaction.recipient!] != null &&
                lastAddressesMap[recentTransaction.recipient!]!.address !=
                    null) {
              try {
                recentTransaction.contactInformations = contactsList
                    .where(
                      (contact) =>
                          lastAddressesMap[recentTransaction.recipient!]!
                              .address!
                              .address!
                              .toLowerCase() ==
                          contact.address.toLowerCase(),
                    )
                    .first;
              } catch (e) {
                recentTransaction.contactInformations = null;
              }
            } else {
              recentTransaction.contactInformations = null;
            }
          }
          break;
      }
    }
    return recentTransactions;
  }

  RecentTransaction _decryptedSecret({
    required KeychainServiceKeyPair keypair,
    required List<Ownership> ownerships,
    required RecentTransaction recentTransaction,
  }) {
    recentTransaction.decryptedSecret = List<String>.empty(growable: true);
    if (ownerships.isEmpty) {
      return recentTransaction;
    }
    for (final ownership in ownerships) {
      final authorizedPublicKey = ownership.authorizedPublicKeys.firstWhere(
        (AuthorizedKey authKey) =>
            authKey.publicKey!.toUpperCase() ==
            uint8ListToHex(Uint8List.fromList(keypair.publicKey)).toUpperCase(),
        orElse: AuthorizedKey.new,
      );
      if (authorizedPublicKey.encryptedSecretKey != null) {
        final aesKey = ecDecrypt(
          authorizedPublicKey.encryptedSecretKey,
          Uint8List.fromList(keypair.privateKey),
        );
        final decryptedSecret = aesDecrypt(ownership.secret, aesKey);
        recentTransaction.decryptedSecret!.add(utf8.decode(decryptedSecret));
      }
    }
    return recentTransaction;
  }

  Future<List<AccountToken>> getFungiblesTokensList(String address) async {
    dev.log(
      '>> START getFungiblesTokensList : ${DateTime.now()}',
    );

    final balanceMap = await sl.get<ApiService>().fetchBalance([address]);
    final balance = balanceMap[address];
    final fungiblesTokensList = List<AccountToken>.empty(growable: true);

    final tokenAddressList = <String>[];
    if (balance == null) {
      return [];
    }

    for (final tokenBalance in balance.token) {
      if (tokenBalance.address != null) {
        tokenAddressList.add(tokenBalance.address!);
      }
    }

    // Search token informations
    final tokenMap = await sl.get<AppService>().getToken(
          tokenAddressList.toSet().toList(),
          request: 'genesis, name, id, supply, symbol, type',
        );

    for (final tokenBalance in balance.token) {
      final token = tokenMap[tokenBalance.address];
      if (token != null && token.type == 'fungible') {
        final tokenInformations = TokenInformations(
          address: tokenBalance.address,
          aeip: token.aeip,
          name: token.name,
          id: token.id,
          type: token.type,
          supply: fromBigInt(token.supply).toDouble(),
          symbol: token.symbol,
        );
        final accountFungibleToken = AccountToken(
          tokenInformations: tokenInformations,
          amount: fromBigInt(tokenBalance.amount).toDouble(),
        );
        fungiblesTokensList.add(accountFungibleToken);
      }
    }
    fungiblesTokensList.sort(
      (a, b) =>
          a.tokenInformations!.name!.compareTo(b.tokenInformations!.name!),
    );

    dev.log(
      '>> END getFungiblesTokensList : ${DateTime.now()}',
    );

    return fungiblesTokensList;
  }

  Future<List<AccountToken>> getNFTList(
    String address,
    String name,
    KeychainSecuredInfos keychainSecuredInfos,
  ) async {
    final balanceMap = await sl.get<ApiService>().fetchBalance([address]);
    final balance = balanceMap[address];
    final nftList = List<AccountToken>.empty(growable: true);
    final nameEncoded = Uri.encodeFull(
      name,
    );

    final tokenAddressList = <String>[];
    if (balance == null) {
      return [];
    }

    for (final tokenBalance in balance.token) {
      if (tokenBalance.address != null) {
        tokenAddressList.add(tokenBalance.address!);
      }
    }

    final tokenMap = await sl.get<ApiService>().getToken(
          tokenAddressList.toSet().toList(),
        );

    // TODO(reddwarf03): temporaly section -> need https://github.com/archethic-foundation/archethic-node/issues/714

    final secretMap = await sl.get<ApiService>().getTransaction(
          tokenAddressList.toSet().toList(),
          request:
              'data { ownerships { authorizedPublicKeys { encryptedSecretKey, publicKey } secret }  }',
        );

    for (final tokenBalance in balance.token) {
      final token = tokenMap[tokenBalance.address];
      if (token != null && token.type == 'non-fungible') {
        final tokenWithoutFile = {...token.properties}
          ..removeWhere((key, value) => key == 'content');

        if (secretMap[tokenBalance.address] != null &&
            secretMap[tokenBalance.address]!.data != null &&
            secretMap[tokenBalance.address]!.data!.ownerships.isNotEmpty) {
          tokenWithoutFile.addAll(
            _tokenPropertiesDecryptedSecret(
              keypair: keychainSecuredInfos
                  .services['archethic-wallet-$nameEncoded']!.keyPair!,
              ownerships: secretMap[tokenBalance.address]!.data!.ownerships,
            ),
          );
        }

        final tokenInformations = TokenInformations(
          address: tokenBalance.address,
          name: token.name,
          id: token.id,
          aeip: token.aeip,
          type: token.type,
          supply: fromBigInt(token.supply).toDouble(),
          symbol: token.symbol,
          tokenProperties: tokenWithoutFile,
        );
        final accountNFT = AccountToken(
          tokenInformations: tokenInformations,
          amount: fromBigInt(tokenBalance.amount).toDouble(),
        );
        nftList.add(accountNFT);
      }
    }
    nftList.sort(
      (a, b) =>
          a.tokenInformations!.name!.compareTo(b.tokenInformations!.name!),
    );

    return nftList;
  }

  Map<String, dynamic> _tokenPropertiesDecryptedSecret({
    required KeychainServiceKeyPair keypair,
    required List<Ownership> ownerships,
  }) {
    final propertiesDecrypted = <String, dynamic>{};
    for (final ownership in ownerships) {
      final authorizedPublicKey = ownership.authorizedPublicKeys.firstWhere(
        (AuthorizedKey authKey) =>
            authKey.publicKey!.toUpperCase() ==
            uint8ListToHex(Uint8List.fromList(keypair.publicKey)).toUpperCase(),
        orElse: AuthorizedKey.new,
      );
      if (authorizedPublicKey.encryptedSecretKey != null) {
        final aesKey = ecDecrypt(
          authorizedPublicKey.encryptedSecretKey,
          Uint8List.fromList(keypair.privateKey),
        );
        final decryptedSecret = aesDecrypt(ownership.secret, aesKey);
        try {
          propertiesDecrypted.addAll(json.decode(utf8.decode(decryptedSecret)));
        } catch (e) {
          dev.log('Decryption error $e');
        }
      }
    }
    return propertiesDecrypted;
  }

  Future<Map<String, Balance>> getBalanceGetResponse(
    List<String> addresses,
  ) async {
    final tasks = addresses.toSet().map(
          (address) => () => sl.get<ApiService>().fetchBalance(
                [address],
              ),
        );

    // Search token informations
    final balanceMap = await OperationQueue.run<Balance>(tasks);

    final balancesToReturn = <String, Balance>{};
    for (final address in addresses) {
      var balance = balanceMap[address] ??
          Balance(uco: 0, token: List<TokenBalance>.empty(growable: true));
      final balanceTokenList = List<TokenBalance>.empty(growable: true);

      for (var i = 0; i < balance.token.length; i++) {
        var balanceToken = const TokenBalance();
        balanceToken = balance.token[i];
        balanceTokenList.add(balanceToken);
      }
      balance = balance.copyWith(token: balanceTokenList);

      balancesToReturn[address] = balance;
    }
    return balancesToReturn;
  }

  Future<Map<String, Transaction>> getTransaction(
    List<String> addresses, {
    String request = Transaction.kTransactionQueryAllFields,
  }) async {
    final transactionMap = await sl.get<ApiService>().getTransaction(
          addresses.toSet().toList(),
          request: request,
        );
    return transactionMap;
  }

  Future<List<TransactionInfos>> getTransactionAllInfos(
    String address,
    DateFormat dateFormat,
    String cryptoCurrency,
    BuildContext context,
    KeychainServiceKeyPair keychainServiceKeyPair,
  ) async {
    final transactionsInfos = List<TransactionInfos>.empty(growable: true);

    final transactionMap = await sl.get<ApiService>().getTransaction(
      [address],
      request:
          ' address, data { content,  ownerships {  authorizedPublicKeys { encryptedSecretKey, publicKey } secret } ledger { uco { transfers { amount, to } }, token { transfers { amount, to, tokenAddress, tokenId } } } recipients }, type ',
    );
    final transaction = transactionMap[address];
    if (transaction == null) {
      return [];
    }
    if (transaction.address != null) {
      transactionsInfos.add(
        TransactionInfos(
          domain: '',
          titleInfo: 'Address',
          valueInfo: transaction.address!.address!,
        ),
      );
    }
    if (transaction.type != null) {
      transactionsInfos.add(
        TransactionInfos(
          domain: '',
          titleInfo: 'Type',
          valueInfo: transaction.type!,
        ),
      );
    }
    if (transaction.data != null) {
      transactionsInfos
          .add(TransactionInfos(domain: 'Data', titleInfo: '', valueInfo: ''));

      if (transaction.data!.content != null) {
        transactionsInfos.add(
          TransactionInfos(
            domain: 'Data',
            titleInfo: 'Content',
            valueInfo:
                transaction.type == 'token' || transaction.type == 'hosting'
                    ? 'See explorer...'
                    : transaction.data!.content == ''
                        ? 'N/A'
                        : transaction.data!.content!,
          ),
        );
      }

      if (transaction.data!.code != null) {
        transactionsInfos.add(
          TransactionInfos(
            domain: 'Data',
            titleInfo: 'Code',
            valueInfo: transaction.data!.code!,
          ),
        );
      }
      if (transaction.data!.ownerships.isNotEmpty) {
        for (final ownership in transaction.data!.ownerships) {
          final authorizedPublicKey = ownership.authorizedPublicKeys.firstWhere(
            (AuthorizedKey authKey) =>
                authKey.publicKey!.toUpperCase() ==
                uint8ListToHex(
                  Uint8List.fromList(keychainServiceKeyPair.publicKey),
                ).toUpperCase(),
            orElse: AuthorizedKey.new,
          );
          if (authorizedPublicKey.encryptedSecretKey != null) {
            final aesKey = ecDecrypt(
              authorizedPublicKey.encryptedSecretKey,
              Uint8List.fromList(keychainServiceKeyPair.privateKey),
            );
            final decryptedSecret = aesDecrypt(ownership.secret, aesKey);
            transactionsInfos.add(
              TransactionInfos(
                domain: 'Data',
                titleInfo: 'Secret',
                valueInfo: utf8.decode(decryptedSecret),
              ),
            );
          }
        }
      }
      if (transaction.data!.ledger != null &&
          transaction.data!.ledger!.uco != null &&
          transaction.data!.ledger!.uco!.transfers.isNotEmpty) {
        transactionsInfos.add(
          TransactionInfos(
            domain: 'UCOLedger',
            titleInfo: '',
            valueInfo: '',
          ),
        );
        for (var i = 0;
            i < transaction.data!.ledger!.uco!.transfers.length;
            i++) {
          if (transaction.data!.ledger!.uco!.transfers[i].to != null) {
            var recipientContactName = '';

            final contact = await sl.get<DBHelper>().getContactWithAddress(
                  transaction.data!.ledger!.uco!.transfers[i].to!,
                );
            if (contact != null && contact.name.length > 1) {
              recipientContactName = contact.name.substring(1);
            }

            if (recipientContactName.isEmpty) {
              transactionsInfos.add(
                TransactionInfos(
                  domain: 'UCOLedger',
                  titleInfo: 'To',
                  valueInfo: transaction.data!.ledger!.uco!.transfers[i].to!,
                ),
              );
            } else {
              transactionsInfos.add(
                TransactionInfos(
                  domain: 'UCOLedger',
                  titleInfo: 'To',
                  valueInfo:
                      '$recipientContactName\n${transaction.data!.ledger!.uco!.transfers[i].to!}',
                ),
              );
            }
          }
          if (transaction.data!.ledger!.uco!.transfers[i].amount != null) {
            transactionsInfos.add(
              TransactionInfos(
                domain: 'UCOLedger',
                titleInfo: 'Amount',
                valueInfo:
                    '${NumberUtil.formatThousands(fromBigInt(transaction.data!.ledger!.uco!.transfers[i].amount))} $cryptoCurrency',
              ),
            );
          }
        }
      }
      if (transaction.data!.ledger != null &&
          transaction.data!.ledger!.token != null &&
          transaction.data!.ledger!.token!.transfers.isNotEmpty) {
        transactionsInfos.add(
          TransactionInfos(
            domain: 'TokenLedger',
            titleInfo: '',
            valueInfo: '',
          ),
        );
        for (var i = 0;
            i < transaction.data!.ledger!.token!.transfers.length;
            i++) {
          if (transaction.data!.ledger!.token!.transfers[i].tokenAddress !=
              null) {
            transactionsInfos.add(
              TransactionInfos(
                domain: 'TokenLedger',
                titleInfo: 'Token',
                valueInfo:
                    transaction.data!.ledger!.token!.transfers[i].tokenAddress!,
              ),
            );
          }
          if (transaction.data!.ledger!.token!.transfers[i].to != null) {
            transactionsInfos.add(
              TransactionInfos(
                domain: 'TokenLedger',
                titleInfo: 'To',
                valueInfo: transaction.data!.ledger!.token!.transfers[i].to!,
              ),
            );
          }
          if (transaction.data!.ledger!.token!.transfers[i].amount != null) {
            final tokenMap = await sl.get<ApiService>().getToken(
              [transaction.data!.ledger!.token!.transfers[i].tokenAddress!],
              request: 'symbol',
            );
            var tokenSymbol = '';
            if (tokenMap[transaction
                    .data!.ledger!.token!.transfers[i].tokenAddress!] !=
                null) {
              tokenSymbol = tokenMap[transaction
                          .data!.ledger!.token!.transfers[i].tokenAddress!]!
                      .symbol ??
                  '';
            }
            transactionsInfos.add(
              TransactionInfos(
                domain: 'TokenLedger',
                titleInfo: 'Amount',
                valueInfo:
                    '${NumberUtil.formatThousands(fromBigInt(transaction.data!.ledger!.token!.transfers[i].amount))} $tokenSymbol',
              ),
            );
          }
        }
      }
    }
    return transactionsInfos;
  }

  Future<double> getFeesEstimation(
    String originPrivateKey,
    String seed,
    String address,
    List<UCOTransfer> listUcoTransfer,
    List<TokenTransfer> listTokenTransfer,
    String message,
    KeychainServiceKeyPair keychainServiceKeyPair,
  ) async {
    final lastTransactionMap = await sl
        .get<ApiService>()
        .getLastTransaction([address], request: 'chainLength');
    final transaction =
        Transaction(type: 'transfer', data: Transaction.initData());
    for (final transfer in listUcoTransfer) {
      transaction.addUCOTransfer(transfer.to!, transfer.amount!);
    }
    for (final transfer in listTokenTransfer) {
      transaction.addTokenTransfer(
        transfer.to!,
        transfer.amount!,
        transfer.tokenAddress!,
        tokenId: transfer.tokenId == null ? 0 : transfer.tokenId!,
      );
    }
    if (message.isNotEmpty) {
      final aesKey = uint8ListToHex(
        Uint8List.fromList(
          List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
        ),
      );

      final authorizedPublicKeys = List<String>.empty(growable: true)
        ..add(
          uint8ListToHex(
            Uint8List.fromList(keychainServiceKeyPair.publicKey),
          ).toUpperCase(),
        );

      for (final transfer in listUcoTransfer) {
        final firstTxListRecipientMap =
            await sl.get<ApiService>().getTransactionChain(
          {transfer.to!: ''},
          request: 'previousPublicKey',
        );
        if (firstTxListRecipientMap.isNotEmpty) {
          final firstTxListRecipient = firstTxListRecipientMap[transfer.to!];
          if (firstTxListRecipient != null && firstTxListRecipient.isNotEmpty) {
            authorizedPublicKeys
                .add(firstTxListRecipient.first.previousPublicKey!);
          }
        }
      }

      for (final transfer in listTokenTransfer) {
        final firstTxListRecipientMap =
            await sl.get<ApiService>().getTransactionChain(
          {transfer.to!: ''},
          request: 'previousPublicKey',
        );
        if (firstTxListRecipientMap.isNotEmpty) {
          final firstTxListRecipient = firstTxListRecipientMap[transfer.to!];
          if (firstTxListRecipient != null && firstTxListRecipient.isNotEmpty) {
            authorizedPublicKeys
                .add(firstTxListRecipient.first.previousPublicKey!);
          }
        }
      }

      final authorizedKeys = List<AuthorizedKey>.empty(growable: true);
      for (final key in authorizedPublicKeys) {
        authorizedKeys.add(
          AuthorizedKey(
            encryptedSecretKey: uint8ListToHex(ecEncrypt(aesKey, key)),
            publicKey: key,
          ),
        );
      }

      transaction.addOwnership(
        uint8ListToHex(aesEncrypt(message, aesKey)),
        authorizedKeys,
      );
    }

    var transactionFee = const TransactionFee();
    final lastTransaction = lastTransactionMap[address];
    transaction
        .build(seed, lastTransaction!.chainLength ?? 0)
        .originSign(originPrivateKey);
    try {
      transactionFee =
          await sl.get<ApiService>().getTransactionFee(transaction);
    } catch (e, stack) {
      dev.log('Failed to get transaction fees', error: e, stackTrace: stack);
    }
    return fromBigInt(transactionFee.fee).toDouble();
  }

  Future<TokenInformations?> getNFT(
    String address,
    KeychainServiceKeyPair keychainServiceKeyPair,
  ) async {
    final tokenMap = await sl.get<AppService>().getToken(
      [address],
    );

    if (tokenMap.isEmpty ||
        tokenMap[address] == null ||
        tokenMap[address]!.type != 'non-fungible') {
      return null;
    }

    // TODO(reddwarf03): temporaly section -> need https://github.com/archethic-foundation/archethic-node/issues/714
    final secretMap = await sl.get<ApiService>().getTransaction(
      [address],
      request:
          'data { ownerships { authorizedPublicKeys { encryptedSecretKey, publicKey } secret }  }',
    );

    final token = tokenMap[address]!;

    final tokenWithoutFile = {...token.properties}
      ..removeWhere((key, value) => key == 'content');

    if (secretMap[address] != null &&
        secretMap[address]!.data != null &&
        secretMap[address]!.data!.ownerships.isNotEmpty) {
      tokenWithoutFile.addAll(
        _tokenPropertiesDecryptedSecret(
          keypair: keychainServiceKeyPair,
          ownerships: secretMap[address]!.data!.ownerships,
        ),
      );
    }
    final tokenInformations = TokenInformations(
      address: address,
      name: token.name,
      id: token.id,
      type: token.type,
      supply: fromBigInt(token.supply).toDouble(),
      symbol: token.symbol,
      tokenProperties: tokenWithoutFile,
    );
    return tokenInformations;
  }
}
