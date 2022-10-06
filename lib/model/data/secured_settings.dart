import 'package:freezed_annotation/freezed_annotation.dart';

part 'secured_settings.freezed.dart';

@freezed
class SecuredSettings with _$SecuredSettings {
  const factory SecuredSettings({
    required String seed,
    String? pin,
    String? password,
    String? yubikeyClientID,
    String? yubikeyClientAPIKey,
  }) = _SecuredSettings;

  const SecuredSettings._();
}
