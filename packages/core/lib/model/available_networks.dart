/// SPDX-License-Identifier: AGPL-3.0-or-later

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

  String getLongDisplayName() {
    switch (network) {
      case AvailableNetworks.AEMainNet:
        return 'Archethic Main Network';
      case AvailableNetworks.AETestNet:
        return 'Archethic Test Network';
      case AvailableNetworks.AEDevNet:
        return 'Archethic Dev Network';
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

  Color? getColor() {
    switch (network) {
      case AvailableNetworks.AEMainNet:
        return null;
      case AvailableNetworks.AETestNet:
        return Colors.green;
      case AvailableNetworks.AEDevNet:
        return Colors.orange;
      default:
        return null;
    }
  }

  String getNetworkCryptoCurrencyLabel() {
    switch (network) {
      case AvailableNetworks.AEMainNet:
        return 'UCO';
      case AvailableNetworks.AETestNet:
        return 'UCO';
      case AvailableNetworks.AEDevNet:
        return 'UCO';
      default:
        return 'Unknown Crypto Currency';
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return network.index;
  }
}
