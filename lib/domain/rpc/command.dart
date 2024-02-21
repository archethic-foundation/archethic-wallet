import 'package:archethic_wallet_client/archethic_wallet_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'command.freezed.dart';

@freezed
class RPCCommand<T> with _$RPCCommand<T> {
  const factory RPCCommand.authenticated({
    required RPCSessionOrigin origin,
    required T data,
  }) = RPCAuthenticatedCommand;

  const factory RPCCommand.anonymous({
    required T data,
  }) = RPCAnonymousCommand;

  const RPCCommand._();
}
