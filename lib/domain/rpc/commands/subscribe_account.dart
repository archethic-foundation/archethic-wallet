import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscribe_account.freezed.dart';

@freezed
class RPCSubscribeAccountCommandData with _$RPCSubscribeAccountCommandData {
  const factory RPCSubscribeAccountCommandData({
    required String accountName,
  }) = _RPCSubscribeAccountCommandData;
  const RPCSubscribeAccountCommandData._();
}
