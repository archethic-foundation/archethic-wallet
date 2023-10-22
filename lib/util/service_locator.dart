/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:aewallet/infrastructure/repositories/settings.dart';
import 'package:aewallet/infrastructure/rpc/deeplink_server.dart';
import 'package:aewallet/infrastructure/rpc/websocket_server.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/nfc.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show AddressService, ApiService, OracleService;
import 'package:archethic_messaging_lib_dart/archethic_messaging_lib_dart.dart';
import 'package:coingecko_api/coingecko_api.dart';
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
    ..registerLazySingleton<CommandDispatcher>(
      CommandDispatcher.new,
    )
    ..registerLazySingleton<ArchethicWebsocketRPCServer>(
      ArchethicWebsocketRPCServer.new,
    )
    ..registerLazySingleton<ArchethicDeeplinkRPCServer>(
      ArchethicDeeplinkRPCServer.new,
    )
    ..registerLazySingleton<SettingsRepositoryInterface>(
      SettingsRepository.new,
    );

  await _setupServiceLocatorNetworkDependencies();
}

Future<void> _setupServiceLocatorNetworkDependencies() async {
  final preferences = await HivePreferencesDatasource.getInstance();
  final network = preferences.getNetwork().getLink();
  sl
    ..registerLazySingleton<ApiService>(
      () => ApiService(
        network,
        logsActivation: false,
      ),
    )
    ..registerLazySingleton<AddressService>(
      () => AddressService(
        network,
        logsActivation: false,
      ),
    )
    ..registerLazySingleton<OracleService>(
      () => OracleService(
        network,
        logsActivation: false,
      ),
    )
    ..registerLazySingleton<MessagingService>(
      () => MessagingService(
        logsActivation: false,
      ),
    );
}

Future<void> updateServiceLocatorNetworkDependencies() async {
  sl
    ..unregister<ApiService>()
    ..unregister<AddressService>()
    ..unregister<OracleService>()
    ..unregister<MessagingService>();

  await _setupServiceLocatorNetworkDependencies();
}
