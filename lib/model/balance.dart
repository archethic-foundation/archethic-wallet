class Balance {
  Balance({
    this.uco,
    this.nftList,
  });

  double? uco;
  List<BalanceNft>? nftList;
}

class BalanceNft {
  BalanceNft({
    this.name,
    this.address,
    this.amount,
  });

  String? name;
  String? address;
  double? amount;

  static String? getName(String content) {
    final RegExp regExp = RegExp('/(?<=name: ).*/g');
    return regExp.stringMatch(content);
  }
}
