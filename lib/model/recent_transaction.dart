/// [TransactionInput] represents the inputs from the transaction.

class RecentTransaction {
  RecentTransaction({
    this.typeTx,
    this.amount,
    this.recipient,
    this.from,
    this.fee,
    this.nftName,
    this.nftAddress,
    this.content,
    this.timestamp,
    this.type,
  });

  /// Types of transaction
  static const int TRANSFER_INPUT = 1;
  static const int TRANSFER_OUTPUT = 2;
  static const int NFT_CREATION = 3;

  /// Type of transaction : 1=Transfer/Input, 2=Transfer/Output, 3=NFT creation
  int? typeTx;

  /// Amount: asset amount
  double? amount;

  /// Recipients: For non asset transfers, the list of recipients of the transaction (e.g Smart contract interactions)
  String? recipient;

  /// Timestamp: Date time when the transaction was generated
  int? timestamp;

  /// Fee: transaction fee (distributed over the node rewards)
  double? fee;

  /// From: transaction which send the amount of assets
  String? from;

  /// NFT name: name of the NFT if the type is NFT
  String? nftName;

  /// NFT address: address of the NFT if the type is NFT
  String? nftAddress;

  /// Content: free zone for data hosting (string or hexadecimal)
  String? content;
  
  /// Type: UCO/NFT/Call
  String? type;

  factory RecentTransaction.fromJson(Map<String, dynamic> json) =>
      RecentTransaction(
        typeTx: json['typeTx'] == null ? null : json['typeTx'].toInt(),
        recipient: json['recipient'],
        amount: json['amount'] == null ? null : json['amount'].toDouble(),
        fee: json['fee'] == null ? null : json['fee'].toDouble(),
        from: json['from'],
        nftAddress: json['nftAddress'],
        nftName: json['nftName'],
        content: json['content'],
        timestamp: json['timestamp'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'typeTx': typeTx,
        'recipient': recipient,
        'amount': amount,
        'fee': fee,
        'from': from,
        'nftAddress': nftAddress,
        'nftName': nftName,
        'content': content,
        'timestamp': timestamp,
        'type': type,
      };
}
