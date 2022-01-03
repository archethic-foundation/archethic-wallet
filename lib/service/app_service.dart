// Dart imports:
import 'dart:async';

// Project imports:
import 'package:archethic_mobile_wallet/model/recent_transaction.dart';
import 'package:archethic_mobile_wallet/model/transaction_infos.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show
        ApiService,
        Transaction,
        Balance,
        UCOTransfer,
        NftBalance,
        NFTService,
        TransactionStatus,
        TransactionInput;
import 'package:intl/intl.dart';

class AppService {
  double getFeesEstimation() {
    const double FEE_BASE = 0.01;
    const double fees = FEE_BASE;
    return fees;
  }

  Future<List<Transaction>> getTransactionChain(
      String address, int? page) async {
    page ??= 1;
    final List<Transaction> transactionChain =
        await sl.get<ApiService>().getTransactionChain(address, page);
    return transactionChain;
  }

  Future<List<TransactionInput>> getTransactionInputs(String address) async {
    final List<TransactionInput> transactionInputs =
        await sl.get<ApiService>().getTransactionInputs(address);
    return transactionInputs;
  }

  Future<List<RecentTransaction>> getRecentTransactions(
      String genesisAddress, String lastAddress, int page) async {
    final List<Transaction> transactionChain =
        await getTransactionChain(lastAddress, page);
    final List<TransactionInput> transactionInputs =
        await getTransactionInputs(lastAddress);
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
        if (transaction.data!.contentDisplay!
            .toLowerCase()
            .contains('initial supply:')) {
          recentTransaction.nftAddress = transaction.address;
          recentTransaction.typeTx = RecentTransaction.NFT_CREATION;
          recentTransaction.content = transaction.data!.contentDisplay!
              .substring(transaction.data!.contentDisplay!
                  .toLowerCase()
                  .indexOf('initial supply: '));
        } else {
          recentTransaction.typeTx = RecentTransaction.TRANSFER_OUTPUT;
          recentTransaction.content = '';
        }
        if (transaction.data!.contentDisplay!.toLowerCase().contains('name:')) {
          recentTransaction.nftName = transaction.data!.contentDisplay!
              .substring(transaction.data!.contentDisplay!.indexOf('name: ') +
                  'name: '.length);
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
            recentTransaction.typeTx = RecentTransaction.TRANSFER_OUTPUT;
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
      recentTransaction.typeTx = RecentTransaction.TRANSFER_INPUT;
      recentTransaction.from = transaction.from;
      recentTransaction.recipient = lastAddress;
      recentTransaction.timestamp = transaction.timestamp!;
      recentTransaction.type = 'TransactionInput';
      recentTransaction.fee = 0;
      recentTransactions.add(recentTransaction);
    }

    for (TransactionInput transaction in transactionInputs) {
      if (transaction.spent == true) {
        final RecentTransaction recentTransaction = RecentTransaction();
        recentTransaction.address = transaction.from;
        if (transaction.type!.toUpperCase() == 'NFT') {
          recentTransaction.nftAddress = transaction.nftAddress!;
        } else {
          recentTransaction.nftAddress = '';
        }
        recentTransaction.amount = transaction.amount!;
        recentTransaction.typeTx = RecentTransaction.TRANSFER_INPUT;
        recentTransaction.from = transaction.from;
        recentTransaction.recipient = lastAddress;
        recentTransaction.timestamp = transaction.timestamp!;
        recentTransaction.type = 'TransactionInput';
        recentTransaction.fee = 0;
        recentTransactions.add(recentTransaction);
      }
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
        .build(transactionChainSeed, lastTransaction.chainLength!, 'P256')
        .originSign(originPrivateKey);
    try {
      transactionStatus = await sl.get<ApiService>().sendTx(transaction);
    } catch (e) {
      print('error: ' + e.toString());
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
        'P256',
        originPrivateKey);
    try {
      transactionStatus = await sl.get<ApiService>().sendTx(transaction);
    } catch (e) {
      print('error: ' + e.toString());
      transactionStatus.status = e.toString();
    }

    return transactionStatus;
  }

  Future<List<TransactionInfos>> getTransactionAllInfos(
      String address, DateFormat dateFormat) async {
    List<TransactionInfos> transactionsInfos =
        List<TransactionInfos>.empty(growable: true);

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
    if (transaction.version != null) {
      transactionsInfos.add(TransactionInfos(
          domain: '',
          titleInfo: 'Version',
          valueInfo: transaction.version!.toString()));
    }
    if (transaction.previousPublicKey != null) {
      transactionsInfos.add(TransactionInfos(
          domain: '',
          titleInfo: 'PreviousPublicKey',
          valueInfo: transaction.previousPublicKey!));
    }
    if (transaction.previousSignature != null) {
      transactionsInfos.add(TransactionInfos(
          domain: '',
          titleInfo: 'PreviousSignature',
          valueInfo: transaction.previousSignature!));
    }
    if (transaction.originSignature != null) {
      transactionsInfos.add(TransactionInfos(
          domain: '',
          titleInfo: 'OriginSignature',
          valueInfo: transaction.originSignature!));
    }
    if (transaction.data != null) {
      transactionsInfos
          .add(TransactionInfos(domain: 'Data', titleInfo: '', valueInfo: ''));
      if (transaction.data!.content != null) {
        transactionsInfos.add(TransactionInfos(
            domain: 'Data',
            titleInfo: 'Content',
            valueInfo: transaction.data!.contentDisplay == ''
                ? 'N/A'
                : transaction.data!.contentDisplay!));
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
          transaction.data!.ledger!.uco!.transfers!.length > 0) {
        transactionsInfos.add(TransactionInfos(
            domain: 'UCOLedger', titleInfo: '', valueInfo: ''));
        for (int i = 0;
            i < transaction.data!.ledger!.uco!.transfers!.length;
            i++) {
          if (transaction.data!.ledger!.uco!.transfers![i].to != null) {
            transactionsInfos.add(TransactionInfos(
                domain: 'UCOLedger',
                titleInfo: 'To',
                valueInfo: transaction.data!.ledger!.uco!.transfers![i].to!));
          }
          if (transaction.data!.ledger!.uco!.transfers![i].amount != null) {
            transactionsInfos.add(TransactionInfos(
                domain: 'UCOLedger',
                titleInfo: 'Amount',
                valueInfo:
                    (transaction.data!.ledger!.uco!.transfers![i].amount! /
                                BigInt.from(100000000))
                            .toString() +
                        ' UCO'));
          }
        }
      }
      if (transaction.data!.ledger != null &&
          transaction.data!.ledger!.nft != null &&
          transaction.data!.ledger!.nft!.transfers != null &&
          transaction.data!.ledger!.nft!.transfers!.length > 0) {
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
    if (transaction.validationStamp != null) {
      transactionsInfos.add(TransactionInfos(
          domain: 'ValidationStamp', titleInfo: '', valueInfo: ''));
      if (transaction.validationStamp!.proofOfWork != null) {
        transactionsInfos.add(TransactionInfos(
            domain: 'ValidationStamp',
            titleInfo: 'ProofOfWork',
            valueInfo: transaction.validationStamp!.proofOfWork!));
      }
      if (transaction.validationStamp!.proofOfIntegrity != null) {
        transactionsInfos.add(TransactionInfos(
            domain: 'ValidationStamp',
            titleInfo: 'ProofOfIntegrity',
            valueInfo: transaction.validationStamp!.proofOfIntegrity!));
      }
      if (transaction.validationStamp!.timestamp != null) {
        transactionsInfos.add(TransactionInfos(
            domain: 'ValidationStamp',
            titleInfo: 'TimeStamp',
            valueInfo: dateFormat
                .add_Hms()
                .format(DateTime.fromMillisecondsSinceEpoch(
                        transaction.validationStamp!.timestamp! * 1000)
                    .toLocal())
                .toString()));
      }
    }
    if (transaction.crossValidationStamps != null) {
      transactionsInfos.add(TransactionInfos(
          domain: 'CrossValidationStamps', titleInfo: '', valueInfo: ''));
      for (int i = 0; i < transaction.crossValidationStamps!.length; i++) {
        if (transaction.crossValidationStamps![i].signature != null) {
          transactionsInfos.add(TransactionInfos(
              domain: 'CrossValidationStamps',
              titleInfo: 'Signature',
              valueInfo: transaction.crossValidationStamps![i].signature!));
        }
      }
    }
    return transactionsInfos;
  }
}
