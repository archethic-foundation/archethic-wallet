enum OnRampTransferState {
  rebalancing,
  processing,
  completed,
}

typedef OnRampTransfer = ({
  String id,
  DateTime depositDate,
  String depositChainId,
  String depositTokenId,
  double depositAmount,
  double feeAmount,
  double remainingAmount,
  double transferedUcoAmount,
  OnRampTransferState state,
});

extension OnRampTransferExt on OnRampTransfer {
  double get remainingRatio => remainingAmount / (depositAmount - feeAmount);
  double get completedRatio => 1.0 - remainingRatio;
}

sealed class OnRampEvent {
  const OnRampEvent();
}

class OnRampTransferUpdateEvent extends OnRampEvent {
  const OnRampTransferUpdateEvent(this.transfer);
  final OnRampTransfer transfer;
}
