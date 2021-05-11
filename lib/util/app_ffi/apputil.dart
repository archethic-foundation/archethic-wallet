// @dart=2.9

import 'package:flutter/material.dart';
import 'package:uniris_lib_dart/address_util.dart';
import 'package:uniris_mobile_wallet/model/db/appdb.dart';
import 'package:uniris_mobile_wallet/model/db/account.dart' as Account;
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';

class AppUtil {
  String seedToAddress(String seed, int index) {

    String genesisAddress = deriveAddress(seed, 0);
    //print("genesisAddress : " + genesisAddress);
    return genesisAddress;
  }

  Future<void> loginAccount(String seed, BuildContext context) async {
    Account.Account selectedAcct =
        await sl.get<DBHelper>().getSelectedAccount(seed);
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
