import 'package:hive/hive.dart';

extension HiveClearExtension on HiveInterface {
  /// Workaround to [HiveInterface.deleteBoxFromDisk] issues on web
  /// https://github.com/isar/hive/issues/344
  Future<void> deleteBox<E>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box<E>(boxName).close();
    }
    await Hive.deleteBoxFromDisk(boxName);
  }

  Future<void> deleteLazyBox<E>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.lazyBox<E>(boxName).close();
    }
    await Hive.deleteBoxFromDisk(boxName);
  }
}
