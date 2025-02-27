typedef OnRampChain = ({
  String id,
  String name,
  String iconUrl,
  List<OnRampToken> tokens,
});

typedef OnRampToken = ({
  String id,
  String symbol,
  String name,
  double feeRate,
  String address,
  String iconUrl,
});

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
  final double ucoAmount;
}

class OnRampTransferStepUcoTransfer extends OnRampTransferStep {
  const OnRampTransferStepUcoTransfer({
    required super.txHash,
    required super.txTimestamp,
  });
}

typedef OnRampTransfer = ({
  double fee,
  double amount,
  List<OnRampTransferStep> steps,
});

extension OnRampTransferExt on OnRampTransfer {
  double get swappedUcoAmount => steps.fold(
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
  double depositAmount,
  OnRampDepositState transferState,
  List<OnRampTransfer> transfers,
});

extension OnRampDepositExt on OnRampDeposit {
  double get remainingRatio => remainingAmount / (depositAmount - feesAmount);
  double get completedRatio => 1.0 - remainingRatio;
  double get feesAmount => transfers.fold(
        0,
        (acc, transfer) => acc + transfer.fee,
      );
  double get remainingAmount => depositAmount - transferedAmount;
  double get transferedAmount => transfers.fold(
        0,
        (acc, transfer) => acc + transfer.amount,
      );
  double get transferedUcoAmount => transfers.fold(
        0,
        (acc, transfer) => acc + transfer.swappedUcoAmount,
      );
}

sealed class OnRampEvent {
  const OnRampEvent();
}

class OnRampDepositUpdateEvent extends OnRampEvent {
  const OnRampDepositUpdateEvent(this.transfer);
  final OnRampDeposit transfer;
}

class OnRampTransfersSnapshotEvent extends OnRampEvent {
  OnRampTransfersSnapshotEvent({required this.transfers});

  final List<OnRampDeposit> transfers;
}
