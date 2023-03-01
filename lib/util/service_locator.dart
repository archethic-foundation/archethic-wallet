/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/service/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/service/rpc/commands/sign_transaction.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:aewallet/infrastructure/rpc/deeplink_handler.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/nfc.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show ApiService, AddressService, OracleService;
import 'package:coingecko_api/coingecko_api.dart';
import 'package:deeplink_rpc/deeplink_rpc.dart';
import 'package:ledger_dart_lib/ledger_dart_lib.dart';

Future<void> setupServiceLocator() async {
  sl
    ..registerLazySingleton<AppService>(AppService.new)
    ..registerLazySingleton<CoinGeckoApi>(CoinGeckoApi.new)
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<HapticUtil>(HapticUtil.new)
    ..registerLazySingleton<BiometricUtil>(BiometricUtil.new)
    ..registerLazySingleton<NFCUtil>(NFCUtil.new)
    ..registerLazySingleton<LedgerNanoSImpl>(LedgerNanoSImpl.new)
    ..registerLazySingleton<
        CommandDispatcher<SignTransactionCommand, SignTransactionResult>>(
      CommandDispatcher<SignTransactionCommand, SignTransactionResult>.new,
    )
    ..registerLazySingleton<DeeplinkRpcRequestReceiver>(
      () => DeeplinkRpcRequestReceiver()
        ..registerHandler(deeplinkRpcSignTransactionHandler),
    );

  await _setupServiceLocatorNetworkDependencies();
}

Future<void> _setupServiceLocatorNetworkDependencies() async {
  final preferences = await HivePreferencesDatasource.getInstance();
  final network = preferences.getNetwork().getLink();
  sl
    ..registerLazySingleton<ApiService>(() => ApiService(network))
    ..registerLazySingleton<AddressService>(() => AddressService(network))
    ..registerLazySingleton<OracleService>(() => OracleService(network));
}

Future<void> updateServiceLocatorNetworkDependencies() async {
  sl
    ..unregister<ApiService>()
    ..unregister<AddressService>()
    ..unregister<OracleService>();

  await _setupServiceLocatorNetworkDependencies();
}
