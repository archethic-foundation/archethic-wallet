/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show ApiCoinsService, ApiService, AddressService, OracleService;

// Package imports:
import 'package:ledger_dart_lib/ledger_dart_lib.dart';

// Project imports:
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/nfc.dart';
import 'package:aewallet/util/preferences.dart';

Future<void> setupServiceLocator() async {
  if (sl.isRegistered<AppService>()) {
    sl.unregister<AppService>();
  }
  sl.registerLazySingleton<AppService>(() => AppService());

  if (sl.isRegistered<ApiCoinsService>()) {
    sl.unregister<ApiCoinsService>();
  }
  sl.registerLazySingleton<ApiCoinsService>(() => ApiCoinsService());

  if (sl.isRegistered<DBHelper>()) {
    sl.unregister<DBHelper>();
  }
  sl.registerLazySingleton<DBHelper>(() => DBHelper());

  if (sl.isRegistered<HapticUtil>()) {
    sl.unregister<HapticUtil>();
  }
  sl.registerLazySingleton<HapticUtil>(() => HapticUtil());

  if (sl.isRegistered<BiometricUtil>()) {
    sl.unregister<BiometricUtil>();
  }
  sl.registerLazySingleton<BiometricUtil>(() => BiometricUtil());

  if (sl.isRegistered<NFCUtil>()) {
    sl.unregister<NFCUtil>();
  }
  sl.registerLazySingleton<NFCUtil>(() => NFCUtil());

  if (sl.isRegistered<LedgerNanoSImpl>()) {
    sl.unregister<LedgerNanoSImpl>();
  }
  sl.registerLazySingleton<LedgerNanoSImpl>(() => LedgerNanoSImpl());

  final preferences = await Preferences.getInstance();
  final network = await preferences.getNetwork().getLink();
  if (sl.isRegistered<ApiService>()) {
    sl.unregister<ApiService>();
  }
  sl.registerLazySingleton<ApiService>(() => ApiService(network));

  if (sl.isRegistered<AddressService>()) {
    sl.unregister<AddressService>();
  }
  sl.registerLazySingleton<AddressService>(() => AddressService(network));

  if (sl.isRegistered<OracleService>()) {
    sl.unregister<OracleService>();
  }
  sl.registerLazySingleton<OracleService>(() => OracleService(network));
}
