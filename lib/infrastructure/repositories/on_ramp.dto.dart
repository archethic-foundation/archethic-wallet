part of 'on_ramp.repository.dart';

OnRampTokenDisplayData _onRampEvmTokenDisplayFromJson(
  MapEntry<String, dynamic> jsonEntry,
) =>
    switch (jsonEntry.value) {
      {
        'svg_icon': final String svgIcon,
        'display_name': final String displayName,
      } =>
        (
          id: jsonEntry.key,
          name: displayName,
          svgIcon: svgIcon,
          symbol: jsonEntry.key,
        ),
      _ => throw FormatException(
          'Invalid JSON format for OnRampEvmTokenDisplayData',
          jsonEntry,
        ),
    };

OnRampChain _onRampEvmChainFromJson(
  MapEntry<String, dynamic> jsonEntry,
) {
  final available = jsonEntry.value['available'] as bool? ?? true;

  if (!available) {
    final tokens = (jsonEntry.value['tokens'] as Map<String, dynamic>?)
            ?.entries
            .map(_onRampEvmTokenFromJson)
            .toList() ??
        [];

    return (
      id: jsonEntry.key,
      chainId: 0,
      displayName: jsonEntry.value['display_name'] ?? '',
      feeRate: 0.0,
      svgIcon: jsonEntry.value['svg_icon'] ?? '',
      tokens: tokens,
      available: false,
    );
  }

  return switch (jsonEntry.value) {
    {
      'fee': final double fee,
      'chain_id': final int chainId,
      'svg_icon': final String svgIcon,
      'display_name': final String displayName,
      'tokens': final Map<String, dynamic> tokens,
    } =>
      (
        id: jsonEntry.key,
        chainId: chainId,
        displayName: displayName,
        feeRate: fee,
        svgIcon: svgIcon,
        tokens: tokens.entries.map(_onRampEvmTokenFromJson).toList(),
        available: available,
      ),
    _ => throw FormatException(
        'Invalid JSON format for OnRampEvmChain',
        jsonEntry,
      ),
  };
}

OnRampToken _onRampEvmTokenFromJson(MapEntry<String, dynamic> jsonEntry) =>
    switch (jsonEntry.value) {
      {
        'decimals': final int decimals,
        'address': final String address,
      } =>
        (
          id: jsonEntry.key,
          address: address.toLowerCase(),
          decimals: decimals,
        ),
      _ => throw const FormatException(
          'Invalid JSON format for OnRampEvmToken',
          json,
        ),
    };

OnRampDepositState _onRampDepositStateFromJson(bool json) => switch (json) {
      false => OnRampDepositState.processing,
      true => OnRampDepositState.completed,
    };

OnRampDeposit _onRampDepositFromJson(Map<String, dynamic>? json) =>
    switch (json) {
      {
        'deposit_id': final String depositId,
        'timestamp': final String timestamp,
        'tx_hash': final String txHash,
        'completed': final bool completed,
        'chain_id': final String chainId,
        'token_id': final String tokenId,
        'amount': final String amount,
        'transfers': final List transfers,
      } =>
        (
          id: depositId,
          depositDate: DateTime.parse(timestamp),
          depositTxHash: txHash.toLowerCase(),
          depositChainId: chainId,
          depositTokenId: tokenId,
          depositAmount: int.parse(amount),
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
          fee: int.parse(fee),
          amount: int.parse(amount),
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
        'tx_data': {'swap_uco_output_amount': final String swapUcoOutputAmount},
      } =>
        OnRampTransferStepSwap(
          txHash: txHash,
          txTimestamp: DateTime.parse(txTimestamp),
          ucoAmount: int.parse(swapUcoOutputAmount),
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

OnRampEvent _onRampEventFromJson(Message message) =>
    switch (message.event.value) {
      'NEW_DEPOSIT' ||
      'DEPOSIT_UPDATE' =>
        OnRampDepositUpdateEvent(_onRampDepositFromJson(message.payload)),
      _ => throw const FormatException(
          'Invalid JSON format for OnRampEvent',
          json,
        ),
    };

OnRampDepositsSnapshotEvent _onRampDepositSnapshotEventFromJson(
  List<dynamic> jsonDeposits,
) =>
    OnRampDepositsSnapshotEvent(
      jsonDeposits
          .map(
            (jsonDeposit) =>
                _onRampDepositFromJson(jsonDeposit as Map<String, dynamic>),
          )
          .toList(),
    );
