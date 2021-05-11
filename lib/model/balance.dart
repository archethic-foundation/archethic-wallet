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
}
