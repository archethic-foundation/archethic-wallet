/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/infrastructure/datasources/wallet_token_dto.hive.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

class TokensListHiveDatasource {
  TokensListHiveDatasource._(this._box);

  static const String _tokensListBox = 'tokensListBox';
  final Box<WalletTokenHiveDto> _box;

  static const String aeSwapTokensList = 'ae_wallet_token_list';

  bool get shouldBeReloaded => _box.isEmpty;

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static TokensListHiveDatasource? _instance;
  static Future<TokensListHiveDatasource> getInstance() async {
    if (_instance?._box.isOpen == true) return _instance!;
    final box = await Hive.openBox<WalletTokenHiveDto>(_tokensListBox);
    return _instance = TokensListHiveDatasource._(box);
  }

  Future<void> setTokensList(List<WalletTokenHiveDto> v) async {
    await _box.clear();
    for (final token in v) {
      await _box.put(token.address!.toUpperCase(), token);
    }
  }

  Future<void> setToken(WalletTokenHiveDto v) async {
    await _box.put(v.address, v);
  }

  WalletTokenHiveDto? getToken(String key) {
    return _box.get(key.toUpperCase());
  }

  Future<void> removeToken(Token v) async {
    await _box.delete(v.address!.toUpperCase());
  }

  List<WalletTokenHiveDto> getTokensList() {
    return _box.values.toList();
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
