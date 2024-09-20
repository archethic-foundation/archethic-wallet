import 'package:flutter/material.dart';

class PoolFarmAvailable extends StatefulWidget {
  const PoolFarmAvailable({
    this.iconSize = 14,
    super.key,
  });

  final double iconSize;

  @override
  PoolFarmAvailableState createState() => PoolFarmAvailableState();
}

class PoolFarmAvailableState extends State<PoolFarmAvailable> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  // TODO(dev): HARDCODED
  ({
    String aeETHUCOPoolAddress,
    String aeETHUCOFarmLegacyAddress,
    String aeETHUCOFarmLockAddress
  }) getContextAddresses(String env) {
    switch (env) {
      case 'devnet':
        return (
          aeETHUCOPoolAddress:
              '0000c94189acdf76cd8d24eab10ef6494800e2f1a16022046b8ecb6ed39bb3c2fa42',
          aeETHUCOFarmLegacyAddress:
              '00008e063dffde69214737c4e9e65b6d9d5776c5369729410ba25dab0950fbcf921e',
          aeETHUCOFarmLockAddress:
              '00007338a899446b8d211bb82b653dfd134cc351dd4060bb926d7d9c7028cf0273bf'
        );
      case 'testnet':
        return (
          aeETHUCOPoolAddress:
              '0000818EF23676779DAE1C97072BB99A3E0DD1C31BAD3787422798DBE3F777F74A43',
          aeETHUCOFarmLegacyAddress:
              '0000208A670B5590939174D65F88140C05DDDBA63C0C920582E12162B22F3985E510',
          aeETHUCOFarmLockAddress:
              '0000CAF8D5BAA374A2878FD87760A2A4AC9F5232DBB4F1143157A2006F95FFF1B40E'
        );
      case 'mainnet':
      default:
        return (
          aeETHUCOPoolAddress:
              '000090C5AFCC97C2357E964E3DDF5BE9948477F7C1DE2C633CDFC95B202970AEA036',
          aeETHUCOFarmLegacyAddress:
              '0000474A5B5D261A86D1EB2B054C8E7D9347767C3977F5FC20BB8A05D6F6AFB53DCC',
          aeETHUCOFarmLockAddress:
              '0000b2339aadf5685b1c8d400c9092c921e51588dc049e097ec9437017e7dded0feb'
        );
    }
  }
}
