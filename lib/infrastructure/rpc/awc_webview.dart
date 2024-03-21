import 'dart:async';

import 'package:aewallet/infrastructure/rpc/awc_json_rpc_server.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stream_channel/stream_channel.dart';

class AWCWebview extends StatefulWidget {
  const AWCWebview({super.key, required this.uri});

  final Uri uri;

  @override
  State<AWCWebview> createState() => _AWCWebviewState();
}

class _AWCWebviewState extends State<AWCWebview> {
  AWCJsonRPCServer? peerServer;

  @override
  void dispose() {
    peerServer?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InAppWebView(
        onLoadStop: (controller, url) async {
          if (defaultTargetPlatform != TargetPlatform.android ||
              await WebViewFeature.isFeatureSupported(
                WebViewFeature.CREATE_WEB_MESSAGE_CHANNEL,
              )) {
            final port1 = await _initWebMessagePorts(controller);

            final channel = WebMessagePortStreamChannel(port: port1);
            peerServer = AWCJsonRPCServer(channel.cast<String>());

            await peerServer?.listen();
          }
        },
        onWebViewCreated: (controller) async {
          await controller.loadUrl(
            urlRequest: URLRequest(url: WebUri.uri(widget.uri)),
          );
        },
      );

  Future<WebMessagePort> _initWebMessagePorts(
    InAppWebViewController controller,
  ) async {
    controller.evaluateJavascript(
      source: """
var awc;
window.addEventListener('message', function(event) {
    if (event.data == 'capturePort') {
        if (event.ports[0] != null) {
            awc = event.ports[0];
        }
    }
}, false);
""",
    );
    final webMessageChannel = await controller.createWebMessageChannel();
    final port1 = webMessageChannel!.port1;
    final port2 = webMessageChannel.port2;

    // transfer port2 to the webpage to initialize the communication
    await controller.postWebMessage(
      message: WebMessage(data: 'capturePort', ports: [port2]),
      targetOrigin: WebUri('*'),
    );
    return port1;
  }
}

class WebMessagePortStreamChannel
    with StreamChannelMixin<String>
    implements StreamChannel<String> {
  WebMessagePortStreamChannel({required this.port}) {
    port.setWebMessageCallback((message) {
      if (message == null) return;
      _in.add(message.data);
    });

    _out.stream.listen((event) {
      port.postMessage(WebMessage(data: event));
    });
  }

  final WebMessagePort port;
  final _in = StreamController<String>(sync: true);
  final _out = StreamController<String>(sync: true);

  @override
  StreamSink<String> get sink => _out.sink;

  @override
  Stream<String> get stream => _in.stream;
}
