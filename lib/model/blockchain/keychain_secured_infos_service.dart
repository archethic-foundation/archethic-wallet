import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keychain_secured_infos_service.freezed.dart';
part 'keychain_secured_infos_service.g.dart';

/// Holds keychain secured infos for each service

@freezed
class KeychainSecuredInfosService with _$KeychainSecuredInfosService {
  const factory KeychainSecuredInfosService({
    required String derivationPath,
    required String name,
    KeychainServiceKeyPair? keyPair,
    required String curve,
    required String hashAlgo,
  }) = _KeychainSecuredInfosService;
  const KeychainSecuredInfosService._();

  factory KeychainSecuredInfosService.fromJson(Map<String, dynamic> json) =>
      _$KeychainSecuredInfosServiceFromJson(json);
}
