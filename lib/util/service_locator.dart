/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';

import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/infrastructure/datasources/preferences.hive.dart';
import 'package:aewallet/infrastructure/repositories/settings.dart';
import 'package:aewallet/infrastructure/rpc/deeplink_server.dart';
import 'package:aewallet/infrastructure/rpc/websocket_server.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';

import 'package:aewallet/util/logger.dart';
import 'package:aewallet/util/nfc.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show AddressService, ApiService, OracleService;

Future<void> setupServiceLocator() async {
  sl
    ..registerLazySingleton<AppService>(AppService.new)
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<BiometricUtil>(BiometricUtil.new)
    ..registerLazySingleton<NFCUtil>(NFCUtil.new)
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
  final preferences = await PreferencesHiveDatasource.getInstance();
  final network = preferences.getNetwork().getLink();
  log('network: $network', name: '_setupServiceLocatorNetworkDependencies');
  sl
    ..registerLazySingleton<ApiService>(
      () => ApiService(network),
    )
    ..registerLazySingleton<AddressService>(
      () => AddressService(network),
    )
    ..registerLazySingleton<OracleService>(
      () => OracleService(network),
    );
  await LoggerSetup.instance().setup();
}

Future<void> updateServiceLocatorNetworkDependencies() async {
  sl
    ..unregister<ApiService>()
    ..unregister<AddressService>()
    ..unregister<OracleService>();

  await _setupServiceLocatorNetworkDependencies();
}
