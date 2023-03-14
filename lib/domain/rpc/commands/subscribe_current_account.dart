import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscribe_current_account.freezed.dart';

@freezed
class RPCSubscribeCurrentAccountCommandData
    with _$RPCSubscribeCurrentAccountCommandData {
  const factory RPCSubscribeCurrentAccountCommandData() =
      _RPCSubscribeCurrentAccountCommandData;
  const RPCSubscribeCurrentAccountCommandData._();
}
