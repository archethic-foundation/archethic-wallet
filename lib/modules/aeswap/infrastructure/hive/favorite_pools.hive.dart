import 'package:hive/hive.dart';

class HiveFavoritePoolsDatasource {
  HiveFavoritePoolsDatasource._(this._box);

  static const String _favoritePoolsBox = 'favoritePoolsBox';
  final Box<String> _box;

  bool get shouldBeReloaded => _box.isEmpty;

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<HiveFavoritePoolsDatasource> getInstance() async {
    final box = await Hive.openBox<String>(_favoritePoolsBox);
    return HiveFavoritePoolsDatasource._(box);
  }

  Future<void> addFavoritePool(String env, String poolAddress) async {
    await _box.put('${env.toUpperCase()}-${poolAddress.toUpperCase()}', '');
  }

  bool isFavoritePool(String env, String poolAddress) {
    return _box
        .containsKey('${env.toUpperCase()}-${poolAddress.toUpperCase()}');
  }

  Future<void> removeFavoritePool(String env, String poolAddress) async {
    await _box.delete('${env.toUpperCase()}-${poolAddress.toUpperCase()}');
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
