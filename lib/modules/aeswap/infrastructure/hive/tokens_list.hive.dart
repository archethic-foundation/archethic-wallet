/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_token.hive.dart';
import 'package:hive/hive.dart';

class HiveTokensListDatasource {
  HiveTokensListDatasource._(this._box);

  static const String _tokensListBox = 'aeSwapTokensListBox';
  final Box<DexTokenHive> _box;

  bool get shouldBeReloaded => _box.isEmpty;

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<HiveTokensListDatasource> getInstance() async {
    final box = await Hive.openBox<DexTokenHive>(_tokensListBox);
    return HiveTokensListDatasource._(box);
  }

  Future<void> setTokensList(String env, List<DexTokenHive> v) async {
    await _box.clear();
    for (final token in v) {
      await _box.put(
        '${env.toUpperCase()}-${token.address!.toUpperCase()}',
        token,
      );
    }
  }

  Future<void> setToken(String env, DexTokenHive v) async {
    await _box.put('${env.toUpperCase()}-${v.address!.toUpperCase()}', v);
  }

  DexTokenHive? getToken(String env, String key) {
    return _box.get('${env.toUpperCase()}-${key.toUpperCase()}');
  }

  Future<void> removeToken(String env, DexTokenHive v) async {
    await _box.delete('${env.toUpperCase()}-${v.address!.toUpperCase()}');
  }

  List<DexTokenHive> getTokensList(String env) {
    final list = <DexTokenHive>[];
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
