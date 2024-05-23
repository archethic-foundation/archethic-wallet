import 'package:hive/hive.dart';

extension HiveClearExtension on HiveInterface {
  /// Workaround to [Hive.deleteBoxFromDisk] issues on web
  /// https://github.com/isar/hive/issues/344
  Future<void> deleteBox<E>(String boxName) async {
    final box = Hive.isBoxOpen(boxName)
        ? Hive.box<E>(boxName)
        : await Hive.openLazyBox<E>(boxName);
    await box.clear();
    await box.compact();
    await box.close();
  }
}
