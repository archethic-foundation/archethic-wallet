/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/model/setting_item.dart';

// Project imports:
import 'package:aeuniverse/util/preferences.dart';

enum AvailableNetworks { ArchethicMainNet, ArchethicTestNet, ArchethicDevNet }

class NetworksSetting extends SettingSelectionItem {
  NetworksSetting(this.network);

  AvailableNetworks network;

  @override
  String getDisplayName(BuildContext context) {
    switch (network) {
      case AvailableNetworks.ArchethicMainNet:
        return 'Archethic Main Network';
      case AvailableNetworks.ArchethicTestNet:
        return 'Archethic Test Network';
      case AvailableNetworks.ArchethicDevNet:
        return 'Archethic Dev Network';
      default:
        return 'Unknown Network';
    }
  }

  Future<String> getLink() async {
    switch (network) {
      case AvailableNetworks.ArchethicMainNet:
        return 'https://mainnet.archethic.net';
      case AvailableNetworks.ArchethicTestNet:
        return 'https://testnet.archethic.net';
      case AvailableNetworks.ArchethicDevNet:
        final Preferences preferences = await Preferences.getInstance();
        return preferences.getNetworkDevEndpoint();
      default:
        return '';
    }
  }

  Future<String> getPhoenixHttpLink() async {
    switch (network) {
      case AvailableNetworks.ArchethicMainNet:
        return 'https://mainnet.archethic.net/socket/websocket';
      case AvailableNetworks.ArchethicTestNet:
        return 'https://testnet.archethic.net/socket/websocket';
      case AvailableNetworks.ArchethicDevNet:
        final Preferences preferences = await Preferences.getInstance();
        return '${preferences.getNetworkDevEndpoint()}/socket/websocket';
      default:
        return '';
    }
  }

  Future<String> getWebsocketUri() async {
    switch (network) {
      case AvailableNetworks.ArchethicMainNet:
        return 'ws://mainnet.archethic.net/socket/websocket';
      case AvailableNetworks.ArchethicTestNet:
        return 'ws://testnet.archethic.net/socket/websocket';
      case AvailableNetworks.ArchethicDevNet:
        final Preferences preferences = await Preferences.getInstance();
        return '${preferences.getNetworkDevEndpoint().replaceAll('https:', 'ws:').replaceAll('http:', 'ws:')}/socket/websocket';
      default:
        return '';
    }
  }

  String getNetworkCryptoCurrencyLabel() {
    switch (network) {
      case AvailableNetworks.ArchethicMainNet:
        return 'UCO';
      case AvailableNetworks.ArchethicTestNet:
        return 'UCO';
      case AvailableNetworks.ArchethicDevNet:
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
