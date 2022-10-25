/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';

enum AvailableNetworks { archethicMainNet, archethicTestNet, archethicDevNet }

@immutable
class NetworksSetting extends SettingSelectionItem {
  const NetworksSetting({
    required this.network,
    required this.networkDevEndpoint,
  });

  final AvailableNetworks network;

  final String networkDevEndpoint;

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

  String getLink() {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'https://mainnet.archethic.net';
      case AvailableNetworks.archethicTestNet:
        return 'https://testnet.archethic.net';
      case AvailableNetworks.archethicDevNet:
        return networkDevEndpoint;
    }
  }

  String getPhoenixHttpLink() {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'https://mainnet.archethic.net/socket/websocket';
      case AvailableNetworks.archethicTestNet:
        return 'https://testnet.archethic.net/socket/websocket';
      case AvailableNetworks.archethicDevNet:
        return '$networkDevEndpoint/socket/websocket';
    }
  }

  String getWebsocketUri() {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'wss://mainnet.archethic.net/socket/websocket';
      case AvailableNetworks.archethicTestNet:
        return 'wss://testnet.archethic.net/socket/websocket';
      case AvailableNetworks.archethicDevNet:
        return '${networkDevEndpoint.replaceAll('https:', 'ws:').replaceAll('http:', 'ws:')}/socket/websocket';
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
