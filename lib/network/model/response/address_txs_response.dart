// To parse this JSON data, do
//
//     final addressTxsResponse = addressTxsResponseFromJson(jsonString);

// @dart=2.9

import 'package:uniris_mobile_wallet/model/address.dart';
import 'package:uniris_mobile_wallet/network/model/block_types.dart';
import 'package:uniris_mobile_wallet/util/numberutil.dart';

class AddressTxsResponse {
  AddressTxsResponse({this.result});

  List<AddressTxsResponseResult> result;
}

class AddressTxsResponseResult {
  AddressTxsResponseResult(
      {this.blockHeight,
      this.timestamp,
      this.from,
      this.recipient,
      this.amount,
      this.signature,
      this.publicKey,
      this.blockHash,
      this.fee,
      this.reward,
      this.type,
      this.hash});

  int blockHeight;
  DateTime timestamp;
  String from;
  String recipient;
  String amount;
  String signature;
  String publicKey;
  String blockHash;
  double fee;
  int reward;
  String type;
  String hash;

  String getShortString() {
    if (type == BlockTypes.RECEIVE) {
      return Address(from).getShortString();
    } else {
      return Address(recipient).getShortString();
    }
  }

  String getShorterString() {
    if (type == BlockTypes.RECEIVE) {
      return Address(from).getShorterString();
    } else {
      return Address(recipient).getShorterString();
    }
  }

  /*
   * Return amount formatted for use in the UI
   */
  String getFormattedAmount() {
    return NumberUtil.getRawAsUsableString(amount.toString());
  }
}
