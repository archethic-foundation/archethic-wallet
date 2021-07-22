// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show AddressService;

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/db/account.dart' as Account;
import 'package:archethic_mobile_wallet/model/db/appdb.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';

class AppUtil {
  Future<String> seedToAddress(String seed, int index) async {
    final String lastAddress = await sl.get<AddressService>().lastAddress(seed);

    final String genesisAddress =
        sl.get<AddressService>().deriveAddress(seed, 0);
    print("genesisAddress : " + genesisAddress);
    return genesisAddress;
  }

  Future<void> loginAccount(String genesisAddress, BuildContext context) async {
    Account.Account selectedAcct =
        await sl.get<DBHelper>().getSelectedAccount(genesisAddress);
    if (selectedAcct == null) {
      selectedAcct = Account.Account(
          index: 0,
          lastAccess: 0,
          name: AppLocalization.of(context).defaultAccountName,
          selected: true);
      await sl.get<DBHelper>().saveAccount(selectedAcct);
    }
    StateContainer.of(context).updateWallet(account: selectedAcct);
  }
}
