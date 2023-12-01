import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_transaction.freezed.dart';

@freezed
class RPCSendTransactionCommandData with _$RPCSendTransactionCommandData {
  const factory RPCSendTransactionCommandData({
    /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
    required Data data,

    /// - Type: transaction type
    required String type,

    /// - Version: version of the transaction (used for backward compatiblity)
    required int version,

    /// - Flag to generate and add the encrypted smart contract's seed in a secret
    bool? generateEncryptedSeedSC,
  }) = _RPCSendTransactionCommandData;
  const RPCSendTransactionCommandData._();
}
