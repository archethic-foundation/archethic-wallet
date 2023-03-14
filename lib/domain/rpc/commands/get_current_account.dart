import 'package:aewallet/domain/models/app_accounts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_current_account.freezed.dart';

@freezed
class RPCGetCurrentAccountCommandData with _$RPCGetCurrentAccountCommandData {
  const factory RPCGetCurrentAccountCommandData() =
      _RPCGetCurrentAccountCommandData;
  const RPCGetCurrentAccountCommandData._();
}

@freezed
class RPCGetCurrentAccountResultData with _$RPCGetCurrentAccountResultData {
  const factory RPCGetCurrentAccountResultData({
    required AppAccount account,
  }) = _RPCGetCurrentAccountResultData;

  const RPCGetCurrentAccountResultData._();
}
