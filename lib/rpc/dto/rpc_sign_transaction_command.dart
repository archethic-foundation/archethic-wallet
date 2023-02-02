import 'package:aewallet/domain/service/rpc/commands/sign_transaction.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpc_sign_transaction_command.freezed.dart';
part 'rpc_sign_transaction_command.g.dart';

@freezed
class RpcSignTransactionCommand with _$RpcSignTransactionCommand {
  const factory RpcSignTransactionCommand({
    /// DApp name
    required String source,

    /// Service
    required String accountName,

    /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
    required Map<String, dynamic> data,

    /// - Type: transaction type
    required String type,

    /// - Version: version of the transaction (used for backward compatiblity)
    required int version,
  }) = _RpcSignTransactionCommand;
  const RpcSignTransactionCommand._();

  factory RpcSignTransactionCommand.fromJson(Map<String, dynamic> json) =>
      _$RpcSignTransactionCommandFromJson(json);

  SignTransactionCommand toModel() {
    return SignTransactionCommand(
      source: source,
      accountName: accountName,
      data: archethic.Data.fromJson(data),
      type: type,
      version: version,
    );
  }
}
