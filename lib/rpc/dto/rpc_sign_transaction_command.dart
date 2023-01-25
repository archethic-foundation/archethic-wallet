import 'package:aewallet/domain/service/commands/sign_transaction.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpc_sign_transaction_command.freezed.dart';
part 'rpc_sign_transaction_command.g.dart';

// /// [RpcTransactionTokenTransfer] represents the an asset transfer
// @freezed
// class RpcTransactionTokenTransfer with _$RpcTransactionTokenTransfer {
//   const factory RpcTransactionTokenTransfer({
//     required int amount,
//     required String to,
//     required String tokenAddress,
//     required int tokenId,
//   }) = _RpcTransactionTokenTransfer;
//   const RpcTransactionTokenTransfer._();

//   factory RpcTransactionTokenTransfer.fromJson(Map<String, dynamic> json) =>
//       _$RpcTransactionTokenTransferFromJson(json);

//   archethic.TokenTransfer toModel() => archethic.TokenTransfer(
//         amount: amount,
//         to: to,
//         tokenAddress: tokenAddress,
//         tokenId: tokenId,
//       );
//   // TransactionTokenTransfer toModel() => TransactionTokenTransfer(
//   //       amount: amount,
//   //       to: to,
//   //       tokenAddress: tokenAddress,
//   //       tokenId: tokenId,
//   //     );
// }

// /// [RpcTransactionTokenLedger] represents the transfers to perform on the token ledger
// @freezed
// class RpcTransactionTokenLedger with _$RpcTransactionTokenLedger {
//   const factory RpcTransactionTokenLedger({
//     required List<RpcTransactionTokenTransfer> transfers,
//   }) = _RpcTransactionTokenLedger;
//   const RpcTransactionTokenLedger._();

//   factory RpcTransactionTokenLedger.fromJson(Map<String, dynamic> json) =>
//       _$RpcTransactionTokenLedgerFromJson(json);

//   archethic.TokenLedger toModel() => archethic.TokenLedger(
//         transfers: transfers.map((transfer) => transfer.toModel()).toList(),
//       );
//   // TransactionTokenLedger toModel() => TransactionTokenLedger(
//   //       transfers: transfers.map((transfer) => transfer.toModel()).toList(),
//   //     );
// }

// /// [RpcTransactionUcoTransfer] represents the an asset transfer
// @freezed
// class RpcTransactionUcoTransfer with _$RpcTransactionUcoTransfer {
//   const factory RpcTransactionUcoTransfer({
//     required int amount,
//     required String to,
//   }) = _RpcTransactionUcoTransfer;
//   const RpcTransactionUcoTransfer._();

//   factory RpcTransactionUcoTransfer.fromJson(Map<String, dynamic> json) =>
//       _$RpcTransactionUcoTransferFromJson(json);

//   TransactionUcoTransfer toModel() => TransactionUcoTransfer(
//         amount: amount,
//         to: to,
//       );
// }

// /// [RpcTransactionUCOLedger] represents the transfers to perform on the UCO ledger
// @freezed
// class RpcTransactionUCOLedger with _$RpcTransactionUCOLedger {
//   const factory RpcTransactionUCOLedger({
//     required List<RpcTransactionUcoTransfer> transfers,
//   }) = _RpcTransactionUCOLedger;
//   const RpcTransactionUCOLedger._();

//   factory RpcTransactionUCOLedger.fromJson(Map<String, dynamic> json) =>
//       _$RpcTransactionUCOLedgerFromJson(json);

//   TransactionUCOLedger toModel() => TransactionUCOLedger(
//         transfers: transfers.map((transfer) => transfer.toModel()).toList(),
//       );
// }

// /// [RpcTransactionLedger] represents the ledger operations to perform
// @freezed
// class RpcTransactionLedger with _$RpcTransactionLedger {
//   const factory RpcTransactionLedger({
//     RpcTransactionTokenLedger? token,
//     RpcTransactionUCOLedger? uco,
//   }) = _RpcTransactionLedger;
//   const RpcTransactionLedger._();

//   factory RpcTransactionLedger.fromJson(Map<String, dynamic> json) =>
//       _$RpcTransactionLedgerFromJson(json);

//   archethic.Ledger toModel() => archethic.Ledger(
//         token: token?.toModel(),
//         uco: uco?.toModel(),
//       );
//   // TransactionLedger toModel() => TransactionLedger(
//   //       token: token?.toModel(),
//   //       uco: uco?.toModel(),
//   //     );
// }

// /// [RpcTransactionAuthorizedKey] represents a authorized public key with the encrypted secret key for this given key.
// /// By decrypting this secret key, the authorized public key will be able to decrypt its related secret
// @freezed
// class RpcTransactionAuthorizedKey with _$RpcTransactionAuthorizedKey {
//   const factory RpcTransactionAuthorizedKey({
//     required String publicKey,
//     required String encryptedSecretKey,
//   }) = _RpcTransactionAuthorizedKey;
//   const RpcTransactionAuthorizedKey._();

//   factory RpcTransactionAuthorizedKey.fromJson(Map<String, dynamic> json) =>
//       _$RpcTransactionAuthorizedKeyFromJson(json);

//   TransactionAuthorizedKey toModel() => TransactionAuthorizedKey(
//         publicKey: publicKey,
//         encryptedSecretKey: encryptedSecretKey,
//       );
// }

// @freezed
// class RpcTransactionOwnership with _$RpcTransactionOwnership {
//   const factory RpcTransactionOwnership({
//     List<RpcTransactionAuthorizedKey>? authorizedPublicKeys,
//     String? secret,
//   }) = _RpcTransactionOwnership;
//   const RpcTransactionOwnership._();

//   factory RpcTransactionOwnership.fromJson(Map<String, dynamic> json) =>
//       _$RpcTransactionOwnershipFromJson(json);

//   archethic.Ownership toModel() => archethic.Ownership(
//         secret: secret,
//         authorizedPublicKeys: authorizedPublicKeys
//             ?.map((publicKey) => publicKey.toModel())
//             .toList(),
//       );
//   // TransactionOwnership toModel() => TransactionOwnership(
//   //       secret: secret,
//   //       authorizedPublicKeys: authorizedPublicKeys
//   //           ?.map((publicKey) => publicKey.toModel())
//   //           .toList(),
//   //     );
// }

// @freezed
// class RpcTransactionData with _$RpcTransactionData {
//   const factory RpcTransactionData({
//     /// Code: smart contract code (hexadecimal),
//     required String code,

//     /// Content: free zone for data hosting (string or hexadecimal)
//     required String? content,

//     /// Ownership: authorization/delegations containing list of secrets and their authorized public keys to proof the ownership
//     required List<RpcTransactionOwnership> ownerships,

//     /// Ledger: asset transfers
//     required RpcTransactionLedger ledger,

//     /// Recipients: For non asset transfers, the list of recipients of the transaction (e.g Smart contract interactions)
//     List<String>? recipients,
//   }) = _RpcTransactionData;
//   const RpcTransactionData._();

//   factory RpcTransactionData.fromJson(Map<String, dynamic> json) =>
//       _$RpcTransactionDataFromJson(json);

//   archethic.Data toModel() => archethic.Data(
//         code: code,
//         content: content,
//         ownerships: ownerships.map((ownership) => ownership.toModel()).toList(),
//         ledger: ledger.toModel(),
//       );
//   // TransactionData toModel() => TransactionData(
//   //       code: code,
//   //       content: content,
//   //       ownerships: ownerships.map((ownership) => ownership.toModel()).toList(),
//   //       ledger: ledger.toModel(),
//   //     );
// }

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
