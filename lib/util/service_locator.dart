import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/infrastructure/repositories/settings.dart';
import 'package:aewallet/infrastructure/rpc/deeplink_server.dart';
import 'package:aewallet/infrastructure/rpc/websocket_server.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';

import 'package:aewallet/util/nfc.dart';

Future<void> setupServiceLocator() async {
  sl
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
}
