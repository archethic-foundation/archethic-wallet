/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'dart:typed_data';

import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:aewallet/model/data/app_keychain.dart';

part 'app_wallet.g.dart';

@HiveType(typeId: 4)
class AppWallet extends HiveObject {
  AppWallet({this.seed, this.appKeychain});

  /// Seed
  @HiveField(0)
  String? seed;

  /// Keychain
  @HiveField(1)
  AppKeychain? appKeychain;

  Future<AppWallet> createNewAppWallet(
    String keychainAddress,
    Keychain keychain,
    String? name,
  ) async {
    Account? selectedAcct;
    String seed = '';

    AppWallet appWallet =
        await sl.get<DBHelper>().createAppWallet(seed, keychainAddress);

    String nameEncoded = Uri.encodeFull(name!);

    /// Default service for wallet
    String kServiceName = 'archethic-wallet-$nameEncoded';

    Uint8List genesisAddress = keychain.deriveAddress(kServiceName, index: 0);
    selectedAcct = Account(
        lastLoadingTransactionInputs: 0,
        lastAddress: uint8ListToHex(genesisAddress),
        genesisAddress: uint8ListToHex(genesisAddress),
        name: name,
        balance: AccountBalance(
            fiatCurrencyCode: '',
            fiatCurrencyValue: 0,
            nativeTokenName: '',
            nativeTokenValue: 0),
        selected: true,
        recentTransactions: []);
    appWallet = await sl.get<DBHelper>().addAccount(selectedAcct);

    return appWallet;
  }
}
