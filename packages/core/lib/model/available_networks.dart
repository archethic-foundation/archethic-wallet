// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/model/setting_item.dart';

enum AvailableNetworks { AEMainNet, AETestNet, AEDevNet }

class NetworksSetting extends SettingSelectionItem {
  NetworksSetting(this.network);

  AvailableNetworks network;

  @override
  String getDisplayName(BuildContext context) {
    switch (network) {
      case AvailableNetworks.AEMainNet:
        return 'AE Main Network';
      case AvailableNetworks.AETestNet:
        return 'AE Test Network';
      case AvailableNetworks.AEDevNet:
        return 'AE Dev Network';
      default:
        return 'Unknown Network';
    }
  }

  String getLongDisplayName(BuildContext context) {
    switch (network) {
      case AvailableNetworks.AEMainNet:
        return 'ARCHEthic Main Network';
      case AvailableNetworks.AETestNet:
        return 'ARCHEthic Test Network';
      case AvailableNetworks.AEDevNet:
        return 'ARCHEthic Dev Network';
      default:
        return 'Unknown Network';
    }
  }

  String getLink() {
    switch (network) {
      case AvailableNetworks.AEMainNet:
        return 'https://mainnet.archethic.net';
      case AvailableNetworks.AETestNet:
        return 'https://testnet.archethic.net';
      case AvailableNetworks.AEDevNet:
        return 'http://localhost:4000';
      default:
        return '';
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return network.index;
  }
}
