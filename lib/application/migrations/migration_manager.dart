import 'dart:developer';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '437.dart';
part '492.dart';
part 'migration_manager.freezed.dart';
part 'migration_manager.g.dart';

const logName = 'DataMigration';

@freezed
class LocalDataMigrationState with _$LocalDataMigrationState {
  const factory LocalDataMigrationState({
    @Default(false) bool migrationInProgress,
  }) = _LocalDataMigrationState;
  const LocalDataMigrationState._();
}

final _localDataMigrationProvider = NotifierProvider.autoDispose<
    LocalDataMigrationNotifier, LocalDataMigrationState>(
  () {
    return LocalDataMigrationNotifier();
  },
);

class LocalDataMigrationNotifier
    extends AutoDisposeNotifier<LocalDataMigrationState> {
  LocalDataMigrationNotifier();

  @override
  LocalDataMigrationState build() {
    return const LocalDataMigrationState();
  }

  void _setMigrationInProgress(bool migrationInProgress) {
    state = state.copyWith(migrationInProgress: migrationInProgress);
  }

  Future<void> migrateLocalData() async {
    final preferences = await HivePreferencesDatasource.getInstance();
    final currentDataVersion = await preferences.getCurrentDataVersion();
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

      _setMigrationInProgress(true);

      await migration.run(ref);

      _setMigrationInProgress(false);
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
}

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

class CurrentVersionRepository {
  Future<(String, String)> getCurrentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return (packageInfo.version, packageInfo.buildNumber);
  }
}

abstract class LocalDataMigrationProviders {
  static final localDataMigration = _localDataMigrationProvider;
}
