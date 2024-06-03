// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:js';

import 'package:aewallet/infrastructure/rpc/awc_json_rpc_server.dart';
import 'package:aewallet/infrastructure/rpc/browser_extension_aws.js.dart';
import 'package:logging/logging.dart';
import 'package:stream_channel/stream_channel.dart';

class BrowserExtensionAWS {
  BrowserExtensionAWS() {
    logger.info('Init');
    _interopConnectionReceived = allowInterop(_connectionReceived);
  }
  static final logger = Logger('Browser RPC Server');

  static bool get isPlatformCompatible => isWebBrowserExtension;

  bool _isRunning = false;

  final Set<AWCJsonRPCServer> _peerServers = {};

  late Function(BrowserExtensionPort port) _interopConnectionReceived;
  void _connectionReceived(BrowserExtensionPort port) {
    logger.info('external connection received');
    port.postMessage('connected');
    final channel = BrowserExtensionMessagePortStreamChannel(port: port);
    final peerServer = AWCJsonRPCServer(channel.cast<String>());
    _peerServers.add(peerServer);

    port.onDisconnect.addListener(
      allowInterop((_) async {
        logger.info('external connection closed');
        await peerServer.close();
        _peerServers.remove(peerServer);
      }),
    );

    unawaited(peerServer.listen());
  }

  Future<void> run() async => runZonedGuarded(
        () async {
          if (_isRunning) {
            logger.info('Already running. Cancel `start`');

            return;
          }
          logger.info('Starting');

          onConnectExternal.addListener(_interopConnectionReceived);
          _isRunning = true;
        },
        (error, stack) {
          logger.severe(
            'failed',
            error,
            stack,
          );
        },
      );

  Future<void> stop() async {
    logger.info('Stopping');
    _isRunning = false;
    onConnectExternal.removeListener(_interopConnectionReceived);
    for (final peerServer in _peerServers) {
      await peerServer.close();
    }
    _peerServers.clear();
  }
}

class BrowserExtensionMessagePortStreamChannel
    with StreamChannelMixin<String>
    implements StreamChannel<String> {
  BrowserExtensionMessagePortStreamChannel({required this.port}) {
    logger.info('Wallet Init WebMessage PortStreamchannel');

    port.onMessage.addListener(
      allowInterop((message, _) {
        if (message == null) return;
        logger.info('Wallet message received $message');

        _in.add(message);
        logger.info('Wallet message received done $message');
      }),
    );

    _out.onCancel = close;

    _outSubscription = _out.stream.listen((event) {
      logger.info('Wallet response sent $event');

      port.postMessage(event);
    });
  }

  static final logger = Logger('Browser RPC Server - StreamChannel');

  Future<void> close() async {
    logger.info('Wallet releases port');

    _out.onCancel = null;
    await _outSubscription.cancel();
    await _out.close();
    port.disconnect();

    await _in.close();
    logger.info('Wallet releases done');
  }

  final BrowserExtensionPort port;
  final _in = StreamController<String>(sync: true);
  late StreamSubscription _outSubscription;
  final _out = StreamController<String>(sync: true);

  @override
  StreamSink<String> get sink => _out.sink;

  @override
  Stream<String> get stream => _in.stream;
}
