/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';

// Package imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/data/token_informations_property.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/model/transaction_infos.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/number_util.dart';

class AppService {
  Future<List<Transaction>> getTransactionChain(
      String address, String? pagingAddress, String? request) async {
    pagingAddress ??= '';
    final List<Transaction> transactionChain = await sl
        .get<ApiService>()
        .getTransactionChain(address,
            pagingAddress: pagingAddress, request: request!);
    return transactionChain;
  }

  Future<List<TransactionInput>> getTransactionInputs(
      String address, String request) async {
    final List<TransactionInput> transactionInputs = await sl
        .get<ApiService>()
        .getTransactionInputs(address, request: request);
    return transactionInputs;
  }

  Future<List<RecentTransaction>> getRecentTransactions(String genesisAddress,
      String lastAddress, String seed, String name) async {
    String pagingAddress = '';
    final Transaction lastTransaction = await sl
        .get<ApiService>()
        .getLastTransaction(lastAddress, request: 'chainLength');
    if (lastTransaction.chainLength! > 10) {
      final Keychain keychain = await sl.get<ApiService>().getKeychain(seed);
      String nameEncoded = Uri.encodeFull(name);
      String serviceName = 'archethic-wallet-$nameEncoded';
      pagingAddress = uint8ListToHex(keychain.deriveAddress(serviceName,
          index: lastTransaction.chainLength! - 10));
    }

    final List<Transaction> transactionChain = await getTransactionChain(
        lastAddress,
        pagingAddress,
        'address, type, validationStamp { timestamp, ledgerOperations { fee } }, data { ownerships { secret, authorizedPublicKeys { encryptedSecretKey, publicKey } }, content , ledger { uco { transfers { amount, to } } token {transfers {amount, to, token, tokenId } } } }, inputs { from, type, spent, tokenAddress, tokenId, amount, timestamp }');

    final List<TransactionInput> transactionInputsGenesisAddress =
        await getTransactionInputs(genesisAddress,
            'from, type, spent, tokenAddress, amount, timestamp');

    final List<RecentTransaction> recentTransactions =
        List<RecentTransaction>.empty(growable: true);

    for (Transaction transaction in transactionChain) {
      String content = transaction.data!.content!.toLowerCase();
      if (transaction.type! == 'token') {
        final RecentTransaction recentTransaction = RecentTransaction();
        recentTransaction.address = transaction.address;
        recentTransaction.timestamp = transaction.validationStamp!.timestamp!;
        recentTransaction.typeTx = RecentTransaction.tokenCreation;
        recentTransaction.content = transaction.data!.content;
        recentTransaction.fee =
            fromBigInt(transaction.validationStamp!.ledgerOperations!.fee!)
                .toDouble();
        recentTransaction.tokenInformations = await recentTransaction
            .getTokenInfo(transaction.data!.content, transaction.address);
        recentTransactions.add(recentTransaction);
      } else {
        if (transaction.type! == 'transfer') {
          for (int i = 0;
              i < transaction.data!.ledger!.uco!.transfers!.length;
              i++) {
            final RecentTransaction recentTransaction = RecentTransaction();
            recentTransaction.content = content;
            recentTransaction.address = transaction.address;
            recentTransaction.typeTx = RecentTransaction.transferOutput;
            recentTransaction.amount =
                fromBigInt(transaction.data!.ledger!.uco!.transfers![i].amount!)
                    .toDouble();

            recentTransaction.recipient =
                transaction.data!.ledger!.uco!.transfers![i].to!;
            recentTransaction.fee =
                fromBigInt(transaction.validationStamp!.ledgerOperations!.fee!)
                    .toDouble();
            recentTransaction.timestamp =
                transaction.validationStamp!.timestamp!;
            recentTransaction.from = lastAddress;
            recentTransaction.decryptedSecret =
                List<String>.empty(growable: true);
            if (transaction.data!.ownerships != null) {
              final KeyPair keypair = deriveKeyPair(seed, 0);
              for (Ownership ownership in transaction.data!.ownerships!) {
                final AuthorizedKey authorizedPublicKey =
                    ownership.authorizedPublicKeys!.firstWhere(
                        (AuthorizedKey authKey) =>
                            authKey.publicKey!.toUpperCase() ==
                            uint8ListToHex(keypair.publicKey).toUpperCase(),
                        orElse: () => AuthorizedKey());
                if (authorizedPublicKey.encryptedSecretKey != null) {
                  final Uint8List aesKey = ecDecrypt(
                      authorizedPublicKey.encryptedSecretKey,
                      keypair.privateKey);
                  final Uint8List decryptedSecret =
                      aesDecrypt(ownership.secret, aesKey);

                  recentTransaction.decryptedSecret!
                      .add(utf8.decode(decryptedSecret));
                }
              }
            }

            recentTransactions.add(recentTransaction);
          }
          for (int i = 0;
              i < transaction.data!.ledger!.token!.transfers!.length;
              i++) {
            final RecentTransaction recentTransaction = RecentTransaction();
            recentTransaction.content = content;
            recentTransaction.address = transaction.address;
            recentTransaction.typeTx = RecentTransaction.transferOutput;
            recentTransaction.amount = fromBigInt(
                    transaction.data!.ledger!.token!.transfers![i].amount!)
                .toDouble();
            recentTransaction.recipient =
                transaction.data!.ledger!.token!.transfers![i].to!;
            recentTransaction.fee =
                fromBigInt(transaction.validationStamp!.ledgerOperations!.fee!)
                    .toDouble();
            recentTransaction.timestamp =
                transaction.validationStamp!.timestamp!;
            recentTransaction.from = lastAddress;
            recentTransaction.tokenInformations =
                await recentTransaction.getTokenInfo(
                    null, transaction.data!.ledger!.token!.transfers![i].token);

            recentTransaction.decryptedSecret =
                List<String>.empty(growable: true);
            if (transaction.data!.ownerships != null) {
              final KeyPair keypair = deriveKeyPair(seed, 0);
              for (Ownership ownership in transaction.data!.ownerships!) {
                final AuthorizedKey authorizedPublicKey =
                    ownership.authorizedPublicKeys!.firstWhere(
                        (AuthorizedKey authKey) =>
                            authKey.publicKey!.toUpperCase() ==
                            uint8ListToHex(keypair.publicKey).toUpperCase(),
                        orElse: () => AuthorizedKey());
                if (authorizedPublicKey.encryptedSecretKey != null) {
                  final Uint8List aesKey = ecDecrypt(
                      authorizedPublicKey.encryptedSecretKey,
                      keypair.privateKey);
                  final Uint8List decryptedSecret =
                      aesDecrypt(ownership.secret, aesKey);

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
        for (TransactionInput transactionInput in transaction.inputs!) {
          if (transactionInput.from != transaction.address &&
              transactionInput.type! != 'token') {
            final RecentTransaction recentTransaction = RecentTransaction();
            recentTransaction.address = transactionInput.from;
            recentTransaction.amount =
                fromBigInt(transactionInput.amount!).toDouble();
            recentTransaction.typeTx = RecentTransaction.transferInput;
            recentTransaction.from = transactionInput.from;
            recentTransaction.recipient = transaction.address;
            recentTransaction.timestamp = transactionInput.timestamp!;
            recentTransaction.fee = 0;
            recentTransaction.content = transaction.data!.content;
            recentTransaction.tokenInformations = await recentTransaction
                .getTokenInfo('', transactionInput.tokenAddress);
            recentTransactions.add(recentTransaction);
          }
        }
      }
    }

    // Transaction inputs for genesisAddress
    for (TransactionInput transaction in transactionInputsGenesisAddress) {
      final RecentTransaction recentTransaction = RecentTransaction();
      recentTransaction.address = transaction.from;
      if (transaction.type! == 'token') {
        String content =
            await sl.get<ApiService>().getTransactionContent(transaction.from!);
        recentTransaction.content = content;
      }
      recentTransaction.decryptedSecret = List<String>.empty(growable: true);
      List<Ownership> ownerships = await sl
          .get<ApiService>()
          .getTransactionOwnerships(recentTransaction.address!);
      if (ownerships.isNotEmpty) {
        final KeyPair keypair = deriveKeyPair(seed, 0);
        for (Ownership ownership in ownerships) {
          final AuthorizedKey authorizedPublicKey =
              ownership.authorizedPublicKeys!.firstWhere(
                  (AuthorizedKey authKey) =>
                      authKey.publicKey!.toUpperCase() ==
                      uint8ListToHex(keypair.publicKey).toUpperCase(),
                  orElse: () => AuthorizedKey());
          if (authorizedPublicKey.encryptedSecretKey != null) {
            final Uint8List aesKey = ecDecrypt(
                authorizedPublicKey.encryptedSecretKey, keypair.privateKey);
            final Uint8List decryptedSecret =
                aesDecrypt(ownership.secret, aesKey);
            recentTransaction.decryptedSecret!
                .add(utf8.decode(decryptedSecret));
          }
        }
      }
      recentTransaction.amount = fromBigInt(transaction.amount!).toDouble();
      recentTransaction.typeTx = RecentTransaction.transferInput;
      recentTransaction.from = transaction.from;
      recentTransaction.recipient = lastAddress;
      recentTransaction.timestamp = transaction.timestamp!;
      recentTransaction.fee = 0;
      recentTransaction.tokenInformations =
          await recentTransaction.getTokenInfo('', transaction.tokenAddress);
      recentTransactions.add(recentTransaction);
    }

    // Sort by date (desc)
    recentTransactions.sort((RecentTransaction a, RecentTransaction b) =>
        a.timestamp!.compareTo(b.timestamp!));

    for (int i = 0; i < recentTransactions.length; i++) {
      if (i <= 10) {
        recentTransactions[i].contactInformations =
            await recentTransactions[i].getContactInformations();
      }
    }

    return recentTransactions.reversed.toList();
  }

  Future<List<AccountToken>> getFungiblesTokensList(String address) async {
    Balance balance = await sl.get<ApiService>().fetchBalance(address);
    final List<AccountToken> fungiblesTokensList =
        List<AccountToken>.empty(growable: true);

    if (balance.token != null) {
      for (int i = 0; i < balance.token!.length; i++) {
        Token token =
            await sl.get<ApiService>().getToken(balance.token![i].address!);
        if (token.type == 'fungible') {
          List<List<TokenInformationsProperty>>? tokenPropertiesList =
              List<List<TokenInformationsProperty>>.empty(growable: true);
          List<TokenInformationsProperty> propertiesList =
              List<TokenInformationsProperty>.empty(growable: true);
          if (token.tokenProperties != null &&
              token.tokenProperties!.isNotEmpty) {
            for (TokenProperty element in token.tokenProperties![0]) {
              TokenInformationsProperty tokenInformationsProperty =
                  TokenInformationsProperty();
              tokenInformationsProperty.name = element.name;
              tokenInformationsProperty.value = element.value;
              propertiesList.add(tokenInformationsProperty);
            }
            tokenPropertiesList.add(propertiesList);
          }

          TokenInformations tokenInformations = TokenInformations(
              address: balance.token![i].address,
              name: token.name,
              type: token.type,
              supply: fromBigInt(token.supply!).toDouble(),
              symbol: token.symbol,
              tokenProperties: tokenPropertiesList,
              onChain: true);
          AccountToken accountFungibleToken = AccountToken(
              tokenInformations: tokenInformations,
              amount: fromBigInt(balance.token![i].amount!).toDouble());
          fungiblesTokensList.add(accountFungibleToken);
        }
      }
      fungiblesTokensList.sort((a, b) =>
          a.tokenInformations!.name!.compareTo(b.tokenInformations!.name!));
    }
    return fungiblesTokensList;
  }

  Future<List<AccountToken>> getNFTList(String address) async {
    Balance balance = await sl.get<ApiService>().fetchBalance(address);
    final List<AccountToken> nftList = List<AccountToken>.empty(growable: true);

    if (balance.token != null) {
      for (int i = 0; i < balance.token!.length; i++) {
        if (balance.token![i].tokenId! > 0) {
          Token token =
              await sl.get<ApiService>().getToken(balance.token![i].address!);
          if (token.type == 'non-fungible') {
            List<List<TokenInformationsProperty>>? tokenPropertiesList =
                List<List<TokenInformationsProperty>>.empty(growable: true);
            List<TokenInformationsProperty> propertiesList =
                List<TokenInformationsProperty>.empty(growable: true);
            if (token.tokenProperties != null &&
                token.tokenProperties!.isNotEmpty) {
              for (TokenProperty element in token.tokenProperties![0]) {
                TokenInformationsProperty tokenInformationsProperty =
                    TokenInformationsProperty();
                if (element.name != 'file') {
                  tokenInformationsProperty.name = element.name;
                  tokenInformationsProperty.value = element.value;
                  propertiesList.add(tokenInformationsProperty);
                }
              }
              tokenPropertiesList.add(propertiesList);
            }

            TokenInformations tokenInformations = TokenInformations(
                address: balance.token![i].address,
                name: token.name,
                type: token.type,
                supply: fromBigInt(token.supply!).toDouble(),
                symbol: token.symbol,
                tokenProperties: tokenPropertiesList,
                onChain: true);
            AccountToken accountNFT = AccountToken(
                tokenInformations: tokenInformations,
                amount: fromBigInt(balance.token![i].amount!).toDouble());
            nftList.add(accountNFT);
          }
        }
      }
      // nftList.sort((a, b) =>
      //     a.tokenInformations!.name!.compareTo(b.tokenInformations!.name!));
    }
    return nftList;
  }

  Future<Balance> getBalanceGetResponse(String address) async {
    Balance balance =
        Balance(uco: 0, token: List<TokenBalance>.empty(growable: true));
    balance = await sl.get<ApiService>().fetchBalance(address);
    final List<TokenBalance> balanceTokenList =
        List<TokenBalance>.empty(growable: true);
    if (balance.token != null) {
      for (int i = 0; i < balance.token!.length; i++) {
        TokenBalance balanceToken = TokenBalance();
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
      BuildContext context) async {
    // ignore: prefer_final_locals
    List<TransactionInfos> transactionsInfos =
        List<TransactionInfos>.empty(growable: true);

    // ignore: prefer_final_locals
    Transaction transaction =
        await sl.get<ApiService>().getTransactionAllInfos(address);
    if (transaction.address != null) {
      transactionsInfos.add(TransactionInfos(
          domain: '', titleInfo: 'Address', valueInfo: transaction.address!));
    }
    if (transaction.type != null) {
      transactionsInfos.add(TransactionInfos(
          domain: '', titleInfo: 'Type', valueInfo: transaction.type!));
    }
    if (transaction.data != null) {
      transactionsInfos
          .add(TransactionInfos(domain: 'Data', titleInfo: '', valueInfo: ''));
      if (transaction.data!.content != null) {
        transactionsInfos.add(TransactionInfos(
            domain: 'Data',
            titleInfo: 'Content',
            valueInfo: transaction.data!.content == ''
                ? 'N/A'
                : transaction.data!.content!));
      }
      if (transaction.data!.code != null) {
        transactionsInfos.add(TransactionInfos(
            domain: 'Data',
            titleInfo: 'Code',
            valueInfo: transaction.data!.code!));
      }
      if (transaction.data!.ownerships != null) {
        String? seed = await StateContainer.of(context).getSeed();
        final KeyPair keypair = deriveKeyPair(seed!, 0);
        for (Ownership ownership in transaction.data!.ownerships!) {
          final AuthorizedKey authorizedPublicKey =
              ownership.authorizedPublicKeys!.firstWhere(
                  (AuthorizedKey authKey) =>
                      authKey.publicKey!.toUpperCase() ==
                      uint8ListToHex(keypair.publicKey).toUpperCase(),
                  orElse: () => AuthorizedKey());
          if (authorizedPublicKey.encryptedSecretKey != null) {
            final Uint8List aesKey = ecDecrypt(
                authorizedPublicKey.encryptedSecretKey, keypair.privateKey);
            final Uint8List decryptedSecret =
                aesDecrypt(ownership.secret, aesKey);
            transactionsInfos.add(TransactionInfos(
                domain: 'Data',
                titleInfo: 'Secret',
                valueInfo: utf8.decode(decryptedSecret)));
          }
        }
      }
      if (transaction.data!.ledger != null &&
          transaction.data!.ledger!.uco != null &&
          transaction.data!.ledger!.uco!.transfers != null &&
          transaction.data!.ledger!.uco!.transfers!.isNotEmpty) {
        transactionsInfos.add(TransactionInfos(
            domain: 'UCOLedger', titleInfo: '', valueInfo: ''));
        for (int i = 0;
            i < transaction.data!.ledger!.uco!.transfers!.length;
            i++) {
          if (transaction.data!.ledger!.uco!.transfers![i].to != null) {
            String recipientContactName = '';

            Contact? contact = await sl.get<DBHelper>().getContactWithAddress(
                transaction.data!.ledger!.uco!.transfers![i].to!);
            if (contact != null) {
              recipientContactName = contact.name!.substring(1);
            }

            if (recipientContactName.isEmpty) {
              transactionsInfos.add(TransactionInfos(
                  domain: 'UCOLedger',
                  titleInfo: 'To',
                  valueInfo: transaction.data!.ledger!.uco!.transfers![i].to!));
            } else {
              transactionsInfos.add(TransactionInfos(
                  domain: 'UCOLedger',
                  titleInfo: 'To',
                  valueInfo:
                      '$recipientContactName\n${transaction.data!.ledger!.uco!.transfers![i].to!}'));
            }
          }
          if (transaction.data!.ledger!.uco!.transfers![i].amount != null) {
            transactionsInfos.add(TransactionInfos(
                domain: 'UCOLedger',
                titleInfo: 'Amount',
                valueInfo:
                    '${NumberUtil.formatThousands(fromBigInt(transaction.data!.ledger!.uco!.transfers![i].amount!))} $cryptoCurrency'));
          }
        }
      }
      if (transaction.data!.ledger != null &&
          transaction.data!.ledger!.token != null &&
          transaction.data!.ledger!.token!.transfers != null &&
          transaction.data!.ledger!.token!.transfers!.isNotEmpty) {
        transactionsInfos.add(TransactionInfos(
            domain: 'TokenLedger', titleInfo: '', valueInfo: ''));
        for (int i = 0;
            i < transaction.data!.ledger!.token!.transfers!.length;
            i++) {
          if (transaction.data!.ledger!.token!.transfers![i].token != null) {
            transactionsInfos.add(TransactionInfos(
                domain: 'TokenLedger',
                titleInfo: 'Token',
                valueInfo:
                    transaction.data!.ledger!.token!.transfers![i].token!));
          }
          if (transaction.data!.ledger!.token!.transfers![i].to != null) {
            transactionsInfos.add(TransactionInfos(
                domain: 'TokenLedger',
                titleInfo: 'To',
                valueInfo: transaction.data!.ledger!.token!.transfers![i].to!));
          }
          if (transaction.data!.ledger!.token!.transfers![i].amount != null) {
            String content = await sl.get<ApiService>().getTransactionContent(
                transaction.data!.ledger!.token!.transfers![i].token!);
            Token token = tokenFromJson(content);
            transactionsInfos.add(TransactionInfos(
                domain: 'TokenLedger',
                titleInfo: 'Amount',
                valueInfo:
                    '${NumberUtil.formatThousands(fromBigInt(transaction.data!.ledger!.token!.transfers![i].amount!))} ${token.symbol!}'));
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
      String message) async {
    final Transaction lastTransaction = await sl
        .get<ApiService>()
        .getLastTransaction(address, request: 'chainLength');
    final Transaction transaction =
        Transaction(type: 'transfer', data: Transaction.initData());
    for (UCOTransfer transfer in listUcoTransfer) {
      transaction.addUCOTransfer(transfer.to, transfer.amount!);
    }
    for (TokenTransfer transfer in listTokenTransfer) {
      transaction.addTokenTransfer(
          transfer.to, transfer.amount!, transfer.token,
          tokenId: transfer.tokenId == null ? 0 : transfer.tokenId!);
    }
    if (message.isNotEmpty) {
      final String aesKey = uint8ListToHex(Uint8List.fromList(
          List<int>.generate(32, (int i) => Random.secure().nextInt(256))));

      final KeyPair walletKeyPair = deriveKeyPair(seed, 0);

      List<String> authorizedPublicKeys = List<String>.empty(growable: true);
      authorizedPublicKeys.add(uint8ListToHex(walletKeyPair.publicKey));

      for (UCOTransfer transfer in listUcoTransfer) {
        final List<Transaction> firstTxListRecipient = await sl
            .get<ApiService>()
            .getTransactionChain(transfer.to!, request: 'previousPublicKey');
        if (firstTxListRecipient.isNotEmpty) {
          authorizedPublicKeys
              .add(firstTxListRecipient.first.previousPublicKey!);
        }
      }

      for (TokenTransfer transfer in listTokenTransfer) {
        final List<Transaction> firstTxListRecipient = await sl
            .get<ApiService>()
            .getTransactionChain(transfer.to!, request: 'previousPublicKey');
        if (firstTxListRecipient.isNotEmpty) {
          authorizedPublicKeys
              .add(firstTxListRecipient.first.previousPublicKey!);
        }
      }

      final List<AuthorizedKey> authorizedKeys =
          List<AuthorizedKey>.empty(growable: true);
      for (String key in authorizedPublicKeys) {
        authorizedKeys.add(AuthorizedKey(
            encryptedSecretKey: uint8ListToHex(ecEncrypt(aesKey, key)),
            publicKey: key));
      }

      transaction.addOwnership(aesEncrypt(message, aesKey), authorizedKeys);
    }

    TransactionFee transactionFee = TransactionFee();
    transaction
        .build(seed, lastTransaction.chainLength!)
        .originSign(originPrivateKey);
    try {
      transactionFee =
          await sl.get<ApiService>().getTransactionFee(transaction);
    } catch (e) {
      dev.log(e.toString());
    }
    return fromBigInt(transactionFee.fee!).toDouble();
  }

  Future<double> getFeesEstimationCreateToken(String originPrivateKey,
      String seed, Token token, String accountName) async {
    final Keychain keychain = await sl.get<ApiService>().getKeychain(seed);
    String nameEncoded = Uri.encodeFull(accountName);
    final String service = 'archethic-wallet-$nameEncoded';
    final int index = (await sl.get<ApiService>().getTransactionIndex(
            uint8ListToHex(keychain.deriveAddress(service, index: 0))))
        .chainLength!;

    TransactionFee transactionFee = TransactionFee();
    try {
      String content = tokenToJsonForTxDataContent(Token(
          name: token.name,
          supply: token.supply,
          symbol: token.symbol,
          type: token.type,
          tokenProperties: token.tokenProperties));
      final Transaction transaction =
          Transaction(type: 'token', data: Transaction.initData())
              .setContent(content);
      Transaction signedTx = keychain
          .buildTransaction(transaction, service, index)
          .originSign(originPrivateKey);

      transactionFee = await sl.get<ApiService>().getTransactionFee(signedTx);
    } catch (e) {
      dev.log(e.toString());
    }
    return fromBigInt(transactionFee.fee!).toDouble();
  }
}
