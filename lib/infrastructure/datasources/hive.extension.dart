import 'package:hive/hive.dart';

extension HiveClearExtension on HiveInterface {
  /// Workaround to [Hive.deleteBoxFromDisk] issues on web
  /// https://github.com/isar/hive/issues/344
  Future<void> deleteBox(String boxName) async {
    final box = await Hive.openLazyBox(boxName);
    await box.clear();
    await box.compact();
    await box.close();
  }
}
