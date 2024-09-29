/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_pair.hive.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_pool.hive.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_token.hive.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

// Difference with aeSwap - Add 100 to id
class HiveTypeIds {
  static const cacheManager = 101;
  static const dexPair = 102;
  static const dexPool = 105;
  static const dexPoolInfos = 106;
  static const dexToken = 104;
}

class DBHelperModuleAESwap {
  static Future<void> setupDatabase() async {
    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      final suppDir = await getApplicationSupportDirectory();
      Hive.init(suppDir.path);
    }

    Hive
      ..registerAdapter(DexPairHiveAdapter())
      ..registerAdapter(DexPoolHiveAdapter())
      ..registerAdapter(DexPoolInfosHiveAdapter())
      ..registerAdapter(DexTokenHiveAdapter());
  }
}
