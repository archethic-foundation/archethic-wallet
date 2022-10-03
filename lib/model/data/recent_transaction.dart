/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/util/get_it_instance.dart';

part 'recent_transaction.g.dart';

/// [TransactionInput] represents the inputs from the transaction.

@HiveType(typeId: 6)
class RecentTransaction extends HiveObject {
  RecentTransaction({
    this.address,
    this.typeTx,
    this.amount,
    this.recipient,
    this.from,
    this.fee,
    this.content,
    this.timestamp,
    this.type,
    this.decryptedSecret,
  });

  factory RecentTransaction.fromJson(Map<String, dynamic> json) =>
      RecentTransaction(
        address: json['address'],
        typeTx: json['typeTx']?.toInt(),
        recipient: json['recipient'],
        amount: json['amount']?.toDouble(),
        fee: json['fee']?.toDouble(),
        from: json['from'],
        content: json['content'],
        timestamp: json['timestamp'],
        type: json['type'],
        decryptedSecret: json['decryptedSecret'],
      );

  /// Types of transaction
  static const int transferInput = 1;
  static const int transferOutput = 2;
  static const int tokenCreation = 3;

  /// Address of transaction
  @HiveField(0)
  String? address;

  /// Type of transaction : 1=Transfer/Input, 2=Transfer/Output, 3=Token creation
  @HiveField(1)
  int? typeTx;

  /// Amount: asset amount
  @HiveField(2)
  double? amount;

  /// Recipients: For non asset transfers, the list of recipients
  /// of the transaction (e.g Smart contract interactions)
  @HiveField(3)
  String? recipient;

  /// Timestamp: Date time when the transaction was generated
  @HiveField(4)
  int? timestamp;

  /// Fee: transaction fee (distributed over the node rewards)
  @HiveField(5)
  double? fee;

  /// From: transaction which send the amount of assets
  @HiveField(6)
  String? from;

  /// Content: free zone for data hosting (string or hexadecimal)
  @HiveField(9)
  String? content;

  /// Type: UCO/tokens/Call
  @HiveField(10)
  String? type;

  /// Token informations
  @HiveField(11)
  TokenInformations? tokenInformations;

  /// Contact informations
  @HiveField(12)
  Contact? contactInformations;

  /// Decrypted Secret
  @HiveField(14)
  List<String>? decryptedSecret;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'typeTx': typeTx,
        'recipient': recipient,
        'amount': amount,
        'fee': fee,
        'from': from,
        'content': content,
        'timestamp': timestamp,
        'type': type,
        'decryptedSecret': decryptedSecret
      };

  Future<Contact?> getContactInformations() async {
    contactInformations = null;
    if (typeTx == RecentTransaction.transferInput) {
      if (recipient != null) {
        final contact = await sl.get<DBHelper>().getContactWithAddress(from!);
        if (contact != null) {
          contactInformations = contact;
        }
      }
    } else {
      if (typeTx == RecentTransaction.transferOutput) {
        if (from != null) {
          final contact =
              await sl.get<DBHelper>().getContactWithAddress(recipient!);
          if (contact != null) {
            contactInformations = contact;
          }
        }
      }
    }

    return contactInformations;
  }

  // TODO(Chralu): Move that method in a dedicated [Provider]
  Future<TokenInformations?> getTokenInfo(
    String? content,
    String? address,
  ) async {
    Token? token;
    if (address == null) {
      return null;
    }

    final localOrRemoteContent = (content == null || content.isEmpty)
        ? await sl.get<ApiService>().getTransactionContent(address)
        : content;

    if (localOrRemoteContent.isEmpty) {
      return null;
    }
    try {
      token = tokenFromJson(localOrRemoteContent);
      return TokenInformations(
        address: token.address,
        name: token.name,
        supply: fromBigInt(token.supply).toDouble(),
        symbol: token.symbol,
        type: token.type,
      );
    } catch (e) {
      return null;
    }
  }
}
