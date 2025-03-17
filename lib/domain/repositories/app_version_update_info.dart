abstract class AppVersionUpdateInfoInterface {
  Future<({bool canUpdate, String storeVersion})> getAppVersionInfo();
}
