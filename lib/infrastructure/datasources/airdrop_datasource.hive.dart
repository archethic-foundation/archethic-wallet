/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/infrastructure/datasources/airdrop_dto.hive.dart';
import 'package:aewallet/infrastructure/datasources/hive.extension.dart';
import 'package:hive/hive.dart';

class AirdropHiveDatasource {
  AirdropHiveDatasource._(this._box);

  static const String _airdropBox = 'airdropBox';
  final Box<AirdropHiveDto> _box;
  final key = 'airdrop';

  bool get shouldBeReloaded => _box.isEmpty;

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static AirdropHiveDatasource? _instance;
  static Future<AirdropHiveDatasource> getInstance() async {
    if (_instance?._box.isOpen == true) return _instance!;
    final box = await Hive.openBox<AirdropHiveDto>(_airdropBox);
    return _instance = AirdropHiveDatasource._(box);
  }

  Future<void> setAirdrop(AirdropHiveDto v) async {
    await _box.put(key, v);
  }

  AirdropHiveDto? getAirdrop() {
    return _box.get(key);
  }

  Future<void> removeAirdrop() async {
    await _box.delete(key);
  }

  static Future<void> clear() => Hive.deleteBox<AirdropHiveDto>(_airdropBox);
}
