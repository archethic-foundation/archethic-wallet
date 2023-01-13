/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/service/command_dispatcher.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/nfc.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show ApiService, AddressService, OracleService;
import 'package:coingecko_api/coingecko_api.dart';
import 'package:ledger_dart_lib/ledger_dart_lib.dart';

Future<void> setupServiceLocator() async {
  if (sl.isRegistered<AppService>()) {
    sl.unregister<AppService>();
  }
  sl.registerLazySingleton<AppService>(AppService.new);

  if (sl.isRegistered<CoinGeckoApi>()) {
    sl.unregister<CoinGeckoApi>();
  }
  sl.registerLazySingleton<CoinGeckoApi>(CoinGeckoApi.new);

  if (sl.isRegistered<DBHelper>()) {
    sl.unregister<DBHelper>();
  }
  sl.registerLazySingleton<DBHelper>(DBHelper.new);

  if (sl.isRegistered<HapticUtil>()) {
    sl.unregister<HapticUtil>();
  }
  sl.registerLazySingleton<HapticUtil>(HapticUtil.new);

  if (sl.isRegistered<BiometricUtil>()) {
    sl.unregister<BiometricUtil>();
  }
  sl.registerLazySingleton<BiometricUtil>(BiometricUtil.new);

  if (sl.isRegistered<NFCUtil>()) {
    sl.unregister<NFCUtil>();
  }
  sl.registerLazySingleton<NFCUtil>(NFCUtil.new);

  if (sl.isRegistered<LedgerNanoSImpl>()) {
    sl.unregister<LedgerNanoSImpl>();
  }
  sl.registerLazySingleton<LedgerNanoSImpl>(LedgerNanoSImpl.new);

  final preferences = await HivePreferencesDatasource.getInstance();
  final network = preferences.getNetwork().getLink();
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

  if (sl.isRegistered<RemoteCommandDispatcher>()) {
    sl.unregister<RemoteCommandDispatcher>();
  }
  sl.registerLazySingleton<RemoteCommandDispatcher>(
      RemoteCommandDispatcher.new);
}
