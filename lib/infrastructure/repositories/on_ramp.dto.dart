part of 'on_ramp.repository.dart';

OnRampTransferState _onRampTransferStateFromJson(String json) => switch (json) {
      'REBALANCING' => OnRampTransferState.rebalancing,
      'PROCESSING' => OnRampTransferState.processing,
      'COMPLETED' => OnRampTransferState.completed,
      _ => throw FormatException(
          'Invalid JSON format for OnRampTransferState',
          json,
        ),
    };

OnRampTransfer _onRampTransferFromJson(Map<String, dynamic>? json) =>
    switch (json) {
      {
        'transfer_id': final String transferId,
        'timestamp': final String timestamp,
        'chain_id': final String chainId,
        'token_id': final String tokenId,
        'amount': final String amount,
        'fee_amount': final String feeAmount,
        'remaining_amount': final String remainingAmount,
        'uco_transfered_amount': final String ucoTransferedAmount,
        'state': final String state,
      } =>
        (
          id: transferId,
          depositDate: DateTime.fromMillisecondsSinceEpoch(
            int.parse(timestamp) * 1000,
          ),
          depositChainId: chainId,
          depositTokenId: tokenId,
          depositAmount: double.parse(amount),
          feeAmount: double.parse(feeAmount),
          remainingAmount: double.parse(remainingAmount),
          transferedUcoAmount: double.parse(ucoTransferedAmount),
          state: _onRampTransferStateFromJson(state),
        ),
      _ => throw FormatException(
          'Invalid JSON format for OnRampTransfer',
          json,
        ),
    };

OnRampEvent _onRampEventFromJson(Map<String, dynamic>? json) => switch (json) {
      {
        'event_type': 'TRANSFER_UPDATE',
        'transfer': final Map<String, dynamic> jsonTransfer
      } =>
        OnRampTransferUpdateEvent(_onRampTransferFromJson(jsonTransfer)),
      _ => throw FormatException(
          'Invalid JSON format for OnRampEvent',
          json,
        ),
    };
