import 'package:aewallet/domain/models/app_version_info.dart';
import 'package:aewallet/domain/repositories/app_version_update_info.dart';
import 'package:app_version_update/app_version_update.dart';

class AppVersionUpdateInfo implements AppVersionUpdateInfoInterface {
  @override
  Future<AppVersionInfo> getAppVersionInfo() async {
    final appVersionResult = await AppVersionUpdate.checkForUpdates(
      appleId: '6443334906',
      playStoreId: 'net.archethic.archethic_wallet',
    );

    return AppVersionInfo(
      canUpdate: appVersionResult.canUpdate ?? false,
      platform: appVersionResult.platform,
      storeUrl: appVersionResult.storeUrl ?? '',
      storeVersion: appVersionResult.storeVersion ?? '',
    );
  }
}
