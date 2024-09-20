/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_pool.hive.dart';
import 'package:hive/hive.dart';

class HivePoolsListDatasource {
  HivePoolsListDatasource._(this._box);

  static const String _poolsListBox = 'aeSwapPoolsListBox';
  final Box<DexPoolHive> _box;

  bool get shouldBeReloaded => _box.isEmpty;

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<HivePoolsListDatasource> getInstance() async {
    final box = await Hive.openBox<DexPoolHive>(_poolsListBox);
    return HivePoolsListDatasource._(box);
  }

  Future<void> setPoolInfos(
    String env,
    String poolAddress,
    DexPoolInfosHive poolInfos,
  ) async {
    final pool = _box.get('${env.toUpperCase()}-${poolAddress.toUpperCase()}');
    if (pool == null) return;
    await _box.put(
      '${env.toUpperCase()}-${poolAddress.toUpperCase()}',
      pool.copyWith(details: poolInfos),
    );
  }

  Future<void> setPoolsList(
    String env,
    List<DexPoolHive> v,
  ) async {
    await _box.clear();
    for (final pool in v) {
      await _box.put(
        '${env.toUpperCase()}-${pool.poolAddress.toUpperCase()}',
        pool,
      );
    }
  }

  Future<void> setPool(String env, DexPoolHive v) async {
    await _box.put('${env.toUpperCase()}-${v.poolAddress.toUpperCase()}', v);
  }

  DexPoolHive? getPool(String env, String key) {
    return _box.get('${env.toUpperCase()}-${key.toUpperCase()}');
  }

  Future<void> removePool(String env, String poolAddress) async {
    await _box.delete('${env.toUpperCase()}-${poolAddress.toUpperCase()}');
  }

  List<DexPoolHive> getPoolsList(String env) {
    final list = <DexPoolHive>[];
    for (final String key in _box.keys) {
      if (key.startsWith(env.toUpperCase()) && _box.get(key) != null) {
        list.add(_box.get(key)!);
      }
    }
    return list;
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
