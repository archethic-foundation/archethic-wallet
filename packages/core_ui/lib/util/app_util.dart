/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show uint8ListToHex, deriveAddress;
import 'package:core/localization.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/get_it_instance.dart';

/// purpose = 44' (BIP44)
/// coin_type = 650' (UCO of ArchEthic Blockchain)
/// account = Depends on the intended use of the key.
/// Currently fixed values: 0xFFFF for o_{key}, 0x0000 for a simple w_{key})
/// change = 0 (0 for external, 1 for internal)
/// address_index = variable (0,1,2,...)
/// path = m/44'/650'/0'/0'/0'
const int kPurpose = 44;
const int kCoinType = 650;

class AppUtil {
  Future<Account> loginAccount(String seed, BuildContext context,
      {bool forceNewAccount = false}) async {
    if (forceNewAccount) {
      await sl.get<DBHelper>().dropAll();
    }
    Account? selectedAcct = await sl.get<DBHelper>().getSelectedAccount();

    if (selectedAcct == null) {
      String privateKey = seedToPrivateKey(seed, 0, 0, 0);
      final String genesisAddress = deriveAddress(privateKey, 0);
      selectedAcct = Account(
          index: 0,
          lastAccess: 0,
          genesisAddress: genesisAddress,
          name: AppLocalization.of(context)!.defaultAccountName,
          selected: true);
      await sl.get<DBHelper>().saveAccount(selectedAcct);
    }
    return selectedAcct;
  }

  String seedToPublicKey(
      String seed, int account, int change, int addressIndex) {
    return uint8ListToHex(bip32.BIP32
        .fromSeed(bip39.mnemonicToSeed(bip39.entropyToMnemonic(seed)))
        .derivePath("m/" +
            kPurpose.toString() +
            "'/" +
            kCoinType.toString() +
            "'/" +
            account.toString() +
            "'/" +
            change.toString() +
            "/" +
            addressIndex.toString())
        .publicKey);
  }

  String seedToPrivateKey(
      String seed, int account, int change, int addressIndex) {
    return uint8ListToHex(bip32.BIP32
        .fromSeed(bip39.mnemonicToSeed(bip39.entropyToMnemonic(seed)))
        .derivePath("m/" +
            kPurpose.toString() +
            "'/" +
            kCoinType.toString() +
            "'/" +
            account.toString() +
            "'/" +
            change.toString() +
            "/" +
            addressIndex.toString())
        .privateKey!);
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
