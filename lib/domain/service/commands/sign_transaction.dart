import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_transaction.freezed.dart';

typedef SignTransactionResult
    = Result<TransactionConfirmation, TransactionError>;

/// [TransactionTokenTransfer] represents the an asset transfer
@freezed
class TransactionTokenTransfer with _$TransactionTokenTransfer {
  const factory TransactionTokenTransfer({
    required int amount,
    required String to,
    required String tokenAddress,
    required int tokenId,
  }) = _TransactionTokenTransfer;
  const TransactionTokenTransfer._();
}

/// [TransactionTokenLedger] represents the transfers to perform on the token ledger
@freezed
class TransactionTokenLedger with _$TransactionTokenLedger {
  const factory TransactionTokenLedger({
    required List<TransactionTokenTransfer> transfers,
  }) = _TransactionTokenLedger;
  const TransactionTokenLedger._();
}

/// [TransactionUcoTransfer] represents the an asset transfer
@freezed
class TransactionUcoTransfer with _$TransactionUcoTransfer {
  const factory TransactionUcoTransfer({
    required int amount,
    required String to,
  }) = _TransactionUcoTransfer;
  const TransactionUcoTransfer._();
}

/// [TransactionUCOLedger] represents the transfers to perform on the UCO ledger
@freezed
class TransactionUCOLedger with _$TransactionUCOLedger {
  const factory TransactionUCOLedger({
    required List<TransactionUcoTransfer> transfers,
  }) = _TransactionUCOLedger;
  const TransactionUCOLedger._();
}

/// [TransactionLedger] represents the ledger operations to perform
@freezed
class TransactionLedger with _$TransactionLedger {
  const factory TransactionLedger({
    TransactionTokenLedger? token,
    TransactionUCOLedger? uco,
  }) = _TransactionLedger;
  const TransactionLedger._();
}

/// [TransactionAuthorizedKey] represents a authorized public key with the encrypted secret key for this given key.
/// By decrypting this secret key, the authorized public key will be able to decrypt its related secret
@freezed
class TransactionAuthorizedKey with _$TransactionAuthorizedKey {
  const factory TransactionAuthorizedKey({
    required String publicKey,
    required String encryptedSecretKey,
  }) = _TransactionAuthorizedKey;
  const TransactionAuthorizedKey._();
}

@freezed
class TransactionOwnership with _$TransactionOwnership {
  const factory TransactionOwnership({
    List<TransactionAuthorizedKey>? authorizedPublicKeys,
    String? secret,
  }) = _TransactionOwnership;
  const TransactionOwnership._();
}

@freezed
class TransactionData with _$TransactionData {
  const factory TransactionData({
    /// Code: smart contract code (hexadecimal),
    required String code,

    /// Content: free zone for data hosting (string or hexadecimal)
    required String? content,

    /// Ownership: authorization/delegations containing list of secrets and their authorized public keys to proof the ownership
    required List<TransactionOwnership> ownerships,

    /// Ledger: asset transfers
    required TransactionLedger ledger,

    /// Recipients: For non asset transfers, the list of recipients of the transaction (e.g Smart contract interactions)
    List<String>? recipients,
  }) = _TransactionData;
  const TransactionData._();
}

@freezed
class SignTransactionCommand with _$SignTransactionCommand {
  const factory SignTransactionCommand({
    /// Service
    required String accountName,

    /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
    required archethic.Data data,

    /// - Type: transaction type
    required String type,

    /// - Version: version of the transaction (used for backward compatiblity)
    required int version,
  }) = _SignTransactionCommand;
  const SignTransactionCommand._();
}
