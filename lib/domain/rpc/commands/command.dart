import 'package:freezed_annotation/freezed_annotation.dart';

part 'command.freezed.dart';

@freezed
class RPCCommandOrigin with _$RPCCommandOrigin {
  const factory RPCCommandOrigin({
    required String name,
    String? url,
    String? logo,
  }) = _RPCCommandOrigin;
  const RPCCommandOrigin._();
}

@freezed
class RPCCommand<T> with _$RPCCommand<T> {
  const factory RPCCommand({
    required RPCCommandOrigin origin,
    required T data,
  }) = _RPCCommand;

  const RPCCommand._();
}
