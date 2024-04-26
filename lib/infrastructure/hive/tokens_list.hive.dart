/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/infrastructure/hive/wallet_token.hive.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

class HiveTokensListDatasource {
  HiveTokensListDatasource._(this._box);

  static const String _tokensListBox = 'tokensListBox';
  final Box<WalletTokenHive> _box;

  static const String aeSwapTokensList = 'ae_wallet_token_list';

  bool get shouldBeReloaded => _box.isEmpty;

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static HiveTokensListDatasource? _instance;
  static Future<HiveTokensListDatasource> getInstance() async {
    if (_instance?._box.isOpen == true) return _instance!;
    final box = await Hive.openBox<WalletTokenHive>(_tokensListBox);
    return _instance = HiveTokensListDatasource._(box);
  }

  Future<void> setTokensList(List<WalletTokenHive> v) async {
    await _box.clear();
    for (final token in v) {
      await _box.put(token.address!.toUpperCase(), token);
    }
  }

  Future<void> setToken(WalletTokenHive v) async {
    await _box.put(v.address, v);
  }

  WalletTokenHive? getToken(String key) {
    return _box.get(key.toUpperCase());
  }

  Future<void> removeToken(Token v) async {
    await _box.delete(v.address!.toUpperCase());
  }

  List<WalletTokenHive> getTokensList() {
    return _box.values.toList();
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
