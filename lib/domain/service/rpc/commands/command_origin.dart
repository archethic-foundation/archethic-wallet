import 'package:freezed_annotation/freezed_annotation.dart';

part 'command_origin.freezed.dart';

@freezed
class RPCCommandOrigin with _$RPCCommandOrigin {
  const factory RPCCommandOrigin({
    required String name,
    String? url,
    String? logo,
  }) = _RPCCommandOrigin;
  const RPCCommandOrigin._();
}
