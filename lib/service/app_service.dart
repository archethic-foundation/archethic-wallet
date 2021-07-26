// @dart=2.9

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show ApiService, Transaction, Balance, UCOTransfer, NftBalance;
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_mobile_wallet/bus/events.dart';
import 'package:archethic_mobile_wallet/network/model/response/address_txs_response.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';

class AppService {
  double getFeesEstimation() {
    const double FEE_BASE = 0.01;
    const double fees = FEE_BASE;

    //print("getFeesEstimation: " + fees.toString());
    return fees;
  }

  Future<void> getAddressTxsResponse(String address, int limit) async {
    final AddressTxsResponse addressTxsResponse = AddressTxsResponse();
    addressTxsResponse.result =
        List<AddressTxsResponseResult>.empty(growable: true);

    const int page = 1;
    final List<Transaction> transactionChain =
        await sl.get<ApiService>().getTransactionChain(address, page);
    EventTaxiImpl.singleton()
        .fire(TransactionsListEvent(transaction: transactionChain));
  }

  Future<void> getBalanceGetResponse(String address, bool activeBus) async {
    Balance balance;
    balance = await sl.get<ApiService>().fetchBalance(address);
    final List<NftBalance> balanceNftList = List<NftBalance>.empty(growable: true);
    for (int i = 0; i < balance.nft.length; i++) {
      NftBalance balanceNft = NftBalance();
      balanceNft = balance.nft[i];
      balanceNftList.add(balanceNft);
    }

    if (activeBus) {
      EventTaxiImpl.singleton().fire(BalanceGetEvent(response: balance));
    }
  }

  Future<void> sendUCO(String originPrivateKey, String transactionChainSeed,
      String address, List<UCOTransfer> listUcoTransfer) async {
    final int txIndex = await sl.get<ApiService>().getTransactionIndex(address);
    final Transaction transaction = Transaction(
        type: 'transfer',
        data: Transaction.initData());
    for (UCOTransfer transfer in listUcoTransfer) {
      transaction.addUCOTransfer(transfer.to, transfer.amount);
    }

    transaction
        .build(transactionChainSeed, txIndex, 'P256')
        .originSign(originPrivateKey);
    try {
      final data = await sl.get<ApiService>().sendTx(transaction);
      if (data.errors) {
        print(data.errors);
      }
    } catch (e) {
      print('error: ' + e);
    }
  }
}
