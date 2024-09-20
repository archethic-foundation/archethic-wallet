/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:hive/hive.dart';

class HivePreferencesDatasource {
  HivePreferencesDatasource._(this._box);

  static const String _preferencesBox = 'aeSwapPreferencesBox';
  final Box<dynamic> _box;

  static const String logsActived = 'archethic_dex_logs_activated';
  static const String firstConnection = 'archethic_dex_first_connection';

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<HivePreferencesDatasource> getInstance() async {
    final box = await Hive.openBox<dynamic>(_preferencesBox);
    return HivePreferencesDatasource._(box);
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  Future<void> setLogsActived(bool v) => _setValue(logsActived, v);

  bool isLogsActived() => _getValue(logsActived, defaultValue: true);

  Future<void> setFirstConnection(bool v) => _setValue(firstConnection, v);

  bool isFirstConnection() => _getValue(firstConnection, defaultValue: true);

  Future<void> clearAll() async {
    await _box.clear();
  }
}
