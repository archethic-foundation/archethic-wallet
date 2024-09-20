/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';

abstract class PoolRepository {
  Future<List<DexPool>> getPoolInfosBatch(
    List<DexPool> poolList,
  );
}
