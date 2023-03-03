import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_accounts.freezed.dart';
part 'app_accounts.g.dart';

@freezed
class AppAccount with _$AppAccount {
  const factory AppAccount({
    required String name,
    required String genesisAddress,
  }) = _AppAccount;

  const AppAccount._();

  factory AppAccount.fromJson(Map<String, dynamic> json) =>
      _$AppAccountFromJson(json);
}
