import 'dart:math' as math;

enum OnRampProviderOrderStatus {
  canceled,
  processing,
  completed,
  failed,
}

typedef OnRampProviderOrder = ({
  String providerId,
  String orderId,
  double cryptoAmount,
  String cryptoSymbol,
  OnRampProviderOrderStatus status,
});

typedef OnRampSetup = ({
  List<OnRampTokenDisplayData> tokensDisplayData,
  List<OnRampChain> chains,
});

typedef OnRampProvider = Map<String, OnRampProviderChain>;

typedef OnRampProviderChain = ({
  String id,
  Map<String, OnRampProviderToken> tokens,
});
typedef OnRampProviderToken = ({String id});

typedef OnRampChain = ({
  String id,
  int chainId,
  String displayName,
  String svgIcon,
  double feeRate,
  List<OnRampToken> tokens,
  Map<String, OnRampProviderChain> providers,
  bool available,
});

typedef OnRampTokenDisplayData = ({
  String id,
  String svgIcon,
  String symbol,
  String name,
});

typedef OnRampToken = ({
  String id,
  String address,
  int decimals,
});

extension OnRampTokenExt on OnRampToken {
  double toDecimal(int value) => value.toDecimal(decimals);
}

extension IntExt on int {
  double toDecimal(int decimals) => this / math.pow(10, decimals);
}

enum OnRampDepositState {
  processing,
  completed,
}

sealed class OnRampTransferStep {
  const OnRampTransferStep({required this.txHash, required this.txTimestamp});

  final String txHash;
  final DateTime txTimestamp;
}

class OnRampTransferStepDebit extends OnRampTransferStep {
  const OnRampTransferStepDebit({
    required super.txHash,
    required super.txTimestamp,
  });
}

class OnRampTransferStepSwap extends OnRampTransferStep {
  const OnRampTransferStepSwap({
    required super.txHash,
    required super.txTimestamp,
    required this.ucoAmount,
  });
  final int ucoAmount;
}

class OnRampTransferStepUcoTransfer extends OnRampTransferStep {
  const OnRampTransferStepUcoTransfer({
    required super.txHash,
    required super.txTimestamp,
  });
}

typedef OnRampTransfer = ({
  int fee,
  int amount,
  List<OnRampTransferStep> steps,
});

extension OnRampTransferExt on OnRampTransfer {
  int get swappedUcoAmount => steps.fold(
        0,
        (acc, step) => switch (step) {
          OnRampTransferStepSwap(ucoAmount: final ucoAmount) => acc + ucoAmount,
          _ => acc,
        },
      );
}

typedef OnRampDeposit = ({
  String id,
  DateTime depositDate,
  String depositTxHash,
  String depositChainId,
  String depositTokenId,
  int depositAmount,
  OnRampDepositState transferState,
  List<OnRampTransfer> transfers,
});

extension OnRampDepositExt on OnRampDeposit {
  double get remainingRatio => remainingAmount / (depositAmount - feesAmount);
  double get completedRatio => 1.0 - remainingRatio;
  int get feesAmount => transfers.fold(
        0,
        (acc, transfer) => acc + transfer.fee,
      );
  int get remainingAmount => depositAmount - transferedAmount;
  int get transferedAmount => transfers.fold(
        0,
        (acc, transfer) => acc + transfer.amount,
      );
  int get transferedUcoAmount => transfers.fold(
        0,
        (acc, transfer) => acc + transfer.swappedUcoAmount,
      );
}

sealed class OnRampEvent {
  const OnRampEvent();
}

class OnRampDepositUpdateEvent extends OnRampEvent {
  const OnRampDepositUpdateEvent(this.deposit);
  final OnRampDeposit deposit;
}

class OnRampDepositsSnapshotEvent extends OnRampEvent {
  OnRampDepositsSnapshotEvent(this.deposits);

  final List<OnRampDeposit> deposits;
}
