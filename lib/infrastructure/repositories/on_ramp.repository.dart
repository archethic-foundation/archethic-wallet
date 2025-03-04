import 'dart:convert';
import 'dart:typed_data';

import 'package:aewallet/domain/models/app_wallet.dart';
import 'package:aewallet/domain/models/onramp.dart';
import 'package:aewallet/domain/repositories/on_ramp.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

part 'on_ramp.dto.dart';

class OnRampRepositoryImpl implements OnRampRepository {
  OnRampRepositoryImpl({
    required this.httpBaseUrl,
    required this.wsBaseUrl,
    required AppWallet wallet,
    required Account account,
  }) {
    keyPair =
        wallet.keychainSecuredInfos.services[account.name]!.keyPair!.toKeyPair;

    socket = PhoenixSocket(
      wsBaseUrl,
      socketOptions: PhoenixSocketOptions(
        dynamicParams: () async {
          final credentials = await _buildCredentials();

          return {
            'x-public-key': credentials.publicKey,
            'x-timestamp': credentials.timestamp.toString(),
            'x-signature': credentials.signature,
          };
        },
      ),
    );
  }

  final _logger = Logger('OnRampRepository');
  final String httpBaseUrl;
  final String wsBaseUrl;
  late final archethic.KeyPair keyPair;
  late final PhoenixSocket socket;

  Future<
      ({
        String publicKey,
        int timestamp,
        String signature,
      })> _buildCredentials() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final publicKey = keyPair.publicKey!;

    final payloadBuilder = BytesBuilder()
      ..add(publicKey)
      ..add(archethic.toByteArray(timestamp, length: 4));
    final signedPayload = archethic.sign(
      payloadBuilder.toBytes(),
      keyPair.privateKey,
      isDataHexa: false,
    );
    return (
      publicKey: base64.encode(publicKey),
      timestamp: timestamp,
      signature: base64.encode(signedPayload),
    );
  }

  @override
  Future<void> dispose() async {
    socket
      ..close()
      ..dispose();
  }

  @override
  Future<void> connect() async {
    if (socket.isConnected) return;
    await socket.connect();
  }

  @override
  Future<List<OnRampDeposit>> get depositsHistory async {
    final body = await _get('/deposits');

    return switch (body) {
      [] => [],
      [...] => body
          .map(
            (jsonDeposit) => _onRampDepositFromJson(
              jsonDeposit as Map<String, dynamic>,
            ),
          )
          .toList(),
      _ => throw Exception('Invalid response format'),
    };
  }

  @override
  Stream<OnRampEvent> get events async* {
    late PhoenixChannel? channel;
    try {
      final pubkey = base64.encode(keyPair.publicKey!);
      channel = socket.addChannel(topic: 'transfers:$pubkey');
      await channel.join().future;

      await for (final message in channel.messages) {
        try {
          yield _onRampEventFromJson(message.payload);
        } catch (e, stack) {
          _logger.warning(
            'Failed to convert notification `${jsonEncode(message.payload)}`',
            e,
            stack,
          );
        }
      }
    } finally {
      channel?.close();
    }
  }

  @override
  Future<num> get maxAmount async {
    final body = await _get('/max_amount');

    return switch (body) {
      {'data': final String amount} => archethic.fromBigInt(int.parse(amount)),
      _ => throw Exception('Invalid response format'),
    };
  }

  @override
  Future<String> get evmAddress async {
    final body = await _get('/evm_address');

    return switch (body) {
      {'data': final String address} => address,
      _ => throw Exception('Invalid response format'),
    };
  }

  Future<dynamic> _get(String path) async {
    final credentials = await _buildCredentials();

    final response = await http.get(
      Uri.parse('$httpBaseUrl$path'),
      headers: {
        'x-public-key': credentials.publicKey,
        'x-timestamp': credentials.timestamp.toString(),
        'x-signature': credentials.signature,
      },
    );

    return switch (response.statusCode) {
      200 => jsonDecode(response.body),
      400 =>
        throw Exception('Bad Request: Missing headers or invalid timestamp'),
      401 => throw Exception('Unauthorized: Invalid signature'),
      _ => throw Exception('Unexpected error: ${response.statusCode}')
    };
  }
}
