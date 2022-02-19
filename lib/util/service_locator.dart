// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show ApiCoinsService, ApiService, AddressService, OracleService;

// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:archethic_wallet/model/data/appdb.dart';
import 'package:archethic_wallet/service/app_service.dart';
import 'package:archethic_wallet/util/biometrics_util.dart';
import 'package:archethic_wallet/util/haptic_util.dart';
import 'package:archethic_wallet/util/nfc.dart';
import 'package:archethic_wallet/util/preferences.dart';
import 'package:ledger_dart_lib/ledger_dart_lib.dart';

GetIt sl = GetIt.instance;

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

  final Preferences preferences = await Preferences.getInstance();
  final String endpoint = preferences.getEndpoint();

  if (sl.isRegistered<ApiService>()) {
    sl.unregister<ApiService>();
  }
  sl.registerLazySingleton<ApiService>(() => ApiService(endpoint));

  if (sl.isRegistered<AddressService>()) {
    sl.unregister<AddressService>();
  }
  sl.registerLazySingleton<AddressService>(() => AddressService(endpoint));

/*
// TODO: 1.0.4
  if (sl.isRegistered<OracleService>()) {
    sl.unregister<OracleService>();
  }
  sl.registerLazySingleton<OracleService>(() => OracleService(endpoint));
  */
}
