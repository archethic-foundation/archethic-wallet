// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show ApiCoinsService, ApiService, AddressService;
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:archethic_mobile_wallet/model/db/appdb.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service/app_service.dart';
import 'package:archethic_mobile_wallet/util/biometrics.dart';
import 'package:archethic_mobile_wallet/util/hapticutil.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';

GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  if (sl.isRegistered<SharedPrefsUtil>()) {
    sl.unregister<SharedPrefsUtil>();
  }
  sl.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());

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

  if (sl.isRegistered<Vault>()) {
    sl.unregister<Vault>();
  }
  sl.registerLazySingleton<Vault>(() => Vault());

  final String endpoint = await sl.get<SharedPrefsUtil>().getEndpoint();

  if (sl.isRegistered<ApiService>()) {
    sl.unregister<ApiService>();
  }
  sl.registerLazySingleton<ApiService>(() => ApiService(endpoint));

  if (sl.isRegistered<AddressService>()) {
    sl.unregister<AddressService>();
  }
  sl.registerLazySingleton<AddressService>(() => AddressService(endpoint));
}
