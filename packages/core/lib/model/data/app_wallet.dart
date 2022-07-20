/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:core/model/data/app_keychain.dart';

part 'app_wallet.g.dart';

@HiveType(typeId: 4)
class AppWallet extends HiveObject {
  AppWallet({this.seed, this.appKeychain});

  /// Seed
  @HiveField(0)
  String? seed;

  /// Keychain
  @HiveField(1)
  AppKeychain? appKeychain;
}
