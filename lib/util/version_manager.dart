import 'dart:developer';
import 'dart:io';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionManager {
  factory VersionManager() {
    return _singleton;
  }

  VersionManager._internal();
  static final VersionManager _singleton = VersionManager._internal();

  Future checkCurrentVersion(WidgetRef ref) async {
    final preferences = await HivePreferencesDatasource.getInstance();

    final versionStored = preferences.getCurrentVersion();
    log('versionStored: $versionStored', name: 'checkVersion');

    final currentVersion = (await getCurrentVersion()).$1;
    log('currentVersion: $currentVersion', name: 'checkVersion');
    if (versionStored != currentVersion && currentVersion == '2.1.1') {
      // We need to reload keychain because of account's name structure change
      // https://github.com/archethic-foundation/archethic-wallet/pull/759
      log('upgrade 2.1.1 management start', name: 'checkVersion');
      await ref.read(SessionProviders.session.notifier).refresh();
      await ref
          .read(AccountProviders.selectedAccount.notifier)
          .refreshRecentTransactions();
      log('upgrade 2.1.1 management ended', name: 'checkVersion');
    }
    await preferences.setCurrentVersion(currentVersion);

    return;
  }

  static Future<(String, String)> getCurrentVersion() async {
    if (!kIsWeb && Platform.isWindows) {
      // TODO(reddwarf03): Not optimal but ok for the moment
      return ('2.1.1', '');
    } else {
      final packageInfo = await PackageInfo.fromPlatform();
      return (packageInfo.version, packageInfo.buildNumber);
    }
  }
}
