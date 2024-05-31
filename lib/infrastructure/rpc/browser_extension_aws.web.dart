// ignore_for_file: avoid_web_libraries_in_flutter, avoid_print

import 'dart:async';
import 'dart:js';

import 'package:aewallet/infrastructure/rpc/awc_json_rpc_server.dart';
import 'package:aewallet/infrastructure/rpc/browser_extension_aws.js.dart';
import 'package:stream_channel/stream_channel.dart';

class BrowserExtensionAWS {
  BrowserExtensionAWS() {
    print('[AWCBrowserExtension] Init');
    _interopConnectionReceived = allowInterop(_connectionReceived);
  }
  static const logName = 'Browser RPC Server';

  static bool get isPlatformCompatible => isWebBrowserExtension;

  bool _isRunning = false;

  final Set<AWCJsonRPCServer> _peerServers = {};

  late Function(BrowserExtensionPort port) _interopConnectionReceived;
  void _connectionReceived(BrowserExtensionPort port) {
    print('[AWCBrowserExtension] external connection received ');
    port.postMessage('connected');
    final channel = BrowserExtensionMessagePortStreamChannel(port: port);
    final peerServer = AWCJsonRPCServer(channel.cast<String>());
    _peerServers.add(peerServer);

    port.onDisconnect.addListener(allowInterop((_) async {
      print('[AWCBrowserExtension] external connection closed ');
      await peerServer.close();
      _peerServers.remove(peerServer);
    }));

    unawaited(peerServer.listen());
  }

  Future<void> run() async => runZonedGuarded(
        () async {
          if (_isRunning) {
            print('[AWCBrowserExtension] Already running. Cancel `start`');
            return;
          }

          print('[AWCBrowserExtension] Starting');

          onConnectExternal.addListener(_interopConnectionReceived);
          _isRunning = true;
        },
        (error, stack) {
          print(
            '[AWCBrowserExtension] failed : $error',
          );
        },
      );

  Future<void> stop() async {
    print('[AWCBrowserExtension] Stopping');
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
    print('Wallet Init WebMessage PortStreamchannel');

    port.onMessage.addListener(
      allowInterop((message, _) {
        if (message == null) return;
        print('Wallet message received $message');
        _in.add(message);
        print('Wallet message received done $message');
      }),
    );

    _out.onCancel = close;

    _outSubscription = _out.stream.listen((event) {
      print('Wallet response sent $event');
      port.postMessage(event);
    });
  }

  Future<void> close() async {
    print('Wallet releases port');
    _out.onCancel = null;
    await _outSubscription.cancel();
    await _out.close();
    port.disconnect();

    await _in.close();
    print('Wallet port release done');
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
