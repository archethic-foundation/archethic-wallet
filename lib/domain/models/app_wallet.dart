import 'package:aewallet/model/data/app_keychain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_wallet.freezed.dart';

@freezed
class AppWallet with _$AppWallet {
  const factory AppWallet({
    required String seed,
    required AppKeychain appKeychain,
  }) = _AppWallet;

  const AppWallet._();
}
