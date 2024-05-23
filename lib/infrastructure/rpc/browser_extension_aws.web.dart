import 'dart:async';
import 'dart:developer';
import 'dart:js';

import 'package:aewallet/infrastructure/rpc/awc_json_rpc_server.dart';
import 'package:aewallet/infrastructure/rpc/browser_extension_aws.js.dart';
import 'package:stream_channel/stream_channel.dart';

class BrowserExtensionAWS {
  static const logName = 'Browser RPC Server';

  static bool get isPlatformCompatible => isWebBrowserExtension;

  BrowserExtensionPort? _port;
  AWCJsonRPCServer? _peerServer;
  bool get isRunning => _peerServer != null;

  Future<void> run() async => runZonedGuarded(
        () async {
          if (isRunning) {
            print('[AWCBrowserExtension] Already running. Cancel `start`');
            return;
          }

          log('Starting', name: logName);

          final port = connect();
          print('[AWCBrowserExtension] Connected to web background service');
          final channel = BrowserExtensionMessagePortStreamChannel(port: port);
          _peerServer = AWCJsonRPCServer(channel.cast<String>());
          _port = port;
          await _peerServer?.listen();
        },
        (error, stack) {
          print(
            '[AWCBrowserExtension] failed : $error',
          );
        },
      );

  void stop() {
    _port?.disconnect();
    _peerServer?.close();
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
        print('Wallet message received ${message}');
        _in.add(message);
        print('Wallet message received done ${message}');
      }),
    );
    print('Wallet Init WebMessage PortStreamchannel 1 ');

    _out.stream.listen((event) {
      print('Wallet response sent ${event}');
      port.postMessage(event);
    });
    print('Wallet Init WebMessage PortStreamchannel 2');
  }

  final BrowserExtensionPort port;
  final _in = StreamController<String>(sync: true);
  final _out = StreamController<String>(sync: true);

  @override
  StreamSink<String> get sink => _out.sink;

  @override
  Stream<String> get stream => _in.stream;
}
