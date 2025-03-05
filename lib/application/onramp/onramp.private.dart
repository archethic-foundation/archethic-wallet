part of 'onramp.dart';

archethic.KeyPair _getKeyPair(LoggedInSession session) =>
    archethic.deriveKeyPair(
      archethic.uint8ListToHex(
        Uint8List.fromList(session.wallet.keychainSecuredInfos.seed),
      ),
      0,
    );

Future<
    ({
      String publicKey,
      int timestamp,
      String signature,
    })> _buildCredentials(LoggedInSession session) async {
  final keychainKeypair = _getKeyPair(session);

  final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  final publicKey = keychainKeypair.publicKey!;

  final payloadBuilder = BytesBuilder()
    ..add(publicKey)
    ..add(archethic.toByteArray(timestamp, length: 4));
  final signedPayload = archethic.sign(
    payloadBuilder.toBytes(),
    keychainKeypair.privateKey,
    isDataHexa: false,
  );
  return (
    publicKey: base64.encode(publicKey),
    timestamp: timestamp,
    signature: base64.encode(signedPayload),
  );
}

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
          depositDate:
              DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000),
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

@riverpod
({String httpBaseUrl, String wsBaseUrl}) _onRampBackendSetup(Ref ref) => (
      httpBaseUrl: 'http://localhost:4100/api/v1',
      wsBaseUrl: 'ws://localhost:4100/ws/websocket'
    );

@riverpod
Future<PhoenixSocket> _onRampSocket(Ref ref) async {
  late PhoenixSocket? socket;
  ref.onDispose(
    () {
      socket?.close();
      socket?.dispose();
    },
  );
  final wsBaseUrl = ref.watch(
    _onRampBackendSetupProvider.select(
      (setup) => setup.wsBaseUrl,
    ),
  );

  final session = ref.watch(sessionNotifierProvider).loggedIn!;
  socket = PhoenixSocket(
    wsBaseUrl,
    socketOptions: PhoenixSocketOptions(
      dynamicParams: () async {
        final credentials = await _buildCredentials(session);

        return {
          'x-public-key': credentials.publicKey,
          'x-timestamp': credentials.timestamp.toString(),
          'x-signature': credentials.signature,
        };
      },
    ),
  );
  await socket.connect();
  return socket;
}

@riverpod
Stream<OnRampEvent> _onRampEvents(Ref ref) async* {
  final socket = await ref.watch(_onRampSocketProvider.future);
  final session = ref.watch(sessionNotifierProvider).loggedIn!;

  late PhoenixChannel? channel;
  ref.onDispose(
    () {
      channel?.close();
    },
  );

  final keypair = _getKeyPair(session);
  final pubkey = base64.encode(keypair.publicKey!);
  channel = socket.addChannel(topic: 'transfers:$pubkey');
  await channel.join().future;

  yield* channel.messages.map((message) {
    try {
      return _onRampEventFromJson(message.payload);
    } catch (e) {
      print(e);
      return null;
    }
  }).whereNotNull();
}

@riverpod
Future<String> _onRampEVMAddress(Ref ref) async {
  final baseUrl = ref.watch(
    _onRampBackendSetupProvider.select(
      (value) => value.httpBaseUrl,
    ),
  );
  final session = ref.watch(sessionNotifierProvider).loggedIn!;
  final credentials = await _buildCredentials(session);

  final response = await http.get(
    Uri.parse('$baseUrl/evm_address'),
    headers: {
      'x-public-key': credentials.publicKey,
      'x-timestamp': credentials.timestamp.toString(),
      'x-signature': credentials.signature,
    },
  );

  final body = switch (response.statusCode) {
    200 => jsonDecode(response.body),
    400 => throw Exception('Bad Request: Missing headers or invalid timestamp'),
    401 => throw Exception('Unauthorized: Invalid signature'),
    _ => throw Exception('Unexpected error: ${response.statusCode}')
  };

  return switch (body) {
    {'data': final String address} => address,
    _ => throw Exception('Invalid response format'),
  };
}
