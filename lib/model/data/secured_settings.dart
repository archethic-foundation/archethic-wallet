import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'secured_settings.freezed.dart';

@freezed
class SecuredSettings with _$SecuredSettings {
  const factory SecuredSettings({
    String? seed,
    String? pin,
    String? password,
    String? yubikeyClientID,
    String? yubikeyClientAPIKey,
    Map<String, KeychainServiceKeyPair>? keychainServiceKeyPairMap,
  }) = _SecuredSettings;

  const SecuredSettings._();
}
