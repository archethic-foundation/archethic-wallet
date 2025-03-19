import 'package:aewallet/domain/repositories/app_version_update_info.dart';
import 'package:app_version_update/app_version_update.dart';

class AppVersionUpdateInfo implements AppVersionUpdateInfoInterface {
  @override
  Future<({bool canUpdate, String storeVersion})> getAppVersionInfo() async {
    final newVersion = await AppVersionUpdate.checkForUpdates(
      appleId: '6443334906',
      playStoreId: 'net.archethic.archethic_wallet',
    );

    return (
      canUpdate: newVersion.canUpdate ?? false,
      storeVersion: newVersion.storeVersion ?? '',
    );
  }
}
