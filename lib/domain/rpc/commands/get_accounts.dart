import 'package:aewallet/domain/models/app_accounts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_accounts.freezed.dart';

@freezed
class RPCGetAccountsCommandData with _$RPCGetAccountsCommandData {
  const factory RPCGetAccountsCommandData() = _RPCGetAccountsCommandData;
  const RPCGetAccountsCommandData._();
}

@freezed
class RPCGetAccountsResultData with _$RPCGetAccountsResultData {
  const factory RPCGetAccountsResultData({
    required List<AppAccount> accounts,
  }) = _RPCGetAccountsResultData;

  const RPCGetAccountsResultData._();
}
