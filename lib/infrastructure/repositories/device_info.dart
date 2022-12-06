import 'package:aewallet/domain/repositories/device_info.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceInfoRepository implements DeviceInfoRepositoryInterface {
  @override
  Future<String> getInstallationId() async {
    const installationIdKey = 'INSTALLATION_ID';
    const storage = FlutterSecureStorage();

    final installationId = await storage.read(key: installationIdKey);
    if (installationId != null) return installationId;

    final newInstallationId = const Uuid().v4();
    await storage.write(
      key: installationIdKey,
      value: newInstallationId,
    );
    return newInstallationId;
  }
}
