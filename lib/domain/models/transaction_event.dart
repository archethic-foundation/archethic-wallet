import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_event.freezed.dart';

@freezed
class TransactionError with _$TransactionError implements Exception {
  const TransactionError._();
  const factory TransactionError.timeout() = _TransactionTimeout;
  const factory TransactionError.connectivity() = _TransactionConnectionError;
  const factory TransactionError.consensusNotReached() =
      _TransactionConsensusNotReachedError;
  const factory TransactionError.invalidTransaction() = _TransactionInvalid;
  const factory TransactionError.invalidConfirmation() =
      _TransactionInvalidConfirmation;
  const factory TransactionError.insufficientFunds() =
      _TransactionInsufficientFunds;
  const factory TransactionError.serviceNotFound() =
      _TransactionServiceNotFound;
  const factory TransactionError.userRejected() = _TransactionUserRejected;
  const factory TransactionError.unknownAccount({
    required String accountName,
  }) = _TransactionUnknownAccount;
  const factory TransactionError.other({
    String? reason,
  }) = _TransactionOtherError;

  String get message => map(
        timeout: (_) => 'connection timeout',
        connectivity: (_) => 'connectivity issue',
        consensusNotReached: (_) => 'consensus not reached',
        invalidTransaction: (_) => 'invalid transaction',
        invalidConfirmation: (_) => 'invalid confirmation',
        insufficientFunds: (_) => 'insufficient funds',
        serviceNotFound: (_) => 'service not found',
        userRejected: (_) => 'user rejected',
        unknownAccount: (_) => 'unknown account',
        other: (other) => other.reason ?? 'other reason',
      );
}

@freezed
class TransactionConfirmation with _$TransactionConfirmation {
  const factory TransactionConfirmation({
    required String transactionAddress,
    @Default(0) int nbConfirmations,
    @Default(0) int maxConfirmations,
  }) = _TransactionConfirmation;

  const TransactionConfirmation._();

  bool get isFullyConfirmed => nbConfirmations >= maxConfirmations;
  bool get isEnoughConfirmed => isEnoughConfirmations(
        nbConfirmations,
        maxConfirmations,
      );

  double get confirmationRatio => max(1, maxConfirmations / nbConfirmations);

  static bool isEnoughConfirmations(
    int nbConfirmations,
    int maxConfirmations,
  ) =>
      nbConfirmations > 0;
}
