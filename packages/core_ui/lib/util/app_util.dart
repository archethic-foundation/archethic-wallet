/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

// Flutter imports:
import 'package:core/util/global_var.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class AppUtil {
  Future<Account?> loginAccount(String walletSeed, BuildContext context,
      {bool forceNewAccount = false}) async {
    if (forceNewAccount) {
      await sl.get<DBHelper>().dropAll();
    }
    Account? selectedAcct = await sl.get<DBHelper>().getSelectedAccount();

    if (selectedAcct == null) {
      /// Get Wallet KeyPair
      final KeyPair walletKeyPair = deriveKeyPair(walletSeed, 0);

      /// Generate keyChain Seed from random value
      final String keychainSeed = uint8ListToHex(Uint8List.fromList(
          List<int>.generate(32, (int i) => Random.secure().nextInt(256))));

      /// Default service for wallet
      const String kServiceName = 'main-uco-wallet';
      const String kDerivationPathWithoutIndex =
          'm/650\'/' + kServiceName + '\'/';
      const String index = '0';
      String kDerivationPath =
          kDerivationPathWithoutIndex + index.toString() + '\'';

      /// Create Keychain from keyChain seed and wallet public key to encrypt secret
      final Transaction keychainTransaction = await sl
          .get<ApiService>()
          .newKeychainTransaction(
              keychainSeed,
              [uint8ListToHex(walletKeyPair.publicKey)],
              hexToUint8List(globalVarOriginPrivateKey),
              serviceName: kServiceName,
              derivationPath: kDerivationPath);

      /// Create Keychain Access for wallet
      await sl.get<ApiService>().newAccessKeychainTransaction(
          walletSeed,
          hexToUint8List(keychainTransaction.address!),
          hexToUint8List(globalVarOriginPrivateKey));

      /// Get KeyChain Wallet
      Keychain keychain = await sl.get<ApiService>().getKeychain(walletSeed);

      /// Get all services for archethic blockchain
      keychain.services!.forEach((serviceName, service) async {
        /// For the moment, only one account for wallet : services "uco-wallet-main"
        /// When multi accounts will be implemented in archethic wallet, user could choose by himself the name of services
        /// The wallet app will force the account in the derivation path with nameService = Account
        if (service.derivationPath!.startsWith(kDerivationPathWithoutIndex) &&
            serviceName == kServiceName) {
          Uint8List genesisAddress =
              keychain.deriveAddress(serviceName, index: 0);
          selectedAcct = Account(
              index: 0,
              lastAccess: 0,
              genesisAddress: uint8ListToHex(genesisAddress),
              name: AppLocalization.of(context)!.defaultAccountName,
              selected: true);
          await sl.get<DBHelper>().saveAccount(selectedAcct!);
        }
      });
    }
    return selectedAcct;
  }

  static bool isDesktopMode() {
    if (kIsWeb) {
      if ((defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android)) {
        return false;
      } else {
        return true;
      }
    } else {
      if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        return true;
      } else {
        return false;
      }
    }
  }
}
