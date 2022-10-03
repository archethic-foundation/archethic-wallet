/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/model/setting_item.dart';
import 'package:aewallet/util/preferences.dart';

enum AvailableNetworks { archethicMainNet, archethicTestNet, archethicDevNet }

class NetworksSetting extends SettingSelectionItem {
  NetworksSetting(this.network);

  AvailableNetworks network;

  @override
  String getDisplayName(BuildContext context) {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'Archethic Main Network';
      case AvailableNetworks.archethicTestNet:
        return 'Archethic Test Network';
      case AvailableNetworks.archethicDevNet:
        return 'Archethic Dev Network';
    }
  }

  Future<String> getLink() async {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'https://mainnet.archethic.net';
      case AvailableNetworks.archethicTestNet:
        return 'https://testnet.archethic.net';
      case AvailableNetworks.archethicDevNet:
        final preferences = await Preferences.getInstance();
        return preferences.getNetworkDevEndpoint();
    }
  }

  Future<String> getPhoenixHttpLink() async {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'https://mainnet.archethic.net/socket/websocket';
      case AvailableNetworks.archethicTestNet:
        return 'https://testnet.archethic.net/socket/websocket';
      case AvailableNetworks.archethicDevNet:
        final preferences = await Preferences.getInstance();
        return '${preferences.getNetworkDevEndpoint()}/socket/websocket';
    }
  }

  Future<String> getWebsocketUri() async {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'wss://mainnet.archethic.net/socket/websocket';
      case AvailableNetworks.archethicTestNet:
        return 'wss://testnet.archethic.net/socket/websocket';
      case AvailableNetworks.archethicDevNet:
        final preferences = await Preferences.getInstance();
        return '${preferences.getNetworkDevEndpoint().replaceAll('https:', 'ws:').replaceAll('http:', 'ws:')}/socket/websocket';
    }
  }

  String getNetworkCryptoCurrencyLabel() {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'UCO';
      case AvailableNetworks.archethicTestNet:
        return 'UCO';
      case AvailableNetworks.archethicDevNet:
        return 'UCO';
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return network.index;
  }
}
