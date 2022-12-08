import 'package:aewallet/domain/repositories/device_info.dart';
import 'package:aewallet/infrastructure/repositories/device_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info.g.dart';

@Riverpod(keepAlive: true)
DeviceInfoRepositoryInterface _deviceInfoRepository(Ref ref) {
  return DeviceInfoRepository();
}

@Riverpod(keepAlive: true)
Future<String> _installationId(Ref ref) async {
  final repository = ref.watch(_deviceInfoRepositoryProvider);

  return repository.getInstallationId();
}

abstract class DeviceInfoProviders {
  static final installationId = _installationIdProvider;
}
