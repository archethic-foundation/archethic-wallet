part of '../vault.dart';
/// Used on NonWeb platform only.
///
/// Helpers to store [Vault] encryption data :
///   - [secureKey] :
///
extension HiveRawSecuredKey on HiveInterface {
  static const kSecureKey = 'archethic_wallet_secure_key';

  Future<bool> isSecureKeyDefined(
    FlutterSecureStorage secureStorage,
  ) async =>
      secureStorage.containsKey(key: kSecureKey);

  Future<void> clearSecureKey(
    FlutterSecureStorage secureStorage,
  ) =>
      secureStorage.delete(key: kSecureKey);

  Future<Uint8List> generateAndStoreSecureKey(
    FlutterSecureStorage secureStorage,
  ) async {
    final hiveKey = Hive.generateSecureKey();

    await secureStorage.write(
      key: kSecureKey,
      value: base64UrlEncode(hiveKey.toList()),
    );

    return Uint8List.fromList(hiveKey);
  }

  Future<Uint8List?> readSecureKey(
    FlutterSecureStorage secureStorage,
  ) async {
    final keyBase64 = await secureStorage.read(
      key: kSecureKey,
    );

    if (keyBase64 == null) {
      return null;
    }

    return base64Url.decode(keyBase64);
  }
}
