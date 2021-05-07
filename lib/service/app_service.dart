// @dart=2.9

import 'dart:async';
import 'package:event_taxi/event_taxi.dart';
import 'package:logger/logger.dart';
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

    Balance balance = new Balance(
        uco: 1340.56,
        nft: new BalanceNft(
            address:
                "05A2525C9C4FDDC02BA97554980A0CFFADA2AEB0650E3EAD05796275F05DDA85",
            amount: 900.00));

    if (activeBus) {
      EventTaxiImpl.singleton().fire(BalanceGetEvent(response: balance));
    }
  }

  Future<void> sendTx(
      String address,
      String amount,
      String destination,
      String openfield,
      String operation,
      String publicKey,
      String privateKey) async {
    SendTxRequest sendTxRequest = new SendTxRequest();
    Tx tx = new Tx();
    //print("address : " + address);
    //print("amount : " + amount);
    //print("destination : " + destination);
    //print("publicKey : " + publicKey);
    //print("privateKey : " + privateKey);

    try {} catch (e) {
      //print("pb socket" + e.toString());
      EventTaxiImpl.singleton().fire(
          ConnStatusEvent(status: ConnectionStatus.DISCONNECTED, server: ""));
    } finally {}
  }
}
