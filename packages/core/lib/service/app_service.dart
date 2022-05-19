/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';
import 'dart:developer' as dev;

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/model/recent_transaction.dart';
import 'package:core/model/transaction_infos.dart';
import 'package:core/util/get_it_instance.dart';

import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show
        ApiService,
        Transaction,
        Balance,
        UCOTransfer,
        NftBalance,
        NFTService,
        TransactionStatus,
        TransactionInput,
        TransactionFee;

class AppService {
  Future<List<Transaction>> getTransactionChain(
      String address, String? pagingAddress) async {
    pagingAddress ??= '';
    final List<Transaction> transactionChain = await sl
        .get<ApiService>()
        .getTransactionChain(address, pagingAddress: pagingAddress);
    return transactionChain;
  }

  Future<List<TransactionInput>> getTransactionInputs(String address) async {
    final List<TransactionInput> transactionInputs =
        await sl.get<ApiService>().getTransactionInputs(address);
    return transactionInputs;
  }

  Future<List<RecentTransaction>> getRecentTransactions(
      String genesisAddress, String lastAddress, String? pagingAddress) async {
    pagingAddress ??= '';
    final List<Transaction> transactionChain =
        await getTransactionChain(lastAddress, pagingAddress);
    final List<TransactionInput> transactionInputsGenesisAddress =
        await getTransactionInputs(genesisAddress);
    final List<RecentTransaction> recentTransactions =
        List<RecentTransaction>.empty(growable: true);

    for (Transaction transaction in transactionChain) {
      if (transaction.type!.toUpperCase() == 'NFT') {
        final RecentTransaction recentTransaction = RecentTransaction();
        recentTransaction.address = transaction.address;
        recentTransaction.fee = 0;
        recentTransaction.timestamp = transaction.validationStamp!.timestamp!;
        if (transaction.data!.content!
            .toLowerCase()
            .contains('initial supply:')) {
          recentTransaction.nftAddress = transaction.address;
          recentTransaction.typeTx = RecentTransaction.nftCreation;
          recentTransaction.content = transaction.data!.content!.substring(
              transaction.data!.content!
                  .toLowerCase()
                  .indexOf('initial supply: '));
        } else {
          recentTransaction.typeTx = RecentTransaction.transferOutput;
          recentTransaction.content = '';
        }
        if (transaction.data!.content!.toLowerCase().contains('name:')) {
          recentTransaction.nftName = transaction.data!.content!.substring(
              transaction.data!.content!.indexOf('name: ') + 'name: '.length);
        } else {
          recentTransaction.nftName = '';
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

      for (TransactionInput transactionInput in transaction.inputs!) {
        if (transactionInput.from != transaction.address) {
          final RecentTransaction recentTransaction = RecentTransaction();
          recentTransaction.address = transactionInput.from;
          if (transactionInput.type!.toUpperCase() == 'NFT') {
            recentTransaction.nftAddress = transactionInput.nftAddress!;
          } else {
            recentTransaction.nftAddress = '';
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

    // Transaction inputs for genesisAddress
    for (TransactionInput transaction in transactionInputsGenesisAddress) {
      final RecentTransaction recentTransaction = RecentTransaction();
      recentTransaction.address = transaction.from;
      if (transaction.type!.toUpperCase() == 'NFT') {
        recentTransaction.nftAddress = transaction.nftAddress!;
      } else {
        recentTransaction.nftAddress = '';
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

    return recentTransactions.reversed.toList();
  }

  Future<Balance> getBalanceGetResponse(String address) async {
    Balance balance =
        Balance(uco: 0, nft: List<NftBalance>.empty(growable: true));
    balance = await sl.get<ApiService>().fetchBalance(address);
    final List<NftBalance> balanceNftList =
        List<NftBalance>.empty(growable: true);
    if (balance.nft != null) {
      for (int i = 0; i < balance.nft!.length; i++) {
        NftBalance balanceNft = NftBalance();
        balanceNft = balance.nft![i];
        balanceNftList.add(balanceNft);
      }
    }
    return balance;
  }

  Future<TransactionStatus> sendUCO(
      String originPrivateKey,
      String transactionChainSeed,
      String address,
      List<UCOTransfer> listUcoTransfer) async {
    final Transaction lastTransaction =
        await sl.get<ApiService>().getLastTransaction(address);
    final Transaction transaction =
        Transaction(type: 'transfer', data: Transaction.initData());
    for (UCOTransfer transfer in listUcoTransfer) {
      transaction.addUCOTransfer(transfer.to, transfer.amount!);
    }
    TransactionStatus transactionStatus = TransactionStatus();
    transaction
        .build(transactionChainSeed, lastTransaction.chainLength!)
        .originSign(originPrivateKey);
    try {
      transactionStatus = await sl.get<ApiService>().sendTx(transaction);
    } catch (e) {
      dev.log(e.toString());
      transactionStatus.status = e.toString();
    }
    return transactionStatus;
  }

  Future<TransactionStatus> addNFT(
      String originPrivateKey,
      String transactionChainSeed,
      String address,
      String name,
      int initialSupply) async {
    TransactionStatus transactionStatus = TransactionStatus();
    final Transaction lastTransaction =
        await sl.get<ApiService>().getLastTransaction(address);
    final Transaction transaction = NFTService().prepareNewNFT(
        initialSupply,
        name,
        transactionChainSeed,
        lastTransaction.chainLength!,
        originPrivateKey);
    try {
      transactionStatus = await sl.get<ApiService>().sendTx(transaction);
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
            String _recipientContactName = '';
            try {
              Contact _contact = await sl.get<DBHelper>().getContactWithAddress(
                  transaction.data!.ledger!.uco!.transfers![i].to!);
              _recipientContactName = _contact.name!;
            } catch (e) {}

            if (_recipientContactName.isEmpty) {
              transactionsInfos.add(TransactionInfos(
                  domain: 'UCOLedger',
                  titleInfo: 'To',
                  valueInfo: transaction.data!.ledger!.uco!.transfers![i].to!));
            } else {
              transactionsInfos.add(TransactionInfos(
                  domain: 'UCOLedger',
                  titleInfo: 'To',
                  valueInfo: _recipientContactName +
                      '\n' +
                      transaction.data!.ledger!.uco!.transfers![i].to!));
            }
          }
          if (transaction.data!.ledger!.uco!.transfers![i].amount != null) {
            transactionsInfos.add(TransactionInfos(
                domain: 'UCOLedger',
                titleInfo: 'Amount',
                valueInfo:
                    (transaction.data!.ledger!.uco!.transfers![i].amount! /
                                BigInt.from(100000000))
                            .toString() +
                        ' ' +
                        cryptoCurrency));
          }
        }
      }
      if (transaction.data!.ledger != null &&
          transaction.data!.ledger!.nft != null &&
          transaction.data!.ledger!.nft!.transfers != null &&
          transaction.data!.ledger!.nft!.transfers!.isNotEmpty) {
        transactionsInfos.add(TransactionInfos(
            domain: 'NFTLedger', titleInfo: '', valueInfo: ''));
        for (int i = 0;
            i < transaction.data!.ledger!.nft!.transfers!.length;
            i++) {
          if (transaction.data!.ledger!.nft!.transfers![i].nft != null) {
            transactionsInfos.add(TransactionInfos(
                domain: 'NFTLedger',
                titleInfo: 'Nft',
                valueInfo: transaction.data!.ledger!.nft!.transfers![i].nft!));
          }
          if (transaction.data!.ledger!.nft!.transfers![i].to != null) {
            transactionsInfos.add(TransactionInfos(
                domain: 'NFTLedger',
                titleInfo: 'To',
                valueInfo: transaction.data!.ledger!.nft!.transfers![i].to!));
          }
          if (transaction.data!.ledger!.nft!.transfers![i].amount != null) {
            transactionsInfos.add(TransactionInfos(
                domain: 'NFTLedger',
                titleInfo: 'Amount',
                valueInfo:
                    (transaction.data!.ledger!.nft!.transfers![i].amount!)
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
      List<UCOTransfer> listUcoTransfer) async {
    final Transaction lastTransaction =
        await sl.get<ApiService>().getLastTransaction(address);
    final Transaction transaction =
        Transaction(type: 'transfer', data: Transaction.initData());
    for (UCOTransfer transfer in listUcoTransfer) {
      transaction.addUCOTransfer(transfer.to, transfer.amount!);
    }
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

  Future<double> getFeesEstimationAddNFT(
      String originPrivateKey,
      String transactionChainSeed,
      String address,
      String name,
      int initialSupply) async {
    final Transaction lastTransaction =
        await sl.get<ApiService>().getLastTransaction(address);

    final Transaction transaction = NFTService().prepareNewNFT(
        initialSupply,
        name,
        transactionChainSeed,
        lastTransaction.chainLength!,
        originPrivateKey);

    TransactionFee transactionFee = TransactionFee();
    try {
      transactionFee =
          await sl.get<ApiService>().getTransactionFee(transaction);
    } catch (e) {
      dev.log(e.toString());
    }
    return transactionFee.fee!;
  }
}
