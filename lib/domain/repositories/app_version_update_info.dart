import 'package:aewallet/domain/models/app_version_info.dart';

abstract class AppVersionUpdateInfoInterface {
  Future<AppVersionInfo> getAppVersionInfo();
}
