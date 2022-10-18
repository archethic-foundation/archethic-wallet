part of 'transaction_sender.dart';

@freezed
class TransactionError with _$TransactionError {
  const TransactionError._();
  const factory TransactionError.timeout() = _TransactionTimeout;
  const factory TransactionError.connectivity() = _TransactionConnectionError;
  const factory TransactionError.invalidTransaction() = _TransactionInvalid;
  const factory TransactionError.invalidConfirmation() =
      _TransactionInvalidConfirmation;
  const factory TransactionError.insufficientFunds() =
      _TransactionInsufficientFunds;
  const factory TransactionError.other({
    String? reason,
  }) = _TransactionOtherError;

  String get message => map(
        timeout: (_) => 'connection timeout',
        connectivity: (_) => 'connectivity issue',
        invalidTransaction: (_) => 'invalid transaction',
        invalidConfirmation: (_) => 'invalid confirmation',
        insufficientFunds: (_) => 'insufficient funds',
        other: (other) => other.reason ?? 'other reason',
      );
}

@freezed
class TransactionConfirmation with _$TransactionConfirmation {
  const factory TransactionConfirmation({
    @Default(0) int nbConfirmations,
    @Default(0) int maxConfirmations,
  }) = _TransactionConfirmation;

  const TransactionConfirmation._();

  bool get isFullyConfirmed => nbConfirmations >= maxConfirmations;

  double get confirmationRatio => max(1, maxConfirmations / nbConfirmations);

  static bool isEnoughConfirmations(int nbConfirmations, int maxConfirmations) {
    /*if (maxConfirmations == 0 && nbConfirmations == 0) {
      return false;
    } else {
      if (maxConfirmations == 0 && nbConfirmations > 0) {
        return true;
      } else {
        if (nbConfirmations > 0 && maxConfirmations <= 3) {
          if (nbConfirmations > 0 && maxConfirmations <= 3) {
          return true;
        } else {
          if ((maxConfirmations / 3).ceil() <= nbConfirmations) {
            return true;
          } else {
            return false;
          }
        }
      }
    }
  }*/
    if (nbConfirmations > 0) {
      return true;
    } else {
      return false;
    }
  }
}
