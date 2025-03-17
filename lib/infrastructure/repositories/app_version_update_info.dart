import 'package:aewallet/domain/repositories/app_version_update_info.dart';
import 'package:new_version_plus/new_version_plus.dart';

class AppVersionUpdateInfo implements AppVersionUpdateInfoInterface {
  @override
  Future<({bool canUpdate, String storeVersion})> getAppVersionInfo() async {
    final newVersion = NewVersionPlus(
      iOSId: '6443334906',
      androidId: 'net.archethic.archethic_wallet',
    );

    final status = await newVersion.getVersionStatus();

    return (
      canUpdate: status?.canUpdate ?? false,
      storeVersion: status?.storeVersion ?? '',
    );
  }
}
