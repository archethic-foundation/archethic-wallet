import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
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
    KeychainSecuredInfos? keychainSecuredInfos,
  }) = _SecuredSettings;

  const SecuredSettings._();
}
