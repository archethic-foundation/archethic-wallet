/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3auth_flutter/enums.dart' as web3authenums;
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class Web3AuthnUtil {
  ///
  /// authenticateWithWeb3Authn()
  ///
  /// @param [provider] Provider from enum (Google, Discord, ...)
  /// @returns true if successfully authenticated, false otherwise
  Future<bool> authenticateWithWeb3Authn(
    BuildContext context,
    WidgetRef ref,
    web3authenums.Provider provider,
  ) async {
    var auth = false;
    try {
      await Web3AuthFlutter.init(
        _getWebAuthOptions(ref),
      );

      await Web3AuthFlutter.initialize();

      final response = await Web3AuthFlutter.login(
        LoginParams(loginProvider: web3authenums.Provider.discord),
      );
      if (response.sessionId != null) {
        auth = true;
      }
    } on UserCancelledException {
      log('User cancelled.');
    } on UnKnownException {
      log('Unknown exception occurred');
    }
    return auth;
  }

  Web3AuthOptions _getWebAuthOptions(
    WidgetRef ref,
  ) {
    final settings = ref.watch(SettingsProviders.settings);
    if (settings.network.network == AvailableNetworks.archethicTestNet ||
        kDebugMode) {
      return Web3AuthOptions(
        clientId:
            'BHZPoRIHdrfrdXj5E8G5Y72LGnh7L8UFuM8O0KrZSOs4T8lgiZnebB5Oc6cbgYSo3qSz7WBZXIs8fs6jgZqFFgw',
        network: web3authenums.Network.testnet,
      );
    } else {
      return Web3AuthOptions(
        clientId:
            'BHZPoRIHdrfrdXj5E8G5Y72LGnh7L8UFuM8O0KrZSOs4T8lgiZnebB5Oc6cbgYSo3qSz7WBZXIs8fs6jgZqFFgw',
        network: web3authenums.Network.mainnet,
      );
    }
  }
}
