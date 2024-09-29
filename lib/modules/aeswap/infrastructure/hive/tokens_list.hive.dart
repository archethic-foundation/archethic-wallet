/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_token.hive.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:hive/hive.dart';

class HiveTokensListDatasource {
  HiveTokensListDatasource._(this._box);

  // TODO: Before this hive named tokenslistbox but doublon with aewallet
  static const String _tokensListBox = 'aeSwapTokensListBox';
  final Box<DexTokenHive> _box;

  bool get shouldBeReloaded => _box.isEmpty;

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<HiveTokensListDatasource> getInstance() async {
    final box = await Hive.openBox<DexTokenHive>(_tokensListBox);
    return HiveTokensListDatasource._(box);
  }

  static String _key(Environment env, String address) =>
      '${env.name.toUpperCase()}-${address.toUpperCase()}';

  Future<void> setTokensList(Environment env, List<DexTokenHive> v) async {
    await _box.clear();
    for (final token in v) {
      await _box.put(
        _key(env, token.address!),
        token,
      );
    }
  }

  Future<void> setToken(Environment env, DexTokenHive v) async {
    await _box.put(_key(env, v.address!), v);
  }

  bool containsToken(Environment env, String address) {
    return _box.containsKey(_key(env, address));
  }

  DexTokenHive? getToken(Environment env, String address) {
    return _box.get(_key(env, address));
  }

  Future<void> removeToken(Environment env, String address) async {
    await _box.delete(_key(env, address));
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
