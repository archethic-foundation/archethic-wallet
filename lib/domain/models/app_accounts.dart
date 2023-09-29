import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_accounts.freezed.dart';

@freezed
class AppAccount with _$AppAccount {
  const factory AppAccount({
    required String shortName,
    required String serviceName,
    required String genesisAddress,
  }) = _AppAccount;

  const AppAccount._();
}
