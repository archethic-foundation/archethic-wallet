// @dart=2.9

import 'dart:async';
import 'package:event_taxi/event_taxi.dart';
import 'package:uniris_lib_dart/api.dart';
import 'package:uniris_lib_dart/transaction_builder.dart';
import 'package:uniris_lib_dart/utils.dart';
import 'package:uniris_mobile_wallet/bus/events.dart';
import 'package:uniris_mobile_wallet/model/balance.dart';
import 'package:uniris_mobile_wallet/network/model/response/address_txs_response.dart';

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
    /*BalanceResponse balanceResponse;
    balanceResponse = await fetchBalance(address, endpoint);

    BalanceNft balanceNft = BalanceNft(address: balanceResponse.nft.address, amount: balanceResponse.nft.amount);
    Balance balance = Balance(uco: balanceResponse.uco, nft: balanceNft);
    */

    final List<BalanceNft> balanceNftList =
        List<BalanceNft>.empty(growable: true);
    balanceNftList.add(BalanceNft(
        name: 'my Token 1',
        address:
            '00b9b052ef7e162a96c18c55272da7abccf72ebd2351dce66663e2962ef6b68d23',
        amount: 900));
    balanceNftList.add(BalanceNft(
        name: 'my Token 2',
        address:
            '2da7abccf72ebd2351dce666636c18c5527e2962ef6b68d2300b9b052ef7e162a9',
        amount: 1204));
    balanceNftList.add(BalanceNft(
        name: 'my Token 3',
        address:
            '6c18c55272d52ef7e162a9a7abccf72ebd2351dce66663e2962ef6b68d2300b9b0',
        amount: 1));
    balanceNftList.add(BalanceNft(
        name: 'my Token 4',
        address:
            'da7abccf72ebd2351dce66663e2962ef6b6c18c5527268d2300b9b052ef7e162a9',
        amount: 5667432));
    final Balance balance = Balance(uco: 1340.56, nftList: balanceNftList);

    // TODO
    /*
    for (int i = 0; i < balance.nftList.length; i++) {
      TransactionResponse transactionResponse =
          await getTransactionContent(balance.nftList[i].address, endpoint);
      String content = transactionResponse.data.content;

      balance.nftList[i].name = BalanceNft.getName(content);
    }*/

    if (activeBus) {
      EventTaxiImpl.singleton().fire(BalanceGetEvent(response: balance));
    }
  }

  void sendUCO(originPrivateKey, String transactionChainSeed, String address,
      String endpoint, List<UcoTransfer> listUcoTransfer) {
    final txIndex = getTransactionIndex(address, endpoint);
    final TransactionBuilder builder = TransactionBuilder('transfer');
    for (UcoTransfer transfer in listUcoTransfer) {
      builder.addUCOTransfer(transfer.to, transfer.amount);
    }

    final TransactionBuilder tx = builder
        .build(transactionChainSeed, txIndex)
        .originSign(originPrivateKey);
    final Map<String, dynamic> transfer = {
      'address': uint8ListToHex(tx.address),
      'timestamp': tx.timestamp,
      'data': {
        'legder': {
          'uco': {'transfers': listUcoTransfer}
        }
      }
    };
    final data = sendTx(tx, endpoint);
    if (data.errors) {
      print(data.errors);
    }
  }
}
