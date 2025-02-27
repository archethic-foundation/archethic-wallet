part of 'on_ramp.repository.dart';

OnRampDepositState _onRampDepositStateFromJson(bool json) => switch (json) {
      false => OnRampDepositState.processing,
      true => OnRampDepositState.completed,
    };

OnRampDeposit _onRampDepositFromJson(Map<String, dynamic>? json) =>
    switch (json) {
      {
        'deposit_id': final int depositId,
        'timestamp': final String timestamp,
        'tx_hash': final String txHash,
        'completed': final bool completed,
        'chain_id': final String chainId,
        'token_id': final String tokenId,
        'amount': final String amount,
        'transfers': final List transfers,
      } =>
        (
          id: '$depositId',
          depositDate: DateTime.parse(timestamp),
          depositTxHash: txHash,
          depositChainId: chainId,
          depositTokenId: tokenId,
          depositAmount: double.parse(amount),
          transferState: _onRampDepositStateFromJson(completed),
          transfers: transfers
              .map(
                (transfer) => _onRampTransferFromJson(
                  transfer as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      _ => throw FormatException(
          'Invalid JSON format for OnRampDeposit',
          json,
        ),
    };

OnRampTransfer _onRampTransferFromJson(Map<String, dynamic> json) =>
    switch (json) {
      {
        'fee': final String fee,
        'amount': final String amount,
        'steps': final List<dynamic> steps,
      } =>
        (
          fee: double.parse(fee),
          amount: double.parse(amount),
          steps: steps
              .map(
                (jsonStep) => _onRampTransferStepFromJson(
                  jsonStep as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      _ => throw FormatException(
          'Invalid JSON format for OnRampTransfer',
          json,
        ),
    };

OnRampTransferStep _onRampTransferStepFromJson(Map<String, dynamic> json) =>
    switch (json) {
      {
        'type': 'swap',
        'tx_hash': final String txHash,
        'tx_timestamp': final String txTimestamp,
        'tx_data': {'swap_uco_output_amount': final double swapUcoOutputAmount},
      } =>
        OnRampTransferStepSwap(
          txHash: txHash,
          txTimestamp: DateTime.parse(txTimestamp),
          ucoAmount: swapUcoOutputAmount,
        ),
      {
        'type': 'debit',
        'tx_hash': final String txHash,
        'tx_timestamp': final String txTimestamp,
      } =>
        OnRampTransferStepDebit(
          txHash: txHash,
          txTimestamp: DateTime.parse(txTimestamp),
        ),
      {
        'type': 'uco_transfer',
        'tx_hash': final String txHash,
        'tx_timestamp': final String txTimestamp,
      } =>
        OnRampTransferStepUcoTransfer(
          txHash: txHash,
          txTimestamp: DateTime.parse(txTimestamp),
        ),
      _ => throw FormatException(
          'Invalid JSON format for OnRampTransferStep',
          json,
        ),
    };

OnRampEvent _onRampEventFromJson(Map<String, dynamic>? json) => switch (json) {
      {
        'event_type': 'DEPOSIT_UPDATE',
        'deposit': final Map<String, dynamic> jsonTransfer
      } =>
        OnRampDepositUpdateEvent(_onRampDepositFromJson(jsonTransfer)),
      _ => throw FormatException(
          'Invalid JSON format for OnRampEvent',
          json,
        ),
    };
