import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plausible/plausible.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'analytics.g.dart';

@riverpod
Future<Plausible> plausibleClient(Ref ref) async {
  Future<String> getOrCreateUUID() async {
    const storage = FlutterSecureStorage();
    const key = 'user_uuid';
    final storedUUID = await storage.read(key: key);
    if (storedUUID != null) return storedUUID;
    final newUUID = const Uuid().v4();
    await storage.write(key: key, value: newUUID);
    return newUUID;
  }

  return Plausible(
    domain: 'wallet.archethic.net',
    userAgent: await getOrCreateUUID(),
  );
}
