// @dart=2.9

import 'dart:async';
import 'package:event_taxi/event_taxi.dart';
import 'package:logger/logger.dart';
import 'package:uniris_lib_dart/api.dart';
import 'package:uniris_lib_dart/transaction_builder.dart';
import 'package:uniris_lib_dart/utils.dart';
import 'package:uniris_mobile_wallet/bus/events.dart';
import 'package:uniris_mobile_wallet/model/balance.dart';
import 'package:uniris_mobile_wallet/network/model/request/send_tx_request.dart';
import 'package:uniris_mobile_wallet/network/model/response/address_txs_response.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';

class AppService {
  final Logger log = sl.get<Logger>();

  // Lock instance for synchronization
  String allMessages = "";

  String getLengthBuffer(String message) {
    return message == null ? null : message.length.toString().padLeft(10, '0');
  }

  double getFeesEstimation() {
    const double FEE_BASE = 0.01;
    double fees = FEE_BASE;

    //print("getFeesEstimation: " + fees.toString());
    return fees;
  }

  Future<void> getAddressTxsResponse(String address, int limit) async {
    AddressTxsResponse addressTxsResponse = new AddressTxsResponse();
    addressTxsResponse.result = new List<AddressTxsResponseResult>();

    try {} catch (e) {
      EventTaxiImpl.singleton().fire(
          ConnStatusEvent(status: ConnectionStatus.DISCONNECTED, server: ""));
    } finally {}
  }

  Future<void> getBalanceGetResponse(
      String address, String endpoint, bool activeBus) async {
    /*BalanceResponse balanceResponse;
    balanceResponse = await fetchBalance(address, endpoint);

    BalanceNft balanceNft = new BalanceNft(address: balanceResponse.nft.address, amount: balanceResponse.nft.amount);
    Balance balance = new Balance(uco: balanceResponse.uco, nft: balanceNft);
    */

    List<BalanceNft> balanceNftList =
        new List<BalanceNft>.empty(growable: true);
    balanceNftList.add(new BalanceNft(
        name: "my Token 1",
        address:
            "00b9b052ef7e162a96c18c55272da7abccf72ebd2351dce66663e2962ef6b68d23",
        amount: 900.00));
    balanceNftList.add(new BalanceNft(
        name: "my Token 2",
        address:
            "2da7abccf72ebd2351dce666636c18c5527e2962ef6b68d2300b9b052ef7e162a9",
        amount: 1204.00));
    balanceNftList.add(new BalanceNft(
        name: "my Token 3",
        address:
            "6c18c55272d52ef7e162a9a7abccf72ebd2351dce66663e2962ef6b68d2300b9b0",
        amount: 1.00));
    balanceNftList.add(new BalanceNft(
        name: "my Token 4",
        address:
            "da7abccf72ebd2351dce66663e2962ef6b6c18c5527268d2300b9b052ef7e162a9",
        amount: 5667432.00));
    Balance balance = new Balance(uco: 1340.56, nftList: balanceNftList);

    if (activeBus) {
      EventTaxiImpl.singleton().fire(BalanceGetEvent(response: balance));
    }
  }

  void sendUCO(originPrivateKey, String transactionChainSeed, String address,
      String endpoint, List<UcoTransfer> listUcoTransfer) {
    var txIndex = getTransactionIndex(address, endpoint);
    TransactionBuilder builder = new TransactionBuilder("transfer");
    listUcoTransfer.forEach(
        (transfer) => builder.addUCOTransfer(transfer.to, transfer.amount));

    TransactionBuilder tx = builder
        .build(transactionChainSeed, txIndex)
        .originSign(originPrivateKey);
    Map<String, dynamic> transfer = {
      'address': uint8ListToHex(tx.address),
      'timestamp': tx.timestamp,
      'data': {
        'legder': {
          'uco': {'transfers': listUcoTransfer}
        }
      }
    };
    var data = sendTx(tx, endpoint);
    if (data.errors) {
      print(data.errors);
    }
  }
}
