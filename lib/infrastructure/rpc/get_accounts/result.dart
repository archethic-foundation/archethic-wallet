import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed
class RPCGetAccountsResult with _$RPCGetAccountsResult {
  const factory RPCGetAccountsResult({
    required String endpointUrl,
  }) = _RPCGetAccountsResult;
  const RPCGetAccountsResult._();

  factory RPCGetAccountsResult.fromJson(Map<String, dynamic> json) =>
      _$RPCGetAccountsResultFromJson(json);
}
