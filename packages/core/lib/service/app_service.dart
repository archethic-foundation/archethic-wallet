/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';
import 'dart:developer' as dev;

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/contact.dart';
import 'package:core/model/data/recent_transaction.dart';
import 'package:core/model/transaction_infos.dart';
import 'package:core/util/get_it_instance.dart';

import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show
        uint8ListToHex,
        ApiService,
        Transaction,
        Balance,
        Keychain,
        UCOTransfer,
        TokenBalance,
        TransactionStatus,
        TransactionInput,
        TransactionFee;

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
      String serviceName = 'archethic-wallet-$name';
      pagingAddress = uint8ListToHex(keychain.deriveAddress(serviceName,
          index: lastTransaction.chainLength! - 10));
    }

    final List<Transaction> transactionChain = await getTransactionChain(
        lastAddress,
        pagingAddress,
        'address, type, validationStamp { timestamp, ledgerOperations { fee } }, data { content , ledger { uco { transfers { amount, to } } } }, inputs { from, type, spent, tokenAddress, amount, timestamp } ');

    final List<TransactionInput> transactionInputsGenesisAddress =
        await getTransactionInputs(genesisAddress,
            'from, type, spent, tokenAddress, amount, timestamp');

    final List<RecentTransaction> recentTransactions =
        List<RecentTransaction>.empty(growable: true);

    for (Transaction transaction in transactionChain) {
      String content = transaction.data!.content!.toLowerCase();
      if (transaction.type!.toUpperCase() == 'Token') {
        final RecentTransaction recentTransaction = RecentTransaction();
        recentTransaction.address = transaction.address;
        recentTransaction.fee = 0;
        recentTransaction.timestamp = transaction.validationStamp!.timestamp!;

        if (content.contains('initial supply:')) {
          recentTransaction.tokenAddress = transaction.address;
          recentTransaction.typeTx = RecentTransaction.tokenCreation;
          recentTransaction.content = content
              .substring(content.toLowerCase().indexOf('initial supply: '));
        } else {
          recentTransaction.typeTx = RecentTransaction.transferOutput;
          recentTransaction.content = '';
        }
        if (content.contains('name:')) {
          recentTransaction.tokenName =
              content.substring(content.indexOf('name: ') + 'name: '.length);
        } else {
          recentTransaction.tokenName = '';
        }
        recentTransaction.fee =
            transaction.validationStamp!.ledgerOperations!.fee;
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
            recentTransaction.amount = transaction
                    .data!.ledger!.uco!.transfers![i].amount!
                    .toDouble() /
                100000000;
            recentTransaction.recipient =
                transaction.data!.ledger!.uco!.transfers![i].to!;
            recentTransaction.fee =
                transaction.validationStamp!.ledgerOperations!.fee;
            recentTransaction.timestamp =
                transaction.validationStamp!.timestamp!;
            recentTransaction.from = lastAddress;
            recentTransactions.add(recentTransaction);
          }
        }
      }

      if (transaction.inputs != null) {
        for (TransactionInput transactionInput in transaction.inputs!) {
          if (transactionInput.from != transaction.address) {
            final RecentTransaction recentTransaction = RecentTransaction();
            recentTransaction.address = transactionInput.from;
            if (transactionInput.type!.toUpperCase() == 'Token') {
              recentTransaction.tokenAddress = transactionInput.tokenAddress!;
            } else {
              recentTransaction.tokenAddress = '';
            }
            recentTransaction.amount = transactionInput.amount!;
            recentTransaction.typeTx = RecentTransaction.transferInput;
            recentTransaction.from = transactionInput.from;
            recentTransaction.recipient = transaction.address;
            recentTransaction.timestamp = transactionInput.timestamp!;
            recentTransaction.type = 'TransactionInput';
            recentTransaction.fee = 0;
            recentTransactions.add(recentTransaction);
          }
        }
      }
    }

    // Transaction inputs for genesisAddress
    for (TransactionInput transaction in transactionInputsGenesisAddress) {
      final RecentTransaction recentTransaction = RecentTransaction();
      recentTransaction.address = transaction.from;
      if (transaction.type!.toUpperCase() == 'Token') {
        recentTransaction.tokenAddress = transaction.tokenAddress!;
      } else {
        recentTransaction.tokenAddress = '';
      }
      recentTransaction.amount = transaction.amount!;
      recentTransaction.typeTx = RecentTransaction.transferInput;
      recentTransaction.from = transaction.from;
      recentTransaction.recipient = lastAddress;
      recentTransaction.timestamp = transaction.timestamp!;
      recentTransaction.type = 'TransactionInput';
      recentTransaction.fee = 0;
      recentTransactions.add(recentTransaction);
    }

    // Sort by date (desc)
    recentTransactions.sort((RecentTransaction a, RecentTransaction b) =>
        a.timestamp!.compareTo(b.timestamp!));

    for (int i = 0; i < recentTransactions.length; i++) {
      if (i <= 3) {
        recentTransactions[i].content = await sl
            .get<ApiService>()
            .getTransactionContent(recentTransactions[i].address!);
      }
    }

    return recentTransactions.reversed.toList();
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

  Future<TransactionStatus> sendUCO(
      String originPrivateKey,
      String seed,
      String address,
      List<UCOTransfer> listUcoTransfer,
      String accountName) async {
    TransactionStatus transactionStatus = TransactionStatus();

    try {
      final Keychain keychain = await sl.get<ApiService>().getKeychain(seed);
      final String service = 'archethic-wallet-$accountName';
      final int index = (await sl.get<ApiService>().getTransactionIndex(
              uint8ListToHex(keychain.deriveAddress(service, index: 0))))
          .chainLength!;

      final Transaction transaction =
          Transaction(type: 'transfer', data: Transaction.initData());
      for (UCOTransfer transfer in listUcoTransfer) {
        transaction.addUCOTransfer(transfer.to, transfer.amount!);
      }

      Transaction signedTx = keychain
          .buildTransaction(transaction, service, index)
          .originSign(originPrivateKey);

      transactionStatus = await sl.get<ApiService>().sendTx(signedTx);
    } catch (e) {
      dev.log(e.toString());
      transactionStatus.status = e.toString();
    }
    return transactionStatus;
  }

  Future<TransactionStatus> addToken(
      String originPrivateKey,
      String seed,
      String address,
      String name,
      int initialSupply,
      String accountName) async {
    final Keychain keychain = await sl.get<ApiService>().getKeychain(seed);
    final String service = 'archethic-wallet-$accountName';
    final int index = (await sl.get<ApiService>().getTransactionIndex(
            uint8ListToHex(keychain.deriveAddress(service, index: 0))))
        .chainLength!;

    TransactionStatus transactionStatus = TransactionStatus();

    try {
      String content = 'initial supply: $initialSupply\nname: $name';
      final Transaction transaction =
          Transaction(type: 'token', data: Transaction.initData())
              .setContent(content);
      Transaction signedTx = keychain
          .buildTransaction(transaction, service, index)
          .originSign(originPrivateKey);

      transactionStatus = await sl.get<ApiService>().sendTx(signedTx);
    } catch (e) {
      dev.log(e.toString());
      transactionStatus.status = e.toString();
    }

    return transactionStatus;
  }

  Future<List<TransactionInfos>> getTransactionAllInfos(
      String address, DateFormat dateFormat, String cryptoCurrency) async {
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
              recipientContactName = contact.name!;
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
                    '${transaction.data!.ledger!.uco!.transfers![i].amount! / BigInt.from(100000000)} $cryptoCurrency'));
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
            transactionsInfos.add(TransactionInfos(
                domain: 'TokenLedger',
                titleInfo: 'Amount',
                valueInfo:
                    (transaction.data!.ledger!.token!.transfers![i].amount!)
                        .toString()));
          }
        }
      }
    }
    return transactionsInfos;
  }

  Future<double> getFeesEstimationUCO(
      String originPrivateKey,
      String transactionChainSeed,
      String address,
      List<UCOTransfer> listUcoTransfer,
      String content) async {
    final Transaction lastTransaction = await sl
        .get<ApiService>()
        .getLastTransaction(address, request: 'chainLength');
    final Transaction transaction =
        Transaction(type: 'transfer', data: Transaction.initData());
    for (UCOTransfer transfer in listUcoTransfer) {
      transaction.addUCOTransfer(transfer.to, transfer.amount!);
    }
    transaction.setContent(content);
    TransactionFee transactionFee = TransactionFee();
    transaction
        .build(transactionChainSeed, lastTransaction.chainLength!)
        .originSign(originPrivateKey);
    try {
      transactionFee =
          await sl.get<ApiService>().getTransactionFee(transaction);
    } catch (e) {
      dev.log(e.toString());
    }
    return transactionFee.fee!;
  }

  Future<double> getFeesEstimationAddToken(
      String originPrivateKey,
      String seed,
      String address,
      String name,
      int initialSupply,
      String accountName) async {
    final Keychain keychain = await sl.get<ApiService>().getKeychain(seed);
    final String service = 'archethic-wallet-$accountName';
    final int index = (await sl.get<ApiService>().getTransactionIndex(
            uint8ListToHex(keychain.deriveAddress(service, index: 0))))
        .chainLength!;

    TransactionFee transactionFee = TransactionFee();
    try {
      String content = 'initial supply: $initialSupply\nname: $name';
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
    return transactionFee.fee!;
  }
}
