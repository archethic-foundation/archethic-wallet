// Dart imports:
import 'dart:async';

// Project imports:
import 'package:archethic_mobile_wallet/model/recent_transaction.dart';
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

class AppService {
  double getFeesEstimation() {
    const double FEE_BASE = 0.01;
    const double fees = FEE_BASE;
    return fees;
  }

  Future<List<Transaction>> getTransactionChain(
      String address, int? page) async {
    if (page == null) {
      page = 1;
    }
    final List<Transaction> transactionChain =
        await sl.get<ApiService>().getTransactionChain(address, page);
    return transactionChain;
  }

  Future<List<TransactionInput>> getTransactionInputs(String address) async {
    final List<TransactionInput> transactionInputs =
        await sl.get<ApiService>().getTransactionInputs(address);
    return transactionInputs;
  }

  Future<List> getRecentTransactions(
      String genesisAddress, String lastAddress, int page) async {
    final List<Transaction> transactionChain =
        await getTransactionChain(lastAddress, page);
    final List<TransactionInput> transactionInputs =
        await getTransactionInputs(lastAddress);
    final List<TransactionInput> transactionInputsGenesisAddress =
        await getTransactionInputs(genesisAddress);
    final List<RecentTransaction> recentTransactions =
        List<RecentTransaction>.empty(growable: true);

    transactionChain.forEach((transaction) {
      if (transaction.type! == 'nft') {
        RecentTransaction recentTransaction = RecentTransaction();
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
            RecentTransaction recentTransaction = RecentTransaction();
            recentTransaction.typeTx = RecentTransaction.TRANSFER_OUTPUT;
            recentTransaction.amount =
                transaction.data!.ledger!.uco!.transfers![i].amount! /
                    BigInt.from(100000000);
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
    });

    // Transaction inputs for genesisAddress
    transactionInputsGenesisAddress.forEach((transaction) {
      RecentTransaction recentTransaction = RecentTransaction();
      if (transaction.type! == 'NFT') {
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
    });

    transactionInputs.forEach((transaction) {
      if (transaction.spent == true) {
        RecentTransaction recentTransaction = RecentTransaction();
        if (transaction.type! == 'NFT') {
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
    });
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
      transaction.addUCOTransfer(transfer.to, transfer.amount!.toDouble());
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
}
