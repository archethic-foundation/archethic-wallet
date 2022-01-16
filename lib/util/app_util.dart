// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/data/appdb.dart';
import 'package:archethic_wallet/model/data/hive_db.dart';
import 'package:archethic_wallet/util/service_locator.dart';

class AppUtil {
  Future<void> loginAccount(String seed, BuildContext context,
      {bool forceNewAccount = false}) async {
    if (forceNewAccount) {
      await sl.get<DBHelper>().dropAll();
    }
    Account? selectedAcct = await sl.get<DBHelper>().getSelectedAccount();

    if (selectedAcct == null) {
      final String genesisAddress =
          sl.get<AddressService>().deriveAddress(seed, 0);
      selectedAcct = Account(
          index: 0,
          lastAccess: 0,
          genesisAddress: genesisAddress,
          name: AppLocalization.of(context)!.defaultAccountName,
          selected: true);
      await sl.get<DBHelper>().saveAccount(selectedAcct);
    }
    StateContainer.of(context).requestUpdate(account: selectedAcct);
  }
}
