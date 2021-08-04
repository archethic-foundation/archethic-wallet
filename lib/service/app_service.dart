// Dart imports:
import 'dart:async';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show
        ApiService,
        Transaction,
        Balance,
        UCOTransfer,
        NftBalance,
        NFTService,
        TransactionStatus;

// Project imports:
import 'package:archethic_mobile_wallet/service_locator.dart';

class AppService {
  double getFeesEstimation() {
    const double FEE_BASE = 0.01;
    const double fees = FEE_BASE;
    return fees;
  }

  Future<List<Transaction>> getTransactionChain(String address) async {
    const int page = 1;
    final List<Transaction> transactionChain =
        await sl.get<ApiService>().getTransactionChain(address, page);
    return transactionChain;
  }

  Future<Balance> getBalanceGetResponse(String address) async {
    Balance balance =
        Balance(uco: 0, nft: List<NftBalance>.empty(growable: true));
    balance = await sl.get<ApiService>().fetchBalance(address);
    final List<NftBalance> balanceNftList =
        List<NftBalance>.empty(growable: true);
    if (balance != null && balance.nft != null) {
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
    TransactionStatus transactionStatus = new TransactionStatus();
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
    TransactionStatus transactionStatus = new TransactionStatus();
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
