import 'dart:developer';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '437.dart';
part 'migration_manager.g.dart';

class LocalDataMigration {
  LocalDataMigration({
    required this.minAppVersion,
    required this.run,
  });

  final int minAppVersion;

  final Future<void> Function(Ref ref) run;

  bool shouldRun(int currentDataVersion) {
    return currentDataVersion < minAppVersion;
  }

  bool shouldSkip(int currentDataVersion) {
    return !shouldRun(currentDataVersion);
  }
}

@riverpod
List<LocalDataMigration> _migrations(_MigrationsRef ref) => [
      migration_437,
    ];

Future<void> _migrateLocalData(
  _MigrateLocalDataRef ref,
) async {
  const logName = 'DataMigration';

  final preferences = await HivePreferencesDatasource.getInstance();

  if (ref.read(SessionProviders.session).isLoggedOut) {
    log(
      'Skipping migration process : user logged out.',
      name: logName,
    );
    return;
  }

  final currentDataVersion = preferences.getCurrentDataVersion();
  log('Current data version: $currentDataVersion', name: logName);

  final migrations = ref.read(_migrationsProvider)
    ..sort(
      (a, b) => a.minAppVersion.compareTo(b.minAppVersion),
    );

  for (final migration in migrations) {
    if (migration.shouldSkip(currentDataVersion)) {
      log(
        'Skipping migration from version ${migration.minAppVersion}',
        name: logName,
      );
      continue;
    }

    log(
      'Running migration from version ${migration.minAppVersion}',
      name: logName,
    );
    await migration.run(ref);
  }

  log('Migrations successfully executed', name: logName);

  final currentAppVersion =
      await CurrentVersionRepository().getCurrentAppVersion();
  final currentAppBuildNumber = int.tryParse(currentAppVersion.$2);
  if (currentAppBuildNumber == null) {
    log(
      'Failed to update current data version : Unable to determine application build number ($currentAppVersion).',
      name: logName,
    );
    return;
  }
  await preferences.setCurrentDataVersion(currentAppBuildNumber);
  log(
    'Current data version updated to $currentAppBuildNumber.',
    name: logName,
  );
}

class CurrentVersionRepository {
  Future<(String, String)> getCurrentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return (packageInfo.version, packageInfo.buildNumber);
  }
}

abstract class VersionProviders {
  static final migrateLocalData = _migrateLocalDataProvider;
}
