import 'package:aewallet/model/blockchain/keychain_secured_infos_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keychain_secured_infos.freezed.dart';
part 'keychain_secured_infos.g.dart';

/// Holds keychain secured infos

@freezed
class KeychainSecuredInfos with _$KeychainSecuredInfos {
  const factory KeychainSecuredInfos({
    required List<int> seed,
    required int version,
    @Default({}) Map<String, KeychainSecuredInfosService> services,
  }) = _KeychainSecuredInfos;
  const KeychainSecuredInfos._();

  factory KeychainSecuredInfos.fromJson(Map<String, dynamic> json) =>
      _$KeychainSecuredInfosFromJson(json);
}
