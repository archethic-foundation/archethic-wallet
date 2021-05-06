class Balance {
  Balance({
    this.uco,
    this.nft,
  });

  double? uco;
  BalanceNft? nft;
}

class BalanceNft {
  BalanceNft({
    this.address,
    this.amount,
  });

  String? address;
  double? amount;
}
