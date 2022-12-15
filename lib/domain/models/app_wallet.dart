import 'package:aewallet/model/data/app_keychain.dart';
import 'package:aewallet/model/keychain_secured_infos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_wallet.freezed.dart';

@freezed
class AppWallet with _$AppWallet {
  const factory AppWallet({
    required String seed,
    // TODO(redddwarf03): Mutualize keychain infos
    required AppKeychain appKeychain,
    required KeychainSecuredInfos keychainSecuredInfos,
  }) = _AppWallet;

  const AppWallet._();
}
