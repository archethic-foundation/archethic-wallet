// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:core/localization.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/get_it_instance.dart';

// Project imports:

class AppUtil {
  Future<Account> loginAccount(String seed, BuildContext context,
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
