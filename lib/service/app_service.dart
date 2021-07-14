// @dart=2.9

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:archethic_lib_dart/model/response/balance_response.dart';
import 'package:archethic_lib_dart/services/api_service.dart';
import 'package:archethic_lib_dart/transaction_builder.dart';
import 'package:archethic_lib_dart/utils.dart';
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:archethic_mobile_wallet/bus/events.dart';
import 'package:archethic_mobile_wallet/model/balance.dart' as b;
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

    try {} catch (e) {
      EventTaxiImpl.singleton().fire(
          ConnStatusEvent(status: ConnectionStatus.DISCONNECTED, server: ''));
    } finally {}
  }

  Future<void> getBalanceGetResponse(
      String address, String endpoint, bool activeBus) async {
    BalanceResponse balanceResponse;
    balanceResponse =
        await sl.get<ApiService>().fetchBalance(address, endpoint);
    List<b.BalanceNft> balanceNftList =
        List<b.BalanceNft>.empty(growable: true);
    /*for(int i = 0; i < balanceResponse.data.balance.nft.length; i ++)
    {
        b.BalanceNft balanceNft = new b.BalanceNft();
        balanceNft = balanceResponse.data.balance.nft[i];
    }*/

    b.Balance balance = b.Balance(
        uco: balanceResponse.data.balance.uco, nftList: balanceNftList);

    if (activeBus) {
      EventTaxiImpl.singleton().fire(BalanceGetEvent(response: balance));
    }
  }

  Future<void> sendUCO(
      originPrivateKey,
      String transactionChainSeed,
      String address,
      String endpoint,
      List<UcoTransfer> listUcoTransfer) async {
    int txIndex =
        await sl.get<ApiService>().getTransactionIndex(address, endpoint);
    final TransactionBuilder builder = TransactionBuilder('transfer');
    for (UcoTransfer transfer in listUcoTransfer) {
      builder.addUCOTransfer(transfer.to, transfer.amount);
    }

    final TransactionBuilder tx = builder
        .build(transactionChainSeed, txIndex, 'P256')
        .originSign(originPrivateKey);
    final Map<String, dynamic> transfer = {
      'address': uint8ListToHex(tx.address),
      'data': {
        'legder': {
          'uco': {'transfers': listUcoTransfer}
        }
      }
    };
    final data = await sl.get<ApiService>().sendTx(tx, endpoint);
    if (data.errors) {
      print(data.errors);
    }
  }
}
