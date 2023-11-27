import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_current_account.freezed.dart';

@freezed
class RPCRefreshCurrentAccountCommandData
    with _$RPCRefreshCurrentAccountCommandData {
  const factory RPCRefreshCurrentAccountCommandData() =
      _RPCRefreshCurrentAccountCommandData;
  const RPCRefreshCurrentAccountCommandData._();
}
