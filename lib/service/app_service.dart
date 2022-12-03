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
import 'package:aewallet/model/transaction_infos.dart';
import 'package:aewallet/model/transaction_input_with_tx_address.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/number_util.dart';
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

  Future<Map<String, List<TransactionInput>>> getTransactionInputs(
    List<String> addresses,
    String request, {
    int limit = 0,
    int pagingOffset = 0,
  }) async {
    final transactionInputs = await sl.get<ApiService>().getTransactionInputs(
          addresses.toSet().toList(),
          request: request,
          limit: limit,
          pagingOffset: pagingOffset,
        );
    return transactionInputs;
  }

  List<TransactionInputWithTxAddress> _removeDuplicates(
    List<TransactionInputWithTxAddress> transactionInputs,
  ) =>
      transactionInputs.fold<List<TransactionInputWithTxAddress>>(
        [],
        (keptTransactionInputs, element) {
          final matchingIndex = keptTransactionInputs.indexWhere(
            (keptTransactionInput) =>
                keptTransactionInput.from == element.from &&
                keptTransactionInput.tokenAddress == element.tokenAddress,
          );

          if (matchingIndex == -1) {
            return [
              ...keptTransactionInputs,
              element,
            ];
          }

          final matchingElement = keptTransactionInputs[matchingIndex];
          if (matchingElement.timestamp > element.timestamp) {
            return keptTransactionInputs;
          }

          return [
            for (var i = 0; i < keptTransactionInputs.length; i++)
              i == matchingIndex ? element : keptTransactionInputs[i]
          ];
        },
      );

  Future<List<RecentTransaction>> getAccountRecentTransactions(
    String lastAddress,
    String seed,
    String name,
    List<RecentTransaction> localRecentTransactionList,
  ) async {
    dev.log(
      '>> START getRecentTransactions : ${DateTime.now().toString()}',
    );

    final lastAddressRecentTransaction = {lastAddress: ''};
    var transactionInputsMap = <String, List<TransactionInput>>{};

    // Get from local transactions, the last address to search only new tx
    final localRecentTransactionLastAddress = localRecentTransactionList
        .firstWhere(
          (element) => element.typeTx != RecentTransaction.transferInput,
          orElse: RecentTransaction.new,
        )
        .address;

    // Load not in cached Tx inputs from genesis address
    if (localRecentTransactionList.isNotEmpty &&
        localRecentTransactionList.first.address != null &&
        localRecentTransactionLastAddress != null &&
        localRecentTransactionLastAddress.isNotEmpty) {
      lastAddressRecentTransaction[lastAddress] =
          localRecentTransactionLastAddress;
    }

    var transactionChainMap = {};
    if (localRecentTransactionLastAddress != lastAddress) {
      transactionChainMap = await getTransactionChain(
        lastAddressRecentTransaction,
        'address, type, validationStamp { timestamp, ledgerOperations { fee } }, data { ownerships { secret, authorizedPublicKeys { encryptedSecretKey, publicKey } } , ledger { uco { transfers { amount, to } } token {transfers {amount, to, tokenAddress, tokenId } } } }, inputs { from, type, spent, tokenAddress, tokenId, amount, timestamp }',
      );
    }

    transactionInputsMap = await getTransactionInputs(
      [lastAddress],
      'from, type, spent, tokenAddress, amount, timestamp',
      limit: 10,
    );

    if (localRecentTransactionList.isNotEmpty &&
        localRecentTransactionList.first.timestamp != null) {
      transactionInputsMap[lastAddress]!.removeWhere(
        (element) =>
            element.timestamp! <= localRecentTransactionList.first.timestamp!,
      );
      transactionInputsMap[lastAddress]!.removeWhere(
        (element) => element.from! == lastAddress,
      );
    }

    final recentTransactions = List<RecentTransaction>.empty(growable: true);

    final transactionChain = transactionChainMap[lastAddress] ?? [];
    final transactionInputs = transactionInputsMap[lastAddress] ?? [];

    final tokensAddresses = <String>[];

    // Delete transaction inputs from own account
    // Transaction inputs filtering
    final listTransactionInputsToFilter = <TransactionInputWithTxAddress>[];
    for (final transaction in transactionChain) {
      if (transaction.inputs != null) {
        for (final transactionInput in transaction.inputs!) {
          final transactionInputWithTxAddress = TransactionInputWithTxAddress(
            amount: transactionInput.amount ?? 0,
            from: transactionInput.from ?? '',
            spent: transactionInput.spent ?? false,
            timestamp: transactionInput.timestamp ?? 0,
            tokenAddress: transactionInput.tokenAddress,
            tokenId: transactionInput.tokenId,
            txAddress: transaction.address!,
            type: transactionInput.type,
          );
          listTransactionInputsToFilter.add(transactionInputWithTxAddress);
        }
      }
    }

    for (final transaction in transactionChain) {
      listTransactionInputsToFilter
          .removeWhere((element) => element.from == transaction.address);
    }

    if (listTransactionInputsToFilter.isNotEmpty) {
      final listTransactionInputsFiltered =
          _removeDuplicates(listTransactionInputsToFilter)
            ..sort(
              (a, b) => b.timestamp.compareTo(a.timestamp),
            );

      for (final transactionInput in listTransactionInputsFiltered) {
        final recentTransaction = RecentTransaction()
          ..address = transactionInput.from
          ..amount = fromBigInt(transactionInput.amount).toDouble()
          ..typeTx = RecentTransaction.transferInput
          ..from = transactionInput.from
          ..recipient = transactionInput.txAddress
          ..timestamp = transactionInput.timestamp
          ..fee = 0;

        if (transactionInput.tokenAddress != null) {
          tokensAddresses.add(transactionInput.tokenAddress!);
          recentTransaction.tokenAddress = transactionInput.tokenAddress;
        }
        recentTransactions.add(recentTransaction);
      }
    }

    for (final transaction in transactionChain) {
      if (transaction.type! == 'token') {
        final recentTransaction = RecentTransaction()
          ..address = transaction.address
          ..timestamp = transaction.validationStamp!.timestamp
          ..typeTx = RecentTransaction.tokenCreation
          ..fee = fromBigInt(transaction.validationStamp!.ledgerOperations!.fee)
              .toDouble();
        if (transaction.address != null) {
          tokensAddresses.add(transaction.address!);
          recentTransaction.tokenAddress = transaction.address;
        }
        recentTransactions.add(recentTransaction);
      }

      if (transaction.type! == 'transfer') {
        for (final transfer in transaction.data!.ledger!.uco!.transfers!) {
          final recentTransaction = RecentTransaction()
            ..address = transaction.address
            ..typeTx = RecentTransaction.transferOutput
            ..amount = fromBigInt(
              transfer.amount,
            ).toDouble()
            ..recipient = transfer.to
            ..fee =
                fromBigInt(transaction.validationStamp!.ledgerOperations!.fee)
                    .toDouble()
            ..timestamp = transaction.validationStamp!.timestamp
            ..from = lastAddress
            ..ownerships = transaction.data!.ownerships;
          recentTransactions.add(recentTransaction);
        }
        for (final transfer in transaction.data!.ledger!.token!.transfers!) {
          final recentTransaction = RecentTransaction()
            ..address = transaction.address
            ..typeTx = RecentTransaction.transferOutput
            ..amount = fromBigInt(
              transfer.amount,
            ).toDouble()
            ..recipient = transfer.to
            ..fee =
                fromBigInt(transaction.validationStamp!.ledgerOperations!.fee)
                    .toDouble()
            ..timestamp = transaction.validationStamp!.timestamp
            ..from = lastAddress
            ..ownerships = transaction.data!.ownerships;

          if (transfer.tokenAddress != null) {
            tokensAddresses.add(transfer.tokenAddress!);
            recentTransaction.tokenAddress = transfer.tokenAddress;
          }
          recentTransactions.add(recentTransaction);
        }
      }
    }

    // Transaction inputs
    for (final transactionInput in transactionInputs) {
      final recentTransaction = RecentTransaction()
        ..address = transactionInput.from
        ..amount = fromBigInt(transactionInput.amount).toDouble()
        ..typeTx = RecentTransaction.transferInput
        ..from = transactionInput.from
        ..recipient = lastAddress
        ..timestamp = transactionInput.timestamp
        ..fee = 0;
      if (transactionInput.tokenAddress != null) {
        tokensAddresses.add(transactionInput.tokenAddress!);
        recentTransaction.tokenAddress = transactionInput.tokenAddress;
      }
      recentTransactions.add(recentTransaction);
    }

    // Get token informations
    final tokensAddressMap = await sl.get<ApiService>().getToken(
          tokensAddresses.toSet().toList(),
          request: 'genesis, name, id, supply, symbol, type',
        );
    for (final recentTransaction in recentTransactions) {
      if (recentTransaction.tokenAddress != null &&
          recentTransaction.tokenAddress!.isNotEmpty) {
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
    }

    // Decrypt secrets
    final recentTransactionLastAddresses = <String>[];
    final ownershipsAddresses = <String>[];
    for (final recentTransaction in recentTransactions) {
      switch (recentTransaction.typeTx) {
        case RecentTransaction.transferInput:
          if (recentTransaction.from != null) {
            recentTransactionLastAddresses.add(recentTransaction.from!);
            ownershipsAddresses.add(recentTransaction.from!);
          }
          break;
        case RecentTransaction.transferOutput:
          if (recentTransaction.recipient != null) {
            recentTransactionLastAddresses.add(recentTransaction.recipient!);
            ownershipsAddresses.add(recentTransaction.recipient!);
          }
          break;
      }
    }
    var ownershipsMap = <String, List<Ownership>>{};
    if (ownershipsAddresses.isNotEmpty) {
      ownershipsMap = await sl
          .get<ApiService>()
          .getTransactionOwnerships(ownershipsAddresses.toSet().toList());
    }

    final nameEncoded = Uri.encodeFull(name);
    final serviceName = 'archethic-wallet-$nameEncoded';
    late Keychain keychain;
    late KeyPair keypair;
    var getKeypair = false;

    for (var recentTransaction in recentTransactions) {
      if (recentTransaction.typeTx == RecentTransaction.transferInput &&
          recentTransaction.address != null) {
        if (getKeypair == false) {
          keychain = await sl.get<ApiService>().getKeychain(seed);
          keypair = keychain.deriveKeypair(serviceName);
          getKeypair = true;
        }

        recentTransaction = _decryptedSecret(
          keypair: keypair,
          ownerships: ownershipsMap[recentTransaction.address!] ?? [],
          recentTransaction: recentTransaction,
        );
      } else {
        if (getKeypair == false) {
          keychain = await sl.get<ApiService>().getKeychain(seed);
          keypair = keychain.deriveKeypair(serviceName);
          getKeypair = true;
        }
        recentTransaction = _decryptedSecret(
          keypair: keypair,
          ownerships: recentTransaction.ownerships ?? [],
          recentTransaction: recentTransaction,
        );
      }
    }

    // Check if the recent transactions are with contacts
    final contactsList = await sl.get<DBHelper>().getContacts();
    final contactsListUpdated = <Contact>[];
    final contactsAddresses = <String>[];
    for (final contact in contactsList) {
      contactsAddresses.add(contact.address);
    }

    // Remove doublons between 2 lists
    final lastTransactionAddressesToSearch = [
      ...recentTransactionLastAddresses,
      ...contactsAddresses
    ];
    final lastAddressesMap = await sl.get<ApiService>().getLastTransaction(
          lastTransactionAddressesToSearch.toSet().toList(),
          request: 'address',
        );

    // Update map with genesis address
    for (final recentTransactionLastAddress in recentTransactionLastAddresses) {
      if (lastAddressesMap[recentTransactionLastAddress] == null) {
        lastAddressesMap[recentTransactionLastAddress] = Transaction(
          type: 'transfer',
          data: Transaction.initData(),
          address: recentTransactionLastAddress,
        );
      }
    }

    // Update contact's last address
    for (final contact in contactsList) {
      if (lastAddressesMap[contact.address] != null &&
          lastAddressesMap[contact.address]!.address != contact.address) {
        contact.address =
            lastAddressesMap[contact.address]!.address ?? contact.address;
        await sl.get<DBHelper>().saveContact(contact);
      }
      contactsListUpdated.add(contact);
    }

    for (final contact in contactsList) {
      String contactAddress;
      if (lastAddressesMap[contact.address] != null &&
          lastAddressesMap[contact.address]!.address != null) {
        contactAddress = lastAddressesMap[contact.address]!.address!;
      } else {
        contactAddress = contact.address;
      }
      for (final recentTransaction in recentTransactions) {
        switch (recentTransaction.typeTx) {
          case RecentTransaction.transferInput:
            if (recentTransaction.from != null) {
              if (lastAddressesMap[recentTransaction.from!]!
                      .address!
                      .toLowerCase() ==
                  contactAddress.toLowerCase()) {
                recentTransaction.contactInformations =
                    contactsListUpdated.firstWhere(
                  (contact) =>
                      contact.address.toLowerCase() ==
                      contactAddress.toLowerCase(),
                );
              }
            }
            break;
          case RecentTransaction.transferOutput:
            if (recentTransaction.recipient != null) {
              if (lastAddressesMap[recentTransaction.recipient!]!
                      .address!
                      .toLowerCase() ==
                  contactAddress.toLowerCase()) {
                recentTransaction.contactInformations =
                    contactsListUpdated.firstWhere(
                  (contact) =>
                      contact.address.toLowerCase() ==
                      contactAddress.toLowerCase(),
                );
              }
            }
            break;
        }
      }
    }

    recentTransactions
      ..addAll(localRecentTransactionList)

      // Sort by date (desc)
      ..sort(
        (RecentTransaction a, RecentTransaction b) =>
            a.timestamp!.compareTo(b.timestamp!),
      );

    dev.log(
      '>> END getRecentTransactions : ${DateTime.now().toString()}',
    );

    return recentTransactions.reversed.toList().sublist(
          0,
          recentTransactions.length > 10 ? 10 : recentTransactions.length,
        );
  }

  RecentTransaction _decryptedSecret({
    required KeyPair keypair,
    required List<Ownership> ownerships,
    required RecentTransaction recentTransaction,
  }) {
    recentTransaction.decryptedSecret = List<String>.empty(growable: true);
    if (ownerships.isEmpty) {
      return recentTransaction;
    }
    for (final ownership in ownerships) {
      final authorizedPublicKey = ownership.authorizedPublicKeys!.firstWhere(
        (AuthorizedKey authKey) =>
            authKey.publicKey!.toUpperCase() ==
            uint8ListToHex(keypair.publicKey).toUpperCase(),
        orElse: AuthorizedKey.new,
      );
      if (authorizedPublicKey.encryptedSecretKey != null) {
        final aesKey = ecDecrypt(
          authorizedPublicKey.encryptedSecretKey,
          keypair.privateKey,
        );
        final decryptedSecret = aesDecrypt(ownership.secret, aesKey);
        recentTransaction.decryptedSecret!.add(utf8.decode(decryptedSecret));
      }
    }
    return recentTransaction;
  }

  Future<List<AccountToken>> getFungiblesTokensList(String address) async {
    final balanceMap = await sl.get<ApiService>().fetchBalance([address]);
    final balance = balanceMap[address];
    final fungiblesTokensList = List<AccountToken>.empty(growable: true);

    final tokenAddressList = <String>[];
    if (balance == null) {
      return [];
    }
    if (balance.token != null) {
      for (final tokenBalance in balance.token!) {
        if (tokenBalance.address != null) {
          tokenAddressList.add(tokenBalance.address!);
        }
      }

      final tokenMap = await sl.get<ApiService>().getToken(
            tokenAddressList.toSet().toList(),
            request: 'genesis, name, id, supply, symbol, type',
          );

      for (final tokenBalance in balance.token!) {
        final token = tokenMap[tokenBalance.address];
        if (token != null && token.type == 'fungible') {
          final tokenInformations = TokenInformations(
            address: tokenBalance.address,
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
    }

    return fungiblesTokensList;
  }

  Future<List<AccountToken>> getNFTList(
    String address,
    String seed,
    String name,
  ) async {
    final balanceMap = await sl.get<ApiService>().fetchBalance([address]);
    final balance = balanceMap[address];
    final nftList = List<AccountToken>.empty(growable: true);

    final tokenAddressList = <String>[];
    if (balance == null) {
      return [];
    }
    if (balance.token != null) {
      for (final tokenBalance in balance.token!) {
        if (tokenBalance.address != null) {
          tokenAddressList.add(tokenBalance.address!);
        }
      }

      final tokenMap = await sl.get<ApiService>().getToken(
            tokenAddressList.toSet().toList(),
          );

      // TODO(reddwarf03) : temporaly section -> need https://github.com/archethic-foundation/archethic-node/issues/714
      final nameEncoded = Uri.encodeFull(name);
      final serviceName = 'archethic-wallet-$nameEncoded';
      late Keychain keychain;
      late KeyPair keypair;
      final secretMap = await sl.get<ApiService>().getTransaction(
            tokenAddressList.toSet().toList(),
            request:
                'data { ownerships { authorizedPublicKeys { encryptedSecretKey, publicKey } secret }  }',
          );

      if (secretMap.isNotEmpty) {
        keychain = await sl.get<ApiService>().getKeychain(seed);
        keypair = keychain.deriveKeypair(serviceName);
      }

      for (final tokenBalance in balance.token!) {
        final token = tokenMap[tokenBalance.address];
        if (token != null && token.type == 'non-fungible') {
          final tokenWithoutFile = token.tokenProperties!
            ..removeWhere((key, value) => key == 'file');

          if (secretMap[tokenBalance.address] != null &&
              secretMap[tokenBalance.address]!.data != null &&
              secretMap[tokenBalance.address]!.data!.ownerships != null &&
              secretMap[tokenBalance.address]!.data!.ownerships!.isNotEmpty) {
            tokenWithoutFile.addAll(
              _tokenPropertiesDecryptedSecret(
                keypair: keypair,
                ownerships: secretMap[tokenBalance.address]!.data!.ownerships!,
              ),
            );
          }

          final tokenInformations = TokenInformations(
            address: tokenBalance.address,
            name: token.name,
            id: token.id,
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
    }

    return nftList;
  }

  Map<String, dynamic> _tokenPropertiesDecryptedSecret({
    required KeyPair keypair,
    required List<Ownership> ownerships,
  }) {
    final propertiesDecrypted = <String, dynamic>{};
    for (final ownership in ownerships) {
      final authorizedPublicKey = ownership.authorizedPublicKeys!.firstWhere(
        (AuthorizedKey authKey) =>
            authKey.publicKey!.toUpperCase() ==
            uint8ListToHex(keypair.publicKey).toUpperCase(),
        orElse: AuthorizedKey.new,
      );
      if (authorizedPublicKey.encryptedSecretKey != null) {
        final aesKey = ecDecrypt(
          authorizedPublicKey.encryptedSecretKey,
          keypair.privateKey,
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
    final balanceMap =
        await sl.get<ApiService>().fetchBalance(addresses.toSet().toList());
    final balancesToReturn = <String, Balance>{};
    for (final address in addresses) {
      final balance = balanceMap[address] ??
          Balance(uco: 0, token: List<TokenBalance>.empty(growable: true));
      final balanceTokenList = List<TokenBalance>.empty(growable: true);
      if (balance.token != null) {
        for (var i = 0; i < balance.token!.length; i++) {
          var balanceToken = TokenBalance();
          balanceToken = balance.token![i];
          balanceTokenList.add(balanceToken);
        }
        balance.token = balanceTokenList;
      }
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
    String seed,
    String address,
    DateFormat dateFormat,
    String cryptoCurrency,
    BuildContext context,
    String name,
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
          valueInfo: transaction.address!,
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
            valueInfo: transaction.type == 'token'
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
      if (transaction.data!.ownerships != null &&
          transaction.data!.ownerships!.isNotEmpty) {
        final nameEncoded = Uri.encodeFull(name);
        final serviceName = 'archethic-wallet-$nameEncoded';
        final keychain = await sl.get<ApiService>().getKeychain(seed);
        final keypair = keychain.deriveKeypair(serviceName);

        for (final ownership in transaction.data!.ownerships!) {
          final authorizedPublicKey =
              ownership.authorizedPublicKeys!.firstWhere(
            (AuthorizedKey authKey) =>
                authKey.publicKey!.toUpperCase() ==
                uint8ListToHex(keypair.publicKey).toUpperCase(),
            orElse: AuthorizedKey.new,
          );
          if (authorizedPublicKey.encryptedSecretKey != null) {
            final aesKey = ecDecrypt(
              authorizedPublicKey.encryptedSecretKey,
              keypair.privateKey,
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
          transaction.data!.ledger!.uco!.transfers != null &&
          transaction.data!.ledger!.uco!.transfers!.isNotEmpty) {
        transactionsInfos.add(
          TransactionInfos(
            domain: 'UCOLedger',
            titleInfo: '',
            valueInfo: '',
          ),
        );
        for (var i = 0;
            i < transaction.data!.ledger!.uco!.transfers!.length;
            i++) {
          if (transaction.data!.ledger!.uco!.transfers![i].to != null) {
            var recipientContactName = '';

            final contact = await sl.get<DBHelper>().getContactWithAddress(
                  transaction.data!.ledger!.uco!.transfers![i].to!,
                );
            if (contact != null && contact.name.length > 1) {
              recipientContactName = contact.name.substring(1);
            }

            if (recipientContactName.isEmpty) {
              transactionsInfos.add(
                TransactionInfos(
                  domain: 'UCOLedger',
                  titleInfo: 'To',
                  valueInfo: transaction.data!.ledger!.uco!.transfers![i].to!,
                ),
              );
            } else {
              transactionsInfos.add(
                TransactionInfos(
                  domain: 'UCOLedger',
                  titleInfo: 'To',
                  valueInfo:
                      '$recipientContactName\n${transaction.data!.ledger!.uco!.transfers![i].to!}',
                ),
              );
            }
          }
          if (transaction.data!.ledger!.uco!.transfers![i].amount != null) {
            transactionsInfos.add(
              TransactionInfos(
                domain: 'UCOLedger',
                titleInfo: 'Amount',
                valueInfo:
                    '${NumberUtil.formatThousands(fromBigInt(transaction.data!.ledger!.uco!.transfers![i].amount))} $cryptoCurrency',
              ),
            );
          }
        }
      }
      if (transaction.data!.ledger != null &&
          transaction.data!.ledger!.token != null &&
          transaction.data!.ledger!.token!.transfers != null &&
          transaction.data!.ledger!.token!.transfers!.isNotEmpty) {
        transactionsInfos.add(
          TransactionInfos(
            domain: 'TokenLedger',
            titleInfo: '',
            valueInfo: '',
          ),
        );
        for (var i = 0;
            i < transaction.data!.ledger!.token!.transfers!.length;
            i++) {
          if (transaction.data!.ledger!.token!.transfers![i].tokenAddress !=
              null) {
            transactionsInfos.add(
              TransactionInfos(
                domain: 'TokenLedger',
                titleInfo: 'Token',
                valueInfo: transaction
                    .data!.ledger!.token!.transfers![i].tokenAddress!,
              ),
            );
          }
          if (transaction.data!.ledger!.token!.transfers![i].to != null) {
            transactionsInfos.add(
              TransactionInfos(
                domain: 'TokenLedger',
                titleInfo: 'To',
                valueInfo: transaction.data!.ledger!.token!.transfers![i].to!,
              ),
            );
          }
          if (transaction.data!.ledger!.token!.transfers![i].amount != null) {
            final contentMap = await sl.get<ApiService>().getTransactionContent(
              {
                transaction.data!.ledger!.token!.transfers![i].tokenAddress!: ''
              },
            );
            final token = tokenFromJson(
              contentMap[transaction
                  .data!.ledger!.token!.transfers![i].tokenAddress!]!,
            );
            transactionsInfos.add(
              TransactionInfos(
                domain: 'TokenLedger',
                titleInfo: 'Amount',
                valueInfo:
                    '${NumberUtil.formatThousands(fromBigInt(transaction.data!.ledger!.token!.transfers![i].amount))} ${token.symbol!}',
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
    String name,
  ) async {
    final lastTransactionMap = await sl
        .get<ApiService>()
        .getLastTransaction([address], request: 'chainLength');
    final transaction =
        Transaction(type: 'transfer', data: Transaction.initData());
    for (final transfer in listUcoTransfer) {
      transaction.addUCOTransfer(transfer.to, transfer.amount!);
    }
    for (final transfer in listTokenTransfer) {
      transaction.addTokenTransfer(
        transfer.to,
        transfer.amount!,
        transfer.tokenAddress,
        tokenId: transfer.tokenId == null ? 0 : transfer.tokenId!,
      );
    }
    if (message.isNotEmpty) {
      final aesKey = uint8ListToHex(
        Uint8List.fromList(
          List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
        ),
      );

      final nameEncoded = Uri.encodeFull(name);
      final serviceName = 'archethic-wallet-$nameEncoded';
      final keychain = await sl.get<ApiService>().getKeychain(seed);
      final walletKeyPair = keychain.deriveKeypair(serviceName);

      final authorizedPublicKeys = List<String>.empty(growable: true)
        ..add(uint8ListToHex(walletKeyPair.publicKey));

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

      transaction.addOwnership(aesEncrypt(message, aesKey), authorizedKeys);
    }

    var transactionFee = TransactionFee();
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

  Future<Keychain> getKeychain(String seed) async {
    final keychain = await sl.get<ApiService>().getKeychain(seed);
    return keychain;
  }

  Future<TokenInformations?> getNFT(
    String address,
    String seed,
    String name,
  ) async {
    final tokenMap = await sl.get<ApiService>().getToken(
      [address],
    );

    if (tokenMap.isEmpty ||
        tokenMap[address] == null ||
        tokenMap[address]!.type != 'non-fungible') {
      return null;
    }

    // TODO(reddwarf03) : temporaly section -> need https://github.com/archethic-foundation/archethic-node/issues/714
    final nameEncoded = Uri.encodeFull(name);
    final serviceName = 'archethic-wallet-$nameEncoded';
    late Keychain keychain;
    late KeyPair keypair;
    final secretMap = await sl.get<ApiService>().getTransaction(
      [address],
      request:
          'data { ownerships { authorizedPublicKeys { encryptedSecretKey, publicKey } secret }  }',
    );

    if (secretMap.isNotEmpty) {
      keychain = await sl.get<ApiService>().getKeychain(seed);
      keypair = keychain.deriveKeypair(serviceName);
    }

    final token = tokenMap[address]!;

    final tokenWithoutFile = token.tokenProperties!
      ..removeWhere((key, value) => key == 'file');

    if (secretMap[address] != null &&
        secretMap[address]!.data != null &&
        secretMap[address]!.data!.ownerships != null &&
        secretMap[address]!.data!.ownerships!.isNotEmpty) {
      tokenWithoutFile.addAll(
        _tokenPropertiesDecryptedSecret(
          keypair: keypair,
          ownerships: secretMap[address]!.data!.ownerships!,
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
