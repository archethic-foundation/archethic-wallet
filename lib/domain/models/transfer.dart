import 'package:aewallet/model/address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'transfer.freezed.dart';

/// Represents a transfer, blockchain agnostic.
@freezed
class Transfer with _$Transfer {
  const Transfer._();
  const factory Transfer.uco({
    required String seed,
    required String accountSelectedName,
    required String message,
    required double amount, // expressed in UCO
    required Address recipientAddress,
    String? tokenAddress,
  }) = _Transfer;
}
