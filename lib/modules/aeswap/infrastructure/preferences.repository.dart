import 'package:aewallet/modules/aeswap/domain/repositories/preferences.repository.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/preferences.hive.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  @override
  Future<HivePreferencesDatasource> getPreferences() async {
    return HivePreferencesDatasource.getInstance();
  }

  @override
  Future<void> setFirstConnection(bool v) async {
    final hivePreferencesDatasource =
        await HivePreferencesDatasource.getInstance();
    await hivePreferencesDatasource.setFirstConnection(v);
    return;
  }

  @override
  Future<void> setLogsActived(bool v) async {
    final hivePreferencesDatasource =
        await HivePreferencesDatasource.getInstance();
    await hivePreferencesDatasource.setLogsActived(v);
    return;
  }

  @override
  Future<bool> isLogsActived() async {
    final hivePreferencesDatasource =
        await HivePreferencesDatasource.getInstance();
    return hivePreferencesDatasource.isLogsActived();
  }
}
