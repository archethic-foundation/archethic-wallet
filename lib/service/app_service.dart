/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/model/data/token_informations_property.dart';
import 'package:aewallet/model/transaction_infos.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/number_util.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppService {
  // TODO(reddwarf03): Error loading recent transactions when tx number > 10, https://github.com/archethic-foundation/archethic-wallet/issues/262
  Future<List<Transaction>> getTransactionChain(
    String address,
    String? pagingAddress,
    String? request,
  ) async {
    final transactionChain = await sl.get<ApiService>().getTransactionChain(
          address,
          pagingAddress: pagingAddress ?? '',
          request: request!,
        );
    return transactionChain;
  }

  Future<List<TransactionInput>> getTransactionInputs(
    String address,
    String request,
  ) async {
    final transactionInputs = await sl
        .get<ApiService>()
        .getTransactionInputs(address, request: request);
    return transactionInputs;
  }

  Future<List<RecentTransaction>> getRecentTransactions(
    String genesisAddress,
    String lastAddress,
    String seed,
    String name,
  ) async {
    var pagingAddress = '';
    final lastTransaction = await sl
        .get<ApiService>()
        .getLastTransaction(lastAddress, request: 'chainLength');
    if (lastTransaction.chainLength! > 10) {
      final keychain = await sl.get<ApiService>().getKeychain(seed);
      final nameEncoded = Uri.encodeFull(name);
      final serviceName = 'archethic-wallet-$nameEncoded';
      pagingAddress = uint8ListToHex(
        keychain.deriveAddress(
          serviceName,
          index: lastTransaction.chainLength! - 10,
        ),
      );
    }

    final transactionChain = await getTransactionChain(
      lastAddress,
      pagingAddress,
      'address, type, validationStamp { timestamp, ledgerOperations { fee } }, data { ownerships { secret, authorizedPublicKeys { encryptedSecretKey, publicKey } }, content , ledger { uco { transfers { amount, to } } token {transfers {amount, to, tokenAddress, tokenId } } } }, inputs { from, type, spent, tokenAddress, tokenId, amount, timestamp }',
    );

    final transactionInputsGenesisAddress = await getTransactionInputs(
      genesisAddress,
      'from, type, spent, tokenAddress, amount, timestamp',
    );

    final recentTransactions = List<RecentTransaction>.empty(growable: true);

    for (final transaction in transactionChain) {
      final content = transaction.data!.content!.toLowerCase();
      if (transaction.type! == 'token') {
        final recentTransaction = RecentTransaction()
          ..address = transaction.address
          ..timestamp = transaction.validationStamp!.timestamp
          ..typeTx = RecentTransaction.tokenCreation
          ..content = transaction.data!.content
          ..fee = fromBigInt(transaction.validationStamp!.ledgerOperations!.fee)
              .toDouble();
        recentTransaction.tokenInformations = await recentTransaction
            .getTokenInfo(transaction.data!.content, transaction.address);
        recentTransactions.add(recentTransaction);
      } else {
        if (transaction.type! == 'transfer') {
          for (var i = 0;
              i < transaction.data!.ledger!.uco!.transfers!.length;
              i++) {
            final recentTransaction = RecentTransaction()
              ..content = content
              ..address = transaction.address
              ..typeTx = RecentTransaction.transferOutput
              ..amount = fromBigInt(
                transaction.data!.ledger!.uco!.transfers![i].amount,
              ).toDouble()
              ..recipient = transaction.data!.ledger!.uco!.transfers![i].to
              ..fee =
                  fromBigInt(transaction.validationStamp!.ledgerOperations!.fee)
                      .toDouble()
              ..timestamp = transaction.validationStamp!.timestamp
              ..from = lastAddress
              ..decryptedSecret = List<String>.empty(growable: true);
            if (transaction.data!.ownerships != null) {
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

                  recentTransaction.decryptedSecret!
                      .add(utf8.decode(decryptedSecret));
                }
              }
            }
            recentTransactions.add(recentTransaction);
          }
          for (var i = 0;
              i < transaction.data!.ledger!.token!.transfers!.length;
              i++) {
            final recentTransaction = RecentTransaction()
              ..content = content
              ..address = transaction.address
              ..typeTx = RecentTransaction.transferOutput
              ..amount = fromBigInt(
                transaction.data!.ledger!.token!.transfers![i].amount,
              ).toDouble()
              ..recipient = transaction.data!.ledger!.token!.transfers![i].to
              ..fee =
                  fromBigInt(transaction.validationStamp!.ledgerOperations!.fee)
                      .toDouble()
              ..timestamp = transaction.validationStamp!.timestamp
              ..from = lastAddress
              ..decryptedSecret = List<String>.empty(growable: true);
            recentTransaction.tokenInformations =
                await recentTransaction.getTokenInfo(
              null,
              transaction.data!.ledger!.token!.transfers![i].tokenAddress,
            );
            if (transaction.data!.ownerships != null) {
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

                  recentTransaction.decryptedSecret!
                      .add(utf8.decode(decryptedSecret));
                }
              }
            }

            recentTransactions.add(recentTransaction);
          }
        }
      }

      if (transaction.inputs != null) {
        for (final transactionInput in transaction.inputs!) {
          if (transactionInput.from != transaction.address &&
              // TODO(reddwarf03): See Apoorv's PR
              transactionInput.spent == false &&
              (transactionInput.tokenAddress == null ||
                  transactionInput.from != transactionInput.tokenAddress)) {
            final recentTransaction = RecentTransaction()
              ..address = transactionInput.from
              ..amount = fromBigInt(transactionInput.amount).toDouble()
              ..typeTx = RecentTransaction.transferInput
              ..from = transactionInput.from
              ..recipient = transaction.address
              ..timestamp = transactionInput.timestamp
              ..fee = 0
              ..content = transaction.data!.content
              ..decryptedSecret = List<String>.empty(growable: true);
            recentTransaction.tokenInformations = await recentTransaction
                .getTokenInfo('', transactionInput.tokenAddress);
            final ownerships = await sl
                .get<ApiService>()
                .getTransactionOwnerships(transactionInput.from!);
            if (ownerships.isNotEmpty) {
              final nameEncoded = Uri.encodeFull(name);
              final serviceName = 'archethic-wallet-$nameEncoded';
              final keychain = await sl.get<ApiService>().getKeychain(seed);
              final keypair = keychain.deriveKeypair(serviceName);
              for (final ownership in ownerships) {
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
                  recentTransaction.decryptedSecret!
                      .add(utf8.decode(decryptedSecret));
                }
              }
            }

            recentTransactions.add(recentTransaction);
          }
        }
      }
    }

    // Transaction inputs for genesisAddress
    for (final transaction in transactionInputsGenesisAddress) {
      final recentTransaction = RecentTransaction()
        ..address = transaction.from
        ..amount = fromBigInt(transaction.amount).toDouble()
        ..typeTx = RecentTransaction.transferInput
        ..from = transaction.from
        ..recipient = lastAddress
        ..timestamp = transaction.timestamp
        ..fee = 0;
      if (transaction.type! == 'token') {
        final content =
            await sl.get<ApiService>().getTransactionContent(transaction.from!);
        recentTransaction.content = content;
      }
      recentTransaction.decryptedSecret = List<String>.empty(growable: true);
      final ownerships = await sl
          .get<ApiService>()
          .getTransactionOwnerships(recentTransaction.address!);
      if (ownerships.isNotEmpty) {
        final nameEncoded = Uri.encodeFull(name);
        final serviceName = 'archethic-wallet-$nameEncoded';
        final keychain = await sl.get<ApiService>().getKeychain(seed);
        final keypair = keychain.deriveKeypair(serviceName);
        for (final ownership in ownerships) {
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
            recentTransaction.decryptedSecret!
                .add(utf8.decode(decryptedSecret));
          }
        }
      }

      recentTransaction.tokenInformations =
          await recentTransaction.getTokenInfo('', transaction.tokenAddress);
      recentTransactions.add(recentTransaction);
    }

    // Sort by date (desc)
    recentTransactions.sort(
      (RecentTransaction a, RecentTransaction b) =>
          a.timestamp!.compareTo(b.timestamp!),
    );

    for (var i = 0; i < recentTransactions.length; i++) {
      if (i <= 10) {
        recentTransactions[i].contactInformations =
            await recentTransactions[i].getContactInformations();
      }
    }

    return recentTransactions.reversed.toList();
  }

  Future<List<AccountToken>> getFungiblesTokensList(String address) async {
    final balance = await sl.get<ApiService>().fetchBalance(address);
    final fungiblesTokensList = List<AccountToken>.empty(growable: true);

    if (balance.token != null) {
      for (var i = 0; i < balance.token!.length; i++) {
        final token =
            await sl.get<ApiService>().getToken(balance.token![i].address!);
        if (token.type == 'fungible') {
          final propertiesList =
              List<TokenInformationsProperty>.empty(growable: true);
          if (token.tokenProperties != null &&
              token.tokenProperties!.isNotEmpty) {
            token.tokenProperties!.forEach((key, value) {
              final tokenInformationsProperty = TokenInformationsProperty();
              tokenInformationsProperty.name = key;
              tokenInformationsProperty.value = value;
              propertiesList.add(tokenInformationsProperty);
            });
          }

          final tokenInformations = TokenInformations(
            address: balance.token![i].address,
            name: token.name,
            type: token.type,
            supply: fromBigInt(token.supply).toDouble(),
            symbol: token.symbol,
            tokenProperties: propertiesList,
            onChain: true,
          );
          final accountFungibleToken = AccountToken(
            tokenInformations: tokenInformations,
            amount: fromBigInt(balance.token![i].amount).toDouble(),
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

  Future<List<AccountToken>> getNFTList(String address) async {
    final balance = await sl.get<ApiService>().fetchBalance(address);
    final nftList = List<AccountToken>.empty(growable: true);

    if (balance.token != null) {
      for (var i = 0; i < balance.token!.length; i++) {
        if (balance.token![i].tokenId! > 0) {
          final token =
              await sl.get<ApiService>().getToken(balance.token![i].address!);
          if (token.type == 'non-fungible') {
            final propertiesList =
                List<TokenInformationsProperty>.empty(growable: true);
            if (token.tokenProperties != null &&
                token.tokenProperties!.isNotEmpty) {
              token.tokenProperties!.forEach((key, value) {
                final tokenInformationsProperty = TokenInformationsProperty();
                if (key != 'file') {
                  tokenInformationsProperty.name = key;
                  tokenInformationsProperty.value = value;
                  propertiesList.add(tokenInformationsProperty);
                }
              });
            }

            final tokenInformations = TokenInformations(
              address: balance.token![i].address,
              id: token.id,
              name: token.name,
              type: token.type,
              supply: fromBigInt(token.supply).toDouble(),
              symbol: token.symbol,
              tokenProperties: propertiesList,
              onChain: true,
            );
            final accountNFT = AccountToken(
              tokenInformations: tokenInformations,
              amount: fromBigInt(balance.token![i].amount).toDouble(),
            );
            nftList.add(accountNFT);
          }
        }
      }
      nftList.sort(
        (a, b) =>
            a.tokenInformations!.name!.compareTo(b.tokenInformations!.name!),
      );
    }
    return nftList;
  }

  Future<Balance> getBalanceGetResponse(String address) async {
    var balance =
        Balance(uco: 0, token: List<TokenBalance>.empty(growable: true));
    balance = await sl.get<ApiService>().fetchBalance(address);
    final balanceTokenList = List<TokenBalance>.empty(growable: true);
    if (balance.token != null) {
      for (var i = 0; i < balance.token!.length; i++) {
        var balanceToken = TokenBalance();
        balanceToken = balance.token![i];
        balanceTokenList.add(balanceToken);
      }
    }
    return balance;
  }

  Future<List<TransactionInfos>> getTransactionAllInfos(
    String address,
    DateFormat dateFormat,
    String cryptoCurrency,
    BuildContext context,
    String name,
  ) async {
    // ignore: prefer_final_locals
    var transactionsInfos = List<TransactionInfos>.empty(growable: true);

    // ignore: prefer_final_locals
    var transaction =
        await sl.get<ApiService>().getTransactionAllInfos(address);
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
            valueInfo: transaction.data!.content == ''
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
      if (transaction.data!.ownerships != null) {
        final seed = await StateContainer.of(context).getSeed();

        final nameEncoded = Uri.encodeFull(name);
        final serviceName = 'archethic-wallet-$nameEncoded';
        final keychain = await sl.get<ApiService>().getKeychain(seed!);
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
            if (contact != null) {
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
            final content = await sl.get<ApiService>().getTransactionContent(
                  transaction.data!.ledger!.token!.transfers![i].tokenAddress!,
                );
            final token = tokenFromJson(content);
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
    final lastTransaction = await sl
        .get<ApiService>()
        .getLastTransaction(address, request: 'chainLength');
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

      final authorizedPublicKeys = List<String>.empty(growable: true);
      authorizedPublicKeys.add(uint8ListToHex(walletKeyPair.publicKey));

      for (final transfer in listUcoTransfer) {
        final firstTxListRecipient = await sl
            .get<ApiService>()
            .getTransactionChain(transfer.to!, request: 'previousPublicKey');
        if (firstTxListRecipient.isNotEmpty) {
          authorizedPublicKeys
              .add(firstTxListRecipient.first.previousPublicKey!);
        }
      }

      for (final transfer in listTokenTransfer) {
        final firstTxListRecipient = await sl
            .get<ApiService>()
            .getTransactionChain(transfer.to!, request: 'previousPublicKey');
        if (firstTxListRecipient.isNotEmpty) {
          authorizedPublicKeys
              .add(firstTxListRecipient.first.previousPublicKey!);
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
    transaction
        .build(seed, lastTransaction.chainLength!)
        .originSign(originPrivateKey);
    try {
      transactionFee =
          await sl.get<ApiService>().getTransactionFee(transaction);
    } catch (e) {
      dev.log(e.toString());
    }
    return fromBigInt(transactionFee.fee).toDouble();
  }

  Future<double> getFeesEstimationCreateToken(
    String originPrivateKey,
    String seed,
    Token token,
    String accountName,
  ) async {
    final keychain = await sl.get<ApiService>().getKeychain(seed);
    final nameEncoded = Uri.encodeFull(accountName);
    final service = 'archethic-wallet-$nameEncoded';
    final index = (await sl.get<ApiService>().getTransactionIndex(
              uint8ListToHex(keychain.deriveAddress(service)),
            ))
        .chainLength!;

    var transactionFee = TransactionFee();
    try {
      final content = tokenToJsonForTxDataContent(
        Token(
          name: token.name,
          supply: token.supply,
          symbol: token.symbol,
          type: token.type,
          tokenProperties: token.tokenProperties,
        ),
      );
      final transaction =
          Transaction(type: 'token', data: Transaction.initData())
              .setContent(content);
      final signedTx = keychain
          .buildTransaction(transaction, service, index)
          .originSign(originPrivateKey);

      transactionFee = await sl.get<ApiService>().getTransactionFee(signedTx);
    } catch (e) {
      dev.log(e.toString());
    }
    return fromBigInt(transactionFee.fee).toDouble();
  }

  Future<Keychain> getKeychain(String seed) async {
    // Keychain keychain;
    // try {
    final keychain = await sl.get<ApiService>().getKeychain(seed);
    return keychain;
    /*} catch (e) {
      final String originPrivateKey = sl.get<ApiService>().getOriginKey();

      /// Get Wallet KeyPair
      final KeyPair walletKeyPair = deriveKeyPair(seed, 0);

      /// Generate keyChain Seed from random value
      final String keychainSeed = uint8ListToHex(Uint8List.fromList(
          List<int>.generate(32, (int i) => Random.secure().nextInt(256))));

      AppWallet? appWallet = await sl.get<DBHelper>().getAppWallet();
      List<Account> accountsList = appWallet!.appKeychain!.accounts!;

      bool first = true;
      Uint8List genesisAddress;
      for (Account account in accountsList) {
        Price tokenPrice =
            await Price.getCurrency(account.balance!.fiatCurrencyCode!);

        String nameEncoded = Uri.encodeFull(account.name!);

        /// Default service for wallet
        String kServiceName = 'archethic-wallet-$nameEncoded';
        String kDerivationPathWithoutIndex = 'm/650\'/$kServiceName/';
        const String index = '0';
        String kDerivationPath = '$kDerivationPathWithoutIndex$index';

        if (first) {
          first = false;

          Keychain keychain =
              Keychain(hexToUint8List(keychainSeed), version: 1);
          keychain.addService(kServiceName, kDerivationPath);

          /// Create Keychain from keyChain seed and wallet public key to encrypt secret
          final Transaction keychainTransaction = sl
              .get<ApiService>()
              .newKeychainTransaction(
                  keychainSeed,
                  <String>[uint8ListToHex(walletKeyPair.publicKey)],
                  hexToUint8List(originPrivateKey),
                  serviceName: kServiceName,
                  derivationPath: kDerivationPath);

          // ignore: unused_local_variable
          final TransactionStatus transactionStatusKeychain =
              await sl.get<ApiService>().sendTx(keychainTransaction);

          await Future.delayed(const Duration(seconds: 5));

          final Transaction accessKeychainTx = sl
              .get<ApiService>()
              .newAccessKeychainTransaction(
                  seed,
                  hexToUint8List(keychainTransaction.address!),
                  hexToUint8List(originPrivateKey));

          // ignore: unused_local_variable
          final TransactionStatus transactionStatusKeychainAccess =
              await sl.get<ApiService>().sendTx(accessKeychainTx);

          genesisAddress = keychain.deriveAddress(kServiceName, index: 0);
          print('(first) genesisAddress: ${uint8ListToHex(genesisAddress)}');
        } else {
          final Keychain keychain =
              await sl.get<ApiService>().getKeychain(seed);

          final String genesisAddressKeychain =
              deriveAddress(uint8ListToHex(keychain.seed!), 0);

          keychain.addService(kServiceName, kDerivationPath);

          final Transaction lastTransactionKeychain = await sl
              .get<ApiService>()
              .getLastTransaction(genesisAddressKeychain,
                  request:
                      'chainLength, data { content, ownerships
                       { authorizedPublicKeys { publicKey } } }');

          final String aesKey = uint8ListToHex(Uint8List.fromList(
              List<int>.generate(32, (int i) => Random.secure().nextInt(256))));

          Transaction keychainTransaction =
              Transaction(type: 'keychain', data: Transaction.initData())
                  .setContent(jsonEncode(keychain.toDID()));

          final List<AuthorizedKey> authorizedKeys =
              List<AuthorizedKey>.empty(growable: true);
          List<AuthorizedKey> authorizedKeysList = lastTransactionKeychain
              .data!.ownerships![0].authorizedPublicKeys!;
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

          genesisAddress = keychain.deriveAddress(kServiceName, index: 0);
          print(
              '(not first) genesisAddress: ${uint8ListToHex(genesisAddress)}');
        }

        Account selectedAcct = Account(
            lastLoadingTransactionInputs: 0,
            lastAddress: uint8ListToHex(genesisAddress),
            genesisAddress: uint8ListToHex(genesisAddress),
            name: account.name,
            balance: AccountBalance(
                fiatCurrencyCode: '',
                fiatCurrencyValue: 0,
                nativeTokenName: account.balance!.nativeTokenName,
                nativeTokenValue: 0,
                tokenPrice: tokenPrice),
            selected: false,
            recentTransactions: []);

        appWallet.appKeychain!.accounts!
            .removeWhere((element) => element.name == selectedAcct.name);
        appWallet.appKeychain!.accounts!.add(selectedAcct);
        await appWallet.save();

        final Contact newContact = Contact(
            name: '@${account.name}',
            address: uint8ListToHex(genesisAddress),
            type: 'keychainService');
        await sl.get<DBHelper>().deleteContact(newContact);
        await sl.get<DBHelper>().saveContact(newContact);
      }

      keychain = await getKeychain(seed);
      return keychain;
    }*/
  }
}
