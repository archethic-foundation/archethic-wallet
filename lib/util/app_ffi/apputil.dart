// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/db/account.dart' as account;
import 'package:archethic_mobile_wallet/model/db/appdb.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';

class AppUtil {
  Future<void> loginAccount(String genesisAddress, BuildContext context) async {
    account.Account selectedAcct =
        await sl.get<DBHelper>().getSelectedAccount(genesisAddress);
    if (selectedAcct == null) {
      selectedAcct = account.Account(
          index: 0,
          lastAccess: 0,
          name: AppLocalization.of(context).defaultAccountName,
          selected: true);
      await sl.get<DBHelper>().saveAccount(selectedAcct);
    }
    StateContainer.of(context).updateWallet(account: selectedAcct);
  }
}
