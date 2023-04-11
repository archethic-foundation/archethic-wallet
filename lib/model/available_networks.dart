/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';

enum AvailableNetworks { archethicMainNet, archethicTestNet, archethicDevNet }

enum DefaultNetworksHost {
  archethicMainNetHost('mainnet.archethic.net'),
  archethicTestNetHost('testnet.archethic.net');

  const DefaultNetworksHost(this.value);
  final String value;
}

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
        return 'https://${DefaultNetworksHost.archethicMainNetHost.value}';
      case AvailableNetworks.archethicTestNet:
        return 'https://${DefaultNetworksHost.archethicTestNetHost.value}';
      case AvailableNetworks.archethicDevNet:
        return networkDevEndpoint;
    }
  }

  String getPhoenixHttpLink() {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'https://${DefaultNetworksHost.archethicMainNetHost.value}/socket/websocket';
      case AvailableNetworks.archethicTestNet:
        return 'https://${DefaultNetworksHost.archethicTestNetHost.value}/socket/websocket';
      case AvailableNetworks.archethicDevNet:
        return '$networkDevEndpoint/socket/websocket';
    }
  }

  String getWebsocketUri() {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'wss://${DefaultNetworksHost.archethicMainNetHost.value}/socket/websocket';
      case AvailableNetworks.archethicTestNet:
        return 'wss://${DefaultNetworksHost.archethicTestNetHost.value}/socket/websocket';
      case AvailableNetworks.archethicDevNet:
        return '${networkDevEndpoint.replaceAll('https:', 'ws:').replaceAll('http:', 'ws:')}/socket/websocket';
    }
  }

  String getAEWebUri() {
    switch (network) {
      case AvailableNetworks.archethicMainNet:
        return 'https://${DefaultNetworksHost.archethicMainNetHost.value}/api/web_hosting/';
      case AvailableNetworks.archethicTestNet:
        return 'https://${DefaultNetworksHost.archethicTestNetHost.value}/api/web_hosting/';
      case AvailableNetworks.archethicDevNet:
        return '$networkDevEndpoint/api/web_hosting/';
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return network.index;
  }
}
