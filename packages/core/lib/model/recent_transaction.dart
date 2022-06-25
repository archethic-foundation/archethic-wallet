/// SPDX-License-Identifier: AGPL-3.0-or-later

// Project imports:
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/get_it_instance.dart';

/// [TransactionInput] represents the inputs from the transaction.

class RecentTransaction {
  RecentTransaction({
    this.address,
    this.typeTx,
    this.amount,
    this.recipient,
    this.from,
    this.fee,
    this.tokenName,
    this.tokenAddress,
    this.content,
    this.timestamp,
    this.type,
  });

  factory RecentTransaction.fromJson(Map<String, dynamic> json) =>
      RecentTransaction(
        address: json['address'],
        typeTx: json['typeTx']?.toInt(),
        recipient: json['recipient'],
        amount: json['amount']?.toDouble(),
        fee: json['fee']?.toDouble(),
        from: json['from'],
        tokenAddress: json['tokenAddress'],
        tokenName: json['tokenName'],
        content: json['content'],
        timestamp: json['timestamp'],
        type: json['type'],
      );

  /// Types of transaction
  static const int transferInput = 1;
  static const int transferOutput = 2;
  static const int tokenCreation = 3;

  /// Address of transaction
  String? address;

  /// Type of transaction : 1=Transfer/Input, 2=Transfer/Output, 3=Token creation
  int? typeTx;

  /// Amount: asset amount
  double? amount;

  /// Recipients: For non asset transfers, the list of recipients of the transaction (e.g Smart contract interactions)
  String? recipient;
  Future<String> getRecipientContactName() async {
    String _recipientContactName = '';
    if (recipient != null) {
      Contact? _contact =
          await sl.get<DBHelper>().getContactWithAddress(recipient!);
      if (_contact != null) {
        _recipientContactName = _contact.name!;
      }
    }

    return _recipientContactName;
  }

  Future<String> get recipientDisplay async {
    String _recipientDisplay = await getRecipientContactName();
    if (_recipientDisplay != '') {
      return _recipientDisplay;
    } else {
      if (recipient != null) {
        return recipient!;
      } else {
        return '';
      }
    }
  }

  /// Timestamp: Date time when the transaction was generated
  int? timestamp;

  /// Fee: transaction fee (distributed over the node rewards)
  double? fee;

  /// From: transaction which send the amount of assets
  String? from;

  /// Token name: name of the Token if the type is Token
  String? tokenName;

  /// Token address: address of the Token if the type is Token
  String? tokenAddress;

  /// Content: free zone for data hosting (string or hexadecimal)
  String? content;

  /// Type: UCO/tokens/Call
  String? type;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'typeTx': typeTx,
        'recipient': recipient,
        'amount': amount,
        'fee': fee,
        'from': from,
        'tokenAddress': tokenAddress,
        'tokenName': tokenName,
        'content': content,
        'timestamp': timestamp,
        'type': type,
      };
}
