/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3auth_flutter/enums.dart' as web3authenums;
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class Web3AuthnUtil {
  Future<void> init() async {
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      await Web3AuthFlutter.init(
        Web3AuthOptions(
          clientId:
              'BJTc0YRH3meAdkLVxpRP4mkfKfUZCyvadZHuVzRl1XcqZGqaLX6K72BSjP4LVO0iwj3ZwZik6sAf3z2R-4TzFGI',
          network: web3authenums.Network.testnet,
          redirectUrl: Uri.parse('tech.archethic.wallet://auth'),
        ),
      );
    }
  }

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
    if (kIsWeb || (!kIsWeb && !Platform.isIOS && !Platform.isAndroid)) {
      return auth;
    }
    try {
      final response = await Web3AuthFlutter.login(
        LoginParams(
          loginProvider: web3authenums.Provider.discord,
        ),
      );
      if (response.sessionId != null) {
        auth = true;
      }
    } catch (e) {
      log(e.toString());
    }
    return auth;
  }
}
